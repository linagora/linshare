# LinShare API Documentation
This guide provides a sample requests to LinShare guest V5 api.


To find the official documentation you can follow this [link](http://download.linshare.org/versions/).

## Moderator
### Create a moderator


**There are two cases of moderator creation:**  
If your user already exists in Linshare DB, you can identify him by his uuid :
```bash
curl -X POST 'http://{host}/linshare/webservice/rest/user/v5/guests/{guest_uuid}/moderators' \
    -u "login:password" \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Content-Type: application/json;' \
    -d '{
        "role": "SIMPLE",
        "guest": {
            "uuid": "f640366c-9f50-4ab5-b394-649b83291961"
        },
        "account": {
            "uuid": "4c53c6da-7d5e-4d61-b3d7-1b591bcedb22"
        }
    }'
```

If it not present, and you want to add an internal LDAP user as moderator, you can t give his email and domain uuid. The user will be fetched from the LDAP and inserted into the DB, and then be given his moderator role.

```bash
curl -X POST 'http://{host}/linshare/webservice/rest/user/v5/guests/{guest_uuid}/moderators' \
    -u "login:password" \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Content-Type: application/json;' \
    -d '{
        "role": "SIMPLE",
        "guest": {
            "uuid": "f640366c-9f50-4ab5-b394-649b83291961"
        },
        "account": {
            "email": "nick.derbies@linshare.org",
            "domain": {
                "uuid": "f25da91a-ae61-498e-8b47-29df51798be8"
            }
        }
    }'
```

**Restrictions:**  
Note that _"role"_ and _"guest.uuid"_ are mandatory. And either _"account.uuid"_ or the (_"account.domain.uuid"_, _"account.email"_) pair must be set (in case both are present, account uuid will be tried first).  

"role" can be :
* __"SIMPLE"__ for a simple moderator
* __"ADMIN"__ for an administrator moderator

To be allowed to create a moderator, requesting user must be _linshare administrator_, _linshare superadministrator_ or _current guest administrator moderator_.