# LinShare ADMIN API Documentation
This guide provides a sample requests to LinShare user V5 admin api.


To find the official documentation you can follow this [link](http://download.linshare.org/versions/),

## Users endpoint
Users api uses the following users data transfer object, represented in this document by `<userDto>`. 
```json
{
  "uuid": "58746f9b-b932-4085-84fa-2dd4c86dd01e",
  "firstName": "Robert",
  "lastName": "Testeur",
  "mail": "rob.test@linshare.org",
  "role": "SIMPLE",
  "canUpload": true,
  "canCreateGuest": true,
  "accountType": "INTERNAL",
  "restricted": false,
  "quotaUuid": "28901f9b-b932-4085-84fa-2dd4c86dd01e",
  "domain": {
    "uuid": "f25da91a-ae61-498e-8b47-29df51798be8",
    "name": "top1"
  },
  "externalMailLocale": "ENGLISH",
  "locked": false,
  "secondFAUuid": "0470f354-85b3-45ca-b9d6-36601116cdac",
  "secondFAEnabled": false,
  "creationDate": "2023-04-05T12:59:56.935Z",
  "modificationDate": "2023-04-05T12:59:56.935Z",
  "expirationDate": "2023-04-05T12:59:56.935Z",
  "comment": "petit commentaire",
  "author": {
    "uuid": "f5d8e7d5-b932-4085-84fa-2dd4c86dd01e",
    "name": "auteur",
    "email": "jacques.auteur@linshare.org",
    "domain": {
      "uuid": "f25da91a-ae61-498e-8b47-29df51798be8",
      "name": "top1"
    }
  }
}
```
Note: "secondFAUuid", "secondFAEnabled", "creationDate", "modificationDate", "expirationDate", "comment" and "author" fields are ignored as input.

### Create user
Following request allows to create a user in Lishares database.
```bash
curl -X POST 'http://<host>/linshare/webservice/rest/admin/v5/users' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto> 
```
* Mandatory fields are "**mail**", "**domain**" and "**role**".
* "**uuid**" field is ignored.
* A superadmin can create in any domain
* A nested admin can only create in a domain he manages
* Already existing users (same mail on this domain) will not be edited

### Edit user
Following request allows to update a user in Lishares database.
```bash
curl -X PUT 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto>
```
* Mandatory fields are "**uuid**", "**domain**", "**role**", "**locked**" and "**externalMailLocale**".
* "**uuid**" field can be used either from path or payload object.
* "**mail**", "**domain**" and "**secondFAUuid**"/"**secondFAEnabled**" fields are not updatable.
* Empty fields are not modified in the database.
* A root admin can update in any domain
* A nested admin can only update in domains he manages
* Update action cannot create a new database entry.

### Delete user
Following request allows to delete a user in Lishares database.
```bash
curl -X DELETE 'http://<host>/linshare/webservice/rest/admin/v5/users' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto>
```
Alternatively :
```bash
curl -X DELETE 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" 
```

* "**uuid**" field is mandatory and can be used either from path or payload object.
* It is not mandatory to send an object
* A root admin can delete in any domain
* A nested admin can only delete in domains he manages

### Get user
Following request allows to get a user in Lishares database.
```bash
curl -X GET 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" 
```
* "**uuid**" field is mandatory.
* A root admin can get in any domain
* A nested admin can only get in domains he manages


### Get multiple users
Following request allows get an ordered user list from Linsgare database, with criteria based filtering. 
```bash
curl -G 'http://<host>/linshare/webservice/rest/admin/v5/users' \
-u "login:password" \
-d "domains:<domainsUuids>" \
-d "domain:<domainUuid>" \ 
-d "sortOrder:<sortOrder>" \ 
-d "sortField:<sortField>" \ 
-d "mail:<mail>" \ 
-d "firstName:<firstName>" \ 
-d "lastName:<lastName>" \ 
-d "restricted:<restricted>" \ 
-d "canCreateGuest:<canCreateGuest>" \ 
-d "canUpload:<canUpload>" \ 
-d "role:<role>" \ 
-d "type:<type>" \ 
-d "moderatorRole:<moderatorRole>" \ 
-d "greaterThan:<greaterThan>" \ 
-d "lowerThan:<lowerThan>" \ 
-d "pageNumber:<pageNumber>" \ 
-d "pageSize:<pageSize>"
```

* There a no mandatory field
* "**domain**" field is deprecated.
* "**domains**" allows to restrict search to specific domains.
* **"sortOrder"** and **"sortField"** fields allows to order results (ascending by modification date by default)
* **"mail"**, **"firstName"**, **"lastName"**, **"role"** and **"type"** fields are strings, filtering matching users. **"type"** refers to account type (example: "INTERNAL", "GUEST").
* **"restricted"**, **"canCreateGuest"** and **"canUpload"** fields are booleans, filtering matching users.
* If at least one of the **"greaterThan"** or **"lowerThan"** is filled, only users with a moderator count within this range will match. In which case optional field "**moderatorRole**" can be used to restrict the search even further.
* **"pageNumber"** and **"pageSize"** fields allows to configure pagination, page 0 of 50 items by default.
* A root admin can get in any domain
* A nested admin can only get in domains he manages

### Get multiple users with autocomplete
Following request allows to get multiple users from a pattern.
```bash
curl -G 'http://<host>/linshare/webservice/rest/admin/v5/users/autocomplete/<pattern>' \
-u "login:password" \
-d 'accountType=<type>' \
-d 'domain=<domain-uuid>'
```

* "**pattern**" field is mandatory. Users with matching "mail", "firstName" or "lastName" will be returned.
* "**accountType**" is optional. Restricting search according to account type (example "INTERNAL", "GUEST")
* "**domain**" is optional. Restricting search to this specific domain. If empty every domain allowed for authentified user will be searched.
* Results are limited to 20 items.
* A root admin can get in any domain
* A nested admin can only get in domains he manages 

*Behavior*   
* If requestor is a guest : matching database contacts are returned.
* If requestor is internal :
  * we look for matching guest
  * we add matching internal users according to each domains user provider:
    * _LDAP_ : from ldap.
    * _OIDC_ : from database (+ ldap, if it is configured by `oidc.ldap.connectionUuid` and `oidc.ldap.provider.patternUuid` application properties).
    * _TWAKE_ & _TWAKE_GUEST_ : twake user provider endpoint is used.

