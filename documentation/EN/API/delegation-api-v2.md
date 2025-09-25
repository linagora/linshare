# LINSHARE  DELEGATION API

## 1. Get all document of a user

Following request allows to retrieve all documents owned by a delegated user (actor) using the technical account.

```bash
curl -X 'GET'  
 'https://<host>/linshare/webservice/rest/delegation/v2/{actoruuid}/documents' \
 - u "login:password" \
 - h 'accept: application/json'
```
* "actoruuid" is mandatory 

**Note**

* The technical account must have permission “List documents”
## 2. Get Audit Logs of a User

This request retrieves audit logs related to a specific user account (referred to by actorUuid). It supports filtering by action types, entry types, and date ranges.

```bash
curl -X 'GET'
 'https://<host>/linshare/webservice/rest/delegation/v2/audit/{actorUuid}?action={action}&type={type}&forceAll={forceAll}&beginDate={beginDate}&endDate={endDate}' \
-u "login:password" \
-H 'Accept: application/json'
```
**Path parameters:**
* actorUuid: mandatory - UUID of the user whose audit logs are being retrieved.

**Query parameters:**
* action: optional - Filter logs by actions : CREATE, UPDATE, DELETE, GET, DOWNLOAD, SUCCESS, FAILURE, PURGE
* type: optional - Filter logs by entry types: SHARE_ENTRY, DOCUMENT_ENTRY, GUEST, WORK_SPACE, WORK_SPACE_MEMBER, WORK_GROUP, WORKGROUP_MEMBER, WORKGROUP_FOLDER, WORKGROUP_DOCUMENT, WORKGROUP_DOCUMENT_REVISION, DOMAIN, USER, DOMAIN_PATTERN, GROUP_FILTER, WORKSPACE_FILTER, FUNCTIONALITY, CONTACTS_LISTS, CONTACTS_LISTS_CONTACTS, UPLOAD_REQUEST_GROUP, UPLOAD_REQUEST, UPLOAD_REQUEST_URL, UPLOAD_REQUEST_ENTRY, UPLOAD_PROPOSITION, ANONYMOUS_SHARE_ENTRY, AUTHENTICATION, USER_PREFERENCE, RESET_PASSWORD, SAFE_DETAIL, PUBLIC_KEY, JWT_PERMANENT_TOKEN, SHARED_SPACE_NODE, MAIL_ATTACHMENT, SHARED_SPACE_MEMBER, DRIVE_MEMBER, DRIVE, WORKGROUP, GUEST_MODERATOR
* forceAll: optional - If true, returns all audit entries for the user. Default is false.
* beginDate: optional - Start date for filtering logs 
* endDate: optional - End date for filtering logs 

## 3. Create a Document from a URL

This request creates a new document on behalf of a specific user (actor)by fetching it from a provided URL. The upload can be processed synchronously or asynchronously.

```bash
curl -X 'POST' \
  'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents?async={async}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d '{
  "url": "{uploaded file URL}",
  "fileName": "{file name}",
  "size": {file size}
}'
```
**Path parameters:**
* "actorUuid" field is mandatory

**Query parameters:**
* “async”: Set to true to enable asynchronous upload processing. Default: false.

**Request body**
* “url”, “fileName”, “size” are mandatory.

**Note**

* The technical account must have permission “Create document”
## 4. Get a document

This request retrieves the details of a single document by its unique identifier (UUID), provided the specified user (actor) has the necessary permissions to access it.
```bash
curl -X 'GET' \ 
 'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{documentUuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path parameters:**
* "actorUuid" , “documentUuid” are mandatory fields. 

**Note**

* The technical account must have permission Get document”

## 5. Update a document

This request updates the properties of a specific document. This endpoint is used to modify metadata such as the document's name or description.

To build a valid request body, you should provide an object, represented in this document by `<documentDto>`,with the following structure. Only include the fields you intend to update, but remember that PUT can reset fields that are not provided.
```json
{
  "uuid": "c8b16714-26d6-4292-86ea-308e6e3e9a6a",
  "name": "test document.png",
  "description": "",
  "creationDate": 1754305850709,
  "modificationDate": 1754370530004,
  "expirationDate": 1754392224898,
  "ciphered": false,
  "type": "image/png",
  "humanMimeType": "image",
  "size": 105143,
  "metaData": null,
  "sha256sum": "c408e6951a79d6b922c7c0d77ac5f8c36f2b939a55056a52c5c88e6e50426f7d",
  "hasThumbnail": true,
  "shared": 0,
  "shares": []
}
```

```bash
curl -X 'PUT' \  
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{documentUuid}' \
   -u "login:password" \
   -H 'accept: application/xml' \
   -H 'Content-Type: application/json' \
  - d <documentDto>
```
**Path parameters:**
* "actorUuid" , “documentUuid” are mandatory fields.

**Request body**
* Updatable fields are : “name”, “description”

**Note**

* The technical account must have permission "Update document”
## 6. Delete a document

This request will delete a specified document on behalf of a user (actor) 
```bash
curl -X 'DELETE' \  
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{documentUuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path parameters:**
* "actorUuid" , “documentUuid” are mandatory fields.

**Note**

* The technical account must have permission "Delete document”
## 7. Download a document
This request will download a specified document on behalf of a user (actor) 
```bash
curl -X 'GET' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{documentUuid} /download' \
  -u "login:password" \
  -H 'accept: */*'
```
**Path parameters:**
* "actorUuid" , “documentUuid” are mandatory fields.

**Note**

* The technical account must have permission "Donwload document”
## 8. Get Asynchronous Task Status

This endpoint is not for retrieving a document's details. Instead, it is a crucial utility for tracking the progress of an asynchronous task, such as a document upload from a URL

When you initiate an operation with the “async = true” parameter, the server immediately responds with an AsyncTask object containing a unique task UUID. You must then use that task UUID with this endpoint to poll for the job's status.
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{taskUuid}/async' \
  -u "login:password" \
  -H 'accept: application/json'
```
**Path parameters:**
* "actorUuid" , “taskUuid” are mandatory fields

**Note**

* The technical account must have permission "Find an asynchronous task”
## 9. Download thumbnail of a file
This request will downloads a thumbnail for a specific document.
```bash
curl -X 'GET' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/documents/{documentUuid}/{thumbnailkind}' \
 -u "login:password" \
 -H 'accept: */*'
```
**Path parameters:**
* "actorUuid" , “documentUuid”, “thumbnailkind” are mandatory fields
* “thumbnailkind” is thee desired size or type of the thumbnail. The values can be: thumbnailSMALL/ thumbnailMEDIUM/thumbnailLARGE/thumbnailPDF.

**Note**

* The technical account must have permission “Download thumbnail document”
## 10.  Get all guests
This request retrieves a list of all guest accounts that have been created by, or are otherwise accessible to, the specified user (actor)
```bash
curl -X 'GET' \
 'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/guests' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path parameters:**
-   "actorUuid" field is mandatory

**Note**

* The technical account must have permission “List guests”
## 11. Create a guest
Guests APIs use the following guest data transfer object, represented in this document by `<guestDto>`

```json
{
  "uuid": "f7289d0d-2a6f-48be-9bab-183f42e82e5a",
  "creationDate": 1754391084913,
  "modificationDate": 1754391085229,
  "locale": "ENGLISH",
  "externalMailLocale": "ENGLISH",
  "domain": "5ddfe979-05d8-41de-b381-e028351c4a52",
  "domainName": "Guest-top1",
  "firstName": "Carl",
  "lastName": "Carlson",
  "mail": "carl.carlson@linshare.org",
  "canUpload": false,
  "restricted": false,
  "comment": "",
  "expirationDate": 1759597199999,
  "restrictedContacts": [],
  "owner": {
    "uuid": "56b7bcc7-b1d6-4e03-aa09-f65733f0b474",
    "domain": "f3e778de-fa10-4c03-b88f-2a4383339d0b",
    "firstName": "TOTO",
    "lastName": "CURRY",
    "mail": "abbey.curry@linshare.org",
    "accountType": "INTERNAL",
    "external": false
  },
  "author": {
    "uuid": "56b7bcc7-b1d6-4e03-aa09-f65733f0b474",
    "name": "TOTO CURRY",
    "email": "abbey.curry@linshare.org",
    "domain": {
      "uuid": "f3e778de-fa10-4c03-b88f-2a4383339d0b",
      "name": "top1"
    }
  }
}
```

This endpoint allows you to provision a new guest user.
```bash
curl -X 'POST' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/guests' \
  -u "login:password" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '<guestDto>’
  ```
**Path Parameters**

-   "actorUuid" field is mandatory

**Request body**

The request body is mandatory and must contain a <guestDto> with the details for the new account.
- Mandatory fields are "mail", “ expirationDate”
- Fields like “uuid”, “creationDate”, “modificationDate”, “owner”, “author”  will be automatically generated by the server and should be omitted from your request body.

**Note**

* The technical account must have permission “Create guest”
## 12. Update a guest

This endpoint allows you to modify the attributes of an existing guest account. As a PUT request, this operation will replace the entire guest object with the data you provide in the request body. If you omit a field from your request that currently has a value (e.g., comment), the server may clear that field or reset it to a default
```bash
curl -X 'PUT' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/guests/{guestUuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d '<guestDto>’
```
**Path Parameters**

* "actorUuid", “guestUuid” are  mandatory fields.

**Request Body**

* The request body is mandatory and must contain a <guestDto> with the desired new values.
* Updatable fields are: firstName, lastName, expirationDate, canUpload, comment, locale, restricted

**Note**

* The technical account must have permission Update guest”
## 13. Delete a guest
This endpoint is used to remove a guest account.
```bash
curl -X 'DELETE' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/guests/{guestUuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d '<guestDto>’
```
**Path Parameters**
-   "actorUuid", “guestUuid” are  mandatory fields.

**Request Body**

The request body is mandatory and must contain a <guestDto>, which should contain the details of the guest you intend to delete.

**Note**

* The technical account must have permission Delete guest”
## 14. Get a Specific Guest
This request will retrieves the details of a single guest account using a flexible identifier, which can be either the guest's unique UUID or their email address.
```bash
curl -X 'GET' \  
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/guests/{identifier}?mail={boolean}' &domain={domainUuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* "actorUuid" field is mandatory.
* “identifier” is mandatory and can be the guest's UUID or their email address.

**Query parameters**
* “mail” : boolean: When set to true, this explicitly tells the server to treat the identifier as an email address. Default: false.
* “domain”: The UUID of a specific domain to search within. This field is optional.

**Note**

* The technical account must have permission "Get guest”
## 15. Find User'All Mailing Lists

This endpoint allows you to retrieves a complete list of all mailing lists (also known as contact lists) that are owned by or accessible to the specified user (actor).
```bash
curl -X 'GET' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* "actorUuid" field is mandatory.

**Note**
* The technical account must have permission “List mailing lists”
## 16. Update a Mailing List
This endpoint allows you to modify an existing mailing list. This is a PUT request, which means it replaces the entire resource. When you update a mailing list, you must provide the complete <MailingList> object in the request body.
```bash
curl -X 'PUT' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists'  \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <MailingList>
```
** Path Parameters**
* "actorUuid" field is mandatory.

**Note:** 
* To add a contact: You must send the entire existing list of contacts plus the new one.
* To remove a contact: You must send the entire list of contacts excluding the one you want to remove.
* If you send a request with only a new contact in the contacts array, all existing contacts on that list will be deleted.

**Note**
* The technical account must have permission "Update mailing lists”

## 17. Create a mailing list

This endpoint allows you to provision a new mailing list. 
```bash
curl -X 'POST' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <MailingList>
```
**Path Parameters**
* "actorUuid" field is mandatory.

**Request Body**

The request body is mandatory and must contain a <MailingList> object with the details for the new list.
* “identifier” is mandatory field: It is the name for the new mailing list.
* “public”: Set to true to make the list potentially visible to others. Default: false.

**Note**
* Server-generated fields like “uuid”, “domainId”, “domainLabel”, “owner” should be omitted from your request body. They will be automatically populated in the response.
* The technical account must have permission “Create mailing list”
## 18. Delete a mailing list

This endpoint is used to remove a mailing list from a user's account.
```bash
curl -X 'DELETE' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/xml' \
  -d <MailingList>
```
**Parameters**
* "actorUuid" field is mandatory.

**Request Body**
* The request body is mandatory and must contain a <MailingList> object.
* “uuid” is mandatory in <MailingList> object, it is the unique identifier of the mailing list you intend to delete.

**Note**
*  The technical account must have permission “Delete mailing list”
## 19. Find All Contacts in a Mailing List

This request will retrieves all contacts that are members of a specific mailing list.
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{uuid}/contacts' \
-u "login:password" \
-H 'accept: application/xml'
```
**Parameters**
* "actorUuid" field is mandatory.
* “uuid” is mandatory: It is the uuid of the mailing list whose contacts you want to retrieve.

**Note**
*  The technical account must have permission "Get mailing list”
## 20. Update a contact in a mailing list

Mailing list Contact APIs use the following MailingListContatct object, represented in this document by `<MaillingListContact>`
```json
 {
"mail": "string",
 "uuid": "string",
 "firstName": "string",
 "lastName": "string",
 "mailingListUuid": "string"
}
```
This endpoint allows you to modify the information of a specific contact in a mailing list: 
```bash
curl -X 'PUT' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts' \
   -u "login:password" \ 
   -H 'accept: application/xml' \
   -H 'Content-Type: application/json' \
   -d <MailingListContact>
```
**Path Parameters**
* "actorUuid" field is mandatory.
* “mailinglistUuid” is mandatory: It is the Uuid of the mailing list that contains the contact you want to update.

**Request Body** 

The request body is mandatory and must contain the `<MailingListContact>` object with the updated details, in which:
* “uuid”, “mail” are mandatory fields
* “uuid” is the unique identifier of the specific contact you intend to update.
* Updatable fields are: email, first name, last name

**Note**
*  The technical account must have permission "Update mailing list”
## 21. Create a contact in a mailing list

This endpoint allows you to add a new contact to an existing mailing list.
```bash
curl -X 'POST' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts' \
  -u "login:password" \ 
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <MailingListContact>
```
**Path Parameters**
-  "actorUuid" field is mandatory.
-   “mailinglistUuid” is mandatory: It is the Uuid of the mailing list where the new contact will be added.

**Request Body**

The request body is mandatory and must contain a <MailingListContact> object with the details for the new contact, in which:
* “mail” is mandatory
* “firstName”, “lastName” are optional
* The uuid field for the contact should be omitted from the request body, as the server will generate a unique UUID for the new contact upon creation.

**Note**
*  The technical account must have permission "Update mailing list”
## 22. Delete a contact from a mailing list

This endpoint is used to remove a member from a mailing list.
``` bash
curl -X 'DELETE' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts' \
  -u "login:password" \ 
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <MailingListContact>
```
**Path Parameters**
* "actorUuid" field is mandatory.
* “mailinglistUuid” is mandatory: It is the Uuid of the mailing list from which the contact will be removed.

**Request Body**

The request body is mandatory and must contain a <MailingListContact> object with the details for the new contact, in which:
* “uuid” is mandatory field. It is the uuid of the contact you intend to remove from the mailing list.

**Note**
*  The technical account must have permission "Update mailing list”
## 23. Find a Specific Mailing List

This request will retrieve the complete details of a single mailing list by its unique identifier (UUID).
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts' \
  -u "login:password" \ 
  -H 'accept: application/xml'
```
**Path Parameters**
-  "actorUuid" field is mandatory.
-   “mailinglistUuid” is mandatory: It is the Uuid of the mailing list to retrieve

**Note**
*  The technical account must have permission "Get mailing list”
## 24. Delete a Specific Mailing List

This request will permanently deletes a single, specific mailing list and all of its associated contacts. 
```bash
curl -X 'DELETE' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts' \
   -u "login:password" \ 
   -H 'accept: application/xml'
```
**Path Parameters**
* "actorUuid" field is mandatory.
* “mailinglistUuid” is mandatory: It is the Uuid of the mailing list you intend to remove

**Note**
*  The technical account must have permission "Delete mailing list”
## 25. Delete a Specific Contact from a Mailing List

This request will permanently removes a single, specific contact from a specific mailing list. Both the mailing list and the specific contact to be removed are identified by their UUIDs directly in the URL path.
```bash
curl -X 'DELETE' \
'https://<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/lists/{mailinglistUuid}/contacts/{ContactUuid}' \
-u "login:password" \ 
-H 'accept: application/xml'
```
**Path Parameters**
* "actorUuid, “mailinglistUuid”, “contactUuid” fields are mandatory.

**Note**
*  The technical account must have permission "Update mailing list”
## 26. Get All MIME Types

This request will retrieves a list of all MIME types that are configured and recognized by the LinShare system.
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/mime_types?disabled={boolean}' \
-u "login:password" \ 
-H 'accept: application/xml'
```
**Path Parameters**
* "actorUuid" field is mandatory.

**Quey Parameters**
* “disabled”: boolean. If set to true, the response will include MIME types that are currently disabled in the system configuration. By default (false), only enabled MIME types are returned.
## 27. Get quota information

This request retrieves the storage quota details for a specific account or resource (such as a user account or a workgroup).
```bash
curl -X 'GET' \  
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/quota/{quotaUuid}' \
   -u "login:password" \ 
   -H 'accept: application/json'
```
**Path Parameters**
* "actorUuid", “quotaUuid” are mandatory fields
* “quotaUuid” is the unique identifier of the account or resource whose quota information is to be retrieved.
## 28. Find a share entry group

This request retrieves the details of a single "Share Entry Group" by its unique identifier (UUID).
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/share_entry_group/{ShareEntryGroupUuid}?full={boolean}' \
-u "login:password" \ 
-H "accept: application/xml"
```
**Path Parameters**
* "actorUuid", “ShareEntryGroupUuid” are mandatory fields

**Query parameters**
* “full”: boolean: If set to true, the response will include the detailed list of all individual Share objects within the share entry group. Default: false. 

**Note**

* The technical account must have permission “Get a share entry groups”
## 29. Update a share entry group
Share entry group APIs use the following ShareEntryGroup object, represented in this document by `<ShareEntryGroup>`:
```json
  {
    "owner": {
      "uuid": "string",
      "creationDate": "2025-08-07T10:16:14.721Z",
      "modificationDate": "2025-08-07T10:16:14.721Z",
      "locale": "ENGLISH",
      "externalMailLocale": "ENGLISH",
      "domain": "string",
      "domainName": "string",
      "secondFAUuid": "string",
      "secondFAEnabled": true,
      "secondFARequired": true,
      "locked": true
    },
    "uuid": "string",
    "subject": "string",
    "notificationDate": "2025-08-07T10:16:14.721Z",
    "creationDate": "2025-08-07T10:16:14.721Z",
    "modificationDate": "2025-08-07T10:16:14.721Z",
    "notified": true,
    "processed": true,
    "expirationDate": "2025-08-07T10:16:14.721Z",
    "shareEntriesDto": [
      {
        "uuid": "string",
        "name": "string",
        "creationDate": "2025-08-07T10:16:14.721Z",
        "modificationDate": "2025-08-07T10:16:14.721Z",
        "expirationDate": "2025-08-07T10:16:14.721Z",
        "downloaded": 0,
        "document": {
          "uuid": "string",
          "name": "string",
          "description": "string",
          "creationDate": "2025-08-07T10:16:14.721Z",
          "modificationDate": "2025-08-07T10:16:14.721Z",
          "expirationDate": "2025-08-07T10:16:14.721Z",
          "ciphered": true,
          "type": "string",
          "humanMimeType": "string",
          "size": 0,
          "metaData": "string",
          "sha256sum": "string",
          "hasThumbnail": true,
          "shared": 0,
          "async": {
            "uuid": "string",
            "status": "string",
            "errorMsg": "string",
            "errorName": "string",
            "errorCode": 0,
            "frequency": 0,
            "fileName": "string",
            "resourceUuid": "string",
            "creationDate": "2025-08-07T10:16:14.721Z",
            "modificationDate": "2025-08-07T10:16:14.721Z",
            "transfertDuration": 0,
            "waitingDuration": 0,
            "processingDuration": 0
          },
          "shares": [
            "string"
          ],
          "owner": {
            "uuid": "string",
            "domain": "string",
            "firstName": "string",
            "lastName": "string",
            "mail": "string",
            "accountType": "INTERNAL",
            "external": true
          }
        },
        "recipient": {
          "uuid": "string",
          "domain": "string",
          "firstName": "string",
          "lastName": "string",
          "mail": "string",
          "accountType": "INTERNAL",
          "external": true
        },
        "description": "string",
        "sender": {
          "uuid": "string",
          "creationDate": "2025-08-07T10:16:14.721Z",
          "modificationDate": "2025-08-07T10:16:14.721Z",
          "locale": "ENGLISH",
          "externalMailLocale": "ENGLISH",
          "domain": "string",
          "domainName": "string",
          "secondFAUuid": "string",
          "secondFAEnabled": true,
          "secondFARequired": true,
          "locked": true,
          "firstName": "string",
          "lastName": "string",
          "mail": "string",
          "role": "string",
          "canUpload": true,
          "canCreateGuest": true,
          "accountType": "string",
          "restricted": true,
          "comment": "string",
          "expirationDate": "2025-08-07T10:16:14.721Z",
          "restrictedContacts": [
            "string"
          ],
          "quotaUuid": "string",
          "authWithOIDC": true
        },
        "size": 0,
        "type": "string",
        "humanMimeType": "string",
        "ciphered": true,
        "hasThumbnail": true,
        "message": "string"
      }
    ]
  }
  ```
Follow this request to update the properties of an existing Share Entry Group:
```bash
curl -X 'PUT' \
' https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/share_entry_group/{ShareEntryGroupUuid}' \
-u "login:password" \ 
-H 'accept: application/json
-d < ShareEntryGroup>
```
**Path Parameters**
* "actorUuid", “ShareEntryGroupUuid” are mandatory fields

**Request Body**
* The request body is mandatory and must contain the <ShareEntryGroup> object with the updated details. 
## 30. Delete a share entry group
This endpoint is used to remove a share entry group, which acts as a container for shares that were sent together. Deleting the group effectively deletes the shares within it, making them inaccessible to the recipients.
```bash
curl -X 'DELETE' \ 
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/share_entry_group/{ShareEntryGroupUuid}' \
  -u "login:password" \ 
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and : “ ShareEntryGroupUuid” are mandatory field 

**Note**
* The technical account must have permission “Get a share entry groups” and "Delete share entry groups"
## 31. Find All Share Entry Groups for a User
Follow this request to retrieve a list of all share entry groups for a user
```bash
curl -X 'GET' \
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/share_entry_group?full=false' \
- u "login:password" \ 
- H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory

**Query Parameters**
* “full”: boolean: If set to true, the response will include the complete details for each individual share entry within the shareEntriesDto array. If false or (the default), a more lightweight representation of the shares will be returned.

**Note**
* The technical account must have permission “Get a share entry groups” and "List share entry groups"
## 31. Create a share
Share creation API use the following Share Creation object, represented in this document by `<ShareCreationDto>`:
```json
{
  "ShareCreationDto": {
    "GenericUser": {
      "uuid": "string",
      "domain": "string",
      "firstName": "string",
      "lastName": "string",
      "mail": "string",
      "accountType": "INTERNAL",
      "external": true
    },
    "documents": "string",
    "secured": true,
    "creationAcknowledgement": true,
    "forceAnonymousSharing": true,
    "expirationDate": "2025-08-11T11:01:09.628Z",
    "subject": "string",
    "message": "string",
    "notificationDateForUSDA": "2025-08-11T11:01:09.628Z",
    "enableUSDA": true,
    "sharingNote": "string",
    "mailingListUuid": "string",
    "inReplyTo": "string",
    "references": "string",
    "externalMailLocale": "ENGLISH"
  }
}
```
Follow this request to share file with other users 
```bash
curl -X 'POST' \
'https://<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shares' \
 - u “login:password" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d < ShareCreationDto>
```
**Path Parameters**
* “actorUuid” is mandatory

**Request Body**
* The request body must contain a <ShareCreationDto> object with the details of the share to be created.
* “documents” is an array of document UUIDs for the files that are to be shared. It is mandatory field
* ”recipients”/”mailingListUuid”: At least one of these fields must be provided.

**Note**
* The technical account must have permission “Create a share entry"
## 32. Find all shared space members
This request will retrieve a list of all shared spaces (Workspaces, Workgroups) that a specific user is a member of.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_members' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory
## 33. Create a shared space members
This API uses the following Shared Space Member Work Space object, represented in this document by `<SharedSpaceMemberWorkSpace>`:
```json
{
  "uuid": "string",
  "SharedSpace": {
    "uuid": "string",
    "name": "string",
    "parentUuid": "string",
    "nodeType": "DRIVE",
    "role": {
      "uuid": "string",
      "name": "string"
    },
    "creationDate": "2025-08-14T04:05:53.478Z",
    "modificationDate": "2025-08-14T04:05:53.478Z",
    "domainUuid": "string"
  },
  "role": {
    "uuid": "string",
    "name": "string",
    "type": "DRIVE"
  },
  "SharedSpaceAccount": [
    {
      "uuid": "string",
      "name": "string",
      "firstName": "string",
      "lastName": "string",
      "mail": "string",
      "accountType": "INTERNAL"
    },
    {
      "uuid": "string",
      "name": "string",
      "firstName": "string",
      "lastName": "string",
      "mail": "string",
      "accountType": "INTERNAL"
    }
  ],
  "creationDate": "2025-08-14T04:05:53.478Z",
  "modificationDate": "2025-08-14T04:05:53.478Z",
  "nested": true,
  "type": "DRIVE",
  "nestedRole": {
    "uuid": "string",
    "name": "string",
    "type": "DRIVE"
  },
  "belongingToWorkSpace": true
```
Follow this request is used to add a specified user as a member to a shared space and assigns them a specific role.
```bash
curl -X 'POST' \
  'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_members' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <SharedSpaceMemberWorkSpace>
```
**Path Parameters**
* “actorUuid” is mandatory

**Request body**
* The request body must contain a `<SharedSpaceMemberWorkSpace>` object detailing the membership to be created, in which : “node.uuid” , “role.uuid” and “account.uuid” are mandatory. Other fields are either ignored or managed by the server.
* “node.uuid” is the UUID of the shared space to which the user is being added.
* “role.uuid” is the UUID of the role that will be assigned to the new member.
* “account.uuid” is the UUID of the user account being added as a member.


**Note**
* The technical account must have permission “Get shared space node ”, "Create shared space permissions", "Get shared space role ", "List shared space role" 
## 34. Find a shared space member
This request is to retrieves the details of a single shared space membership by its unique identifier.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_members/{uuid}' \
 -u "login:password" \
 -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory
* “uuid” is the the unique identifier of the SharedSpaceMember resource (the membership record) to retrieve and is mandatory

**Note**
* The technical account must have permission “Get shared space node ”, "Get shared permissions" 
## 35. Update a shared space member
This request is to update an existing shared space membership, primarily to change a user's role and control how that change propagates to nested spaces.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_members/{uuid}?force={boolean}&propagate={boolean}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d  <SharedSpaceMemberWorkSpace>
```
**Path Parameters**
* “actorUuid” is mandatory
* “uuid” is the the unique identifier of the SharedSpaceMember resource (the membership record) to update and is mandatory

**Query Parameters**
* “propagate”: boolean. Default: true, the role will be updated in the current node and propagated on nested workgroups which are not updated manually, else if it is false the role will be updated just in current node
* “force”:  boolean. Default: false, the role will be updated just in the current node, else if it is true we will force the new updated role in all nested nodes

**Request body**
* The request body must contain a <SharedSpaceMemberWorkSpace> object, in which: “role.uuid”-  the UUID of the new role is mandatory.

**Note**
* The technical account must have permission “Get shared space permissions”, "Update shared node permissions", "List shared space role", "Get shared space role"
## 36. Delete a shared space member
This request is to permanently removes a user's membership from a specific shared space.
```bash
curl -X 'DELETE' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_members/{uuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/xml' \
```
**Path Parameters**
* “actorUuid” is mandatory
* “uuid” is the the unique identifier of the SharedSpaceMember resource (the membership record) to update and is mandatory

**Note**
* The technical account must have permission Delete shared space permissions”
## 37. Get all shared space nodes
This request is to retrieve a list of shared space nodes (Workspaces, and Workgroups) that are visible to a specific user. 
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_spaces?withRole={boolean}&parent={ParentUuid}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory

**Query Parameters**
* “parent”: The UUIDof the parent node. If provided, the endpoint returns only the direct children of this parent. If omitted, it returns the top-level nodes (Workspaces) that the user has access to.
* To get the children of a node: By providing the parent UUID, you can retrieve the nodes directly inside it (fetching all Workgroups within a Workspace).
* “withRole”: boolean. Default: false. If set to true, the response for each node will include a role object detailing the actorUuid's specific role within that node.

**Note**
* The technical account must have permission "List shared space node". 
## 38. Create a shared space nodes
This API uses the following Shared Space Node object, represented in this document by `<SharedSpaceNode>`:
```json 
{
  "uuid": "string",
  "name": "string",
  "parentUuid": "string",
  "nodeType": "DRIVE",
  "creationDate": "2025-08-16T14:33:34.286Z",
  "modificationDate": "2025-08-16T14:33:34.286Z",
  "versioningParameters": {
    "enable": true
  },
  "quotaUuid": "string",
  "description": "string",
  "role": {
    "uuid": "string",
    "name": "string"
  },
  "lastAuditEntry": {
    "uuid": "string",
    "authUser": {
      "firstName": "string",
      "lastName": "string",
      "name": "string",
      "mail": "string",
      "uuid": "string",
      "role": "SIMPLE",
      "accountType": "INTERNAL",
      "domain": {
        "uuid": "string",
        "label": "string"
      }
    },
    "resourceUuid": "string",
    "action": "CREATE",
    "cause": "COPY",
    "fromResourceUuid": "string",
    "type": "SHARE_ENTRY",
    "creationDate": "2025-08-16T14:33:34.286Z",
    "actor": {
      "firstName": "string",
      "lastName": "string",
      "name": "string",
      "mail": "string",
      "uuid": "string",
      "role": "SIMPLE",
      "accountType": "INTERNAL",
      "domain": {
        "uuid": "string",
        "label": "string"
      }
    }
  },
  "author": {
    "uuid": "string",
    "name": "string",
    "firstName": "string",
    "lastName": "string",
    "mail": "string",
    "accountType": "INTERNAL"
  },
  "domainUuid": "string"
}
```
Follow this request to create a new workspace/workgroup
```bash
curl -X 'POST' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_spaces' \
 -u "login:password" \
 -H 'accept: application/xml' \
 -H 'Content-Type: application/json' \
 -d < SharedSpaceNode>
```
**Path Parameters**
* “actorUuid” is mandatory

**Request body**
* The request body must contain a <SharedSpaceNode> object with the details of the space to be created, in which:
* “name” is mandatory
* “nodeType” is mandatory. Allowed values: WORK_SPACE, WORK_GROUP
* “parentUuid”: The UUID of the parent WORK_SPACE under which this new Workgroup will be created. Obmit for WORK_SPACE or when you want to create a standalone workgrop – which is not under any workspace.

**Note**
* The technical account must have permission "Create shared space node", "Create shared space permissions", "Get shared space role", "List shared space role". 
## 39. Find a shared space nodes
This endpoint is to retrieves the detailed information for a single shared space node 
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_spaces/{SharedSpaceNodeUuid}?withRole={boolean}&lastUpdater={boolean}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ SharedSpaceNodeUuid” are mandatory fields

**Query parameters**
* “withRole”: boolean. Default: false. If set to true, the response will include the role of the actor
* “lastUpdater”:  boolean. Default: false. If set to true, the response will include a lastAuditEntry object containing the audit log entry for the last modification made to this resource.

**Note**
* The technical account must have permission "Get shared space node". 
## 39. Update a shared space nodes
Following request allows to update the properties of an existing shared space node by replacing its entire state with the provided data.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_spaces/{SharedSpaceNodeUuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <sharedSpaceNode>
```
**Path Parameters**
* “actorUuid” and “ SharedSpaceNodeUuid” are mandatory fields

**Request body**
* The request body must contain a complete <SharedSpaceNode> object representing the desired new state of the resource, in which:
* Updateable fields are “name”, “description”

**Note**: Fields like uuid, nodeType, parentUuid, author, and creationDate are server-managed and cannot be changed via this method. 

**Note**
* The technical account must have permission "Get shared space node", "Update shared space node", "Get workgroup entry", "List workgroup entries", "Update workgroup entry"
## 40. Delete a shared space node
Following request allows to permanently deletes a shared space node (a Workspace or Workgroup) and all of its contents.
```bash
curl -X 'DELETE' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_spaces/{SharedSpaceNodeUuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <sharedSpaceNode>
```
**Path Parameters**
* “actorUuid” and “ SharedSpaceNodeUuid” are mandatory fields

**Request body**
* A request body containing the <SharedSpaceNode> object to be deleted is required, in which “Uuid” of the shared space node is required.
## 41. Update a shared space node 
The API uses a custom <PatchDto> object to specify which attribute to change:
```bash 
{
  "uuid": "string",
  "name": "string",
  "value": "string"
}
```
This endpoint provides a way to perform a partial update on a shared space node:
```bash
curl -X 'PATCH' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_nodes/{SharedSpaceNodeUuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d < PatchDto>
```
**Path Parameters**
* “actorUuid” and “ SharedSpaceNodeUuid” are mandatory fields

**Request body**

The request body must contain a PatchDto object specifying the field to update and its new value, in which:
* “name”: The name of the attribute to be updated. For example, "name" to change the node's title, or "versioningParameters.enable" to change versioning settings.
* “value”: The new value for the specified attribute. This should be a string representation (e.g., "New Workgroup Name" or "true").
* “uuid”: The UUID of the resource being updated. This is already specified in the URL path and can be obmited.
## 42. Find a shared space role
Following this request to retrieve the detailed information for a single shared space role by its unique identifier.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_roles/{RoleUuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ RoleUuid” are mandatory fields
## 43. Find all shared space roles
Follow this request to retrieve a list of all available shared space roles, which can be optionally filtered by the type of node they apply to (Workspace/Workgroup):
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_roles?nodeType={Node Type}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory field

**Query Parameters**
* “nodeType” is optional field. Filters the returned roles to only those that apply to the specified node type. Allowed values are:DRIVE; WORK_SPACE; WORK_GROUP. Default value is “WORK_GROUP”.
## 44. Get All Permissions for a Role
Following this request to retrieve a complete list of all permissions that are granted by a specific shared space role.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_roles/{RoleUuid}/permissions' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ RoleUuid” are mandatory fields
## 45. Find a Shared Space Role by Name
This endpoint provides a convenient way to look up a specific shared space role using its name.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/shared_space_roles/role/{RolenName}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ RoleName” are mandatory fields
## 46. Get Statistic Between two dates
This request will retrieve aggregated usage statistics for users, workgroups, or domains over a specified period.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/statistic?beginDate={BeginDate}&endDate={EndDate}&statisticType={StatisticType}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**

* “actorUuid” is mandatory

**Query Parameters**
* “statisticType” : Optional. Allowed values are: USER_DAILY_STAT; USER_WEEKLY_STAT;USER_MONTHLY_STAT; WORK_GROUP_DAILY_STAT; WORK_GROUP_WEEKLY_STAT; WORK_GROUP_MONTHLY_STAT; DOMAIN_DAILY_STAT; DOMAIN_WEEKLY_STAT; DOMAIN_MONTHLY_STAT
* “beginDate”, “endDate” are the start date and end date for the query range. They are optional fields
## 47. Delete a file in an upload request
This request is to delete a single file that was submitted to an upload request.
```bash
curl -X 'DELETE' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/upload_request_entries/{UploadRequestEntryUuid}' \
 -u "login:password" \
 -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “UploadRequestEntryUuid" (the Uuid of specific file to be deleted) are mandatory fields
## 48. Download a file in an upload request
This request is to download a single file that was submitted via an upload request.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/upload_request_entries/{UploadRequestEntryUuid}/download' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ UploadRequestEntryUuid” (the Uuid of specific file to be downloaded) are mandatory fields
## 49. Get Audit History for an Uploaded request entry
This request is to retrieve the complete audit trail (history of all actions) for a single file that was submitted to an upload request.

```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{ActorUuid}/upload_request_entries/{UploadRequestEntryUuid}/audit' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “ UploadRequestEntryUuid” (the Uuid of specific file) are mandatory fields
## 50. Add new recipients to an upload request
This request is to add one or more new recipients to an existing upload request group. 
```bash
curl -X 'POST' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{UploadRequestUuid}/recipients' \
 -u "login:password" \
 -H 'accept: application/xml' \
 -H 'Content-Type: application/json' \
 -d <ContactDto>
```
**Path Parameters**
* “actorUuid” and “ UploadRequestUuid” (the Uuid of the upload request) are mandatory fields
**Request Body**
* The request body must contain an array of `<ContactDto>` objects, where each object represents a new recipient to be added:
```json
[
  {
    "firstName": "string",
    "lastName": "string",
    "mail": "string"
  }
]
```
* “mail” is manatory field, “ firstName” and “ lastName” are optional.
## 51. Find All Upload Requests
This request will retrieve a list of all upload requests created by a specific user, with optional filtering by status.
```bash
curl -X 'GET' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups?status={status}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” is mandatory

**Query Parameters**
*  “status” is optional. It will filter the results to only include upload requests with a specific status. This parameter can be repeated to include multiple statuses. Allowed values are: DELETED; PURGED; ARCHIVED; CLOSED; ENABLED; CANCELED; CREATED
## 52. Create an Upload Request
This API uses the following Upload Request Creation object, represented in this document by `<UploadRequestCreationDto>`:
```json
{
  "activationDate": "2025-08-19T09:25:02.520Z",
  "expiryDate": "2025-08-19T09:25:02.520Z",
  "notificationDate": "2025-08-19T09:25:02.520Z",
  "label": "string",
  "contactList": [
    "string"
  ],
  "maxFileCount": 0,
  "maxDepositSize": 0,
  "maxFileSize": 0,
  "canDelete": true,
  "canClose": true,
  "body": "string",
  "protectedByPassword": true,
  "locale": "ENGLISH",
  "enableNotification": true,
  "canEditExpiryDate": true
}
```
Following  request allows to creates a new upload request. 
```bash
curl -X 'POST' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups?collectiveMode={boolean}' \
-u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <UploadRequestCreationDto>
```
**Path Parameters**
* “actorUuid” is mandatory

**Query Parameters**
* “collectiveMode” is mandatory:
collectiveMode=false (Individual Mode): A unique, private upload request and link are generated for each recipient.
collectiveMode=true (Collective Mode): A single, shared upload link is created that all recipients can use.

**Request Body**
* The request body must contain a complete UploadRequestCreationDto object.
## 53. Find an Upload Request
Following request allows to retrieve the complete details for an upload request  by its unique identifier.

```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{uploadrequestUuid}' \
 -u "login:password" \
 -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid” and “uploadrequestUuid” are mandatory fields.
## 54. Update an Upload Request
This request will update an existing upload request by replacing its current configuration with the data provided in the request body.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{uploadrequestUuid}?force={boolean}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <UploadRequestGroupDto>
```
**Path Parameters**
* “actorUuid” and “uploadrequestUuid” are mandatory fields.

**Query Parameters**
* “force”: This field is to control how updates are applied to child upload requests within the group: 
* false: (Default) Only updates child requests that have not been individually modified (i.e., they are "pristine").
* true:  Forces the update on all child upload requests, overwriting any individual modifications that may have been made to them.

**Request Body**
*  Request body must contain a complete UploadRequestGroupDto object.
```json
{
  "uuid": "string",
  "label": "string",
  "body": "string",
  "creationDate": "2025-08-20T08:38:37.763Z",
  "modificationDate": "2025-08-20T08:38:37.763Z",
  "maxFileCount": 0,
  "maxDepositSize": 0,
  "maxFileSize": 0,
  "activationDate": "2025-08-20T08:38:37.763Z",
  "notificationDate": "2025-08-20T08:38:37.763Z",
  "expiryDate": "2025-08-20T08:38:37.763Z",
  "canDelete": true,
  "canClose": true,
  "canEditExpiryDate": true,
  "locale": "ENGLISH",
  "protectedByPassword": true,
  "mailMessageId": "string",
  "enableNotification": true,
  "collective": true,
  "owner": {
    "uuid": "string",
    "domain": "string",
    "firstName": "string",
    "lastName": "string",
    "mail": "string",
    "accountType": "INTERNAL",
    "external": true
  },
  "domainDto": {
    "uuid": "string",
    "name": "string"
  },
  "status": "DELETED",
  "usedSpace": 0,
  "nbrUploadedFiles": 0
}
```
* Fields which are managed by server such as “uuid”; “owner”;“nbrUploadedFiles”; “domainDto”; “owner”, “ mailMessageId” are not updatable and will be ignored.
## 55. Get all traces for a nested Upload Request inside an individual Upload Request Group
This request will retrieve a detailed audit trail for a nested upload request, which is part of a individual upload request.

```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{UploadRequestGroupUuid/upload_requests/{UploadRequestUuid}/audit' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”**, “lUploadRequestGroupUuid” (individual upload request) and “UploadRequestUuid” (child upload request) are mandatory fields.

**Query Parameters**
* **“actions”**: Optional. Filters the results by the action performed. Can be specified multiple times. Allowed values include:CREATE,UPDATE, DELETE, GET, DOWNLOAD, SUCCESS, FAILURE, CONVERT, PURGE. 
* **“types”**: Optional. Filters the results by the type of resource that was affected. Can be specified multiple times. Relevant values for this endpoint include: SHARE_ENTRY, DOCUMENT_ENTRY, GUEST, WORK_SPACE, WORK_SPACE_MEMBER, WORK_GROUP, WORKGROUP_MEMBER, WORKGROUP_FOLDER, WORKGROUP_DOCUMENT, WORKGROUP_DOCUMENT_REVISION, DOMAIN, USER, DOMAIN_PATTERN, GROUP_FILTER, WORKSPACE_FILTER, FUNCTIONALITY, CONTACTS_LISTS, CONTACTS_LISTS_CONTACTS, UPLOAD_REQUEST_GROUP, UPLOAD_REQUEST, UPLOAD_REQUEST_URL, UPLOAD_REQUEST_ENTRY, UPLOAD_PROPOSITION, ANONYMOUS_SHARE_ENTRY, AUTHENTICATION, USER_PREFERENCE, RESET_PASSWORD, SAFE_DETAIL, PUBLIC_KEY, JWT_PERMANENT_TOKEN, SHARED_SPACE_NODE, MAIL_ATTACHMENT, SHARED_SPACE_MEMBER, DRIVE_MEMBER, DRIVE, WORKGROUP, GUEST_MODERATOR
## 56. Get Audit Trail for an Upload Request
This request will retrieve the audit trail for an entire upload request, detailing its lifecycle and associated events. The level of detail can be controlled with optional query parameters.
```bash
curl -X 'GET' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{UploadRequestGroupUuid}/audit' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”**, “UploadRequestGroupUuid” are mandatory fields.
* **“UploadRequestGroupUuid”** is the uuid of the upload request whose audit trail is to be retrieved.

**Query Parameters**

By default (with no query parameters), this endpoint returns a high-level overview. The audit trail will include events of the following types: UPLOAD_REQUEST_GROUP(only for individual upload request); UPLOAD_REQUESTUPLOAD_REQUEST_URL
* **“all”**: boolean. Default is “false”. If set true, it returns traces add to the default list UPLOAD_REQUEST_ENTRY audit types
* **“actions”**: Filters the results by the action performed. Can be specified multiple times. Available values : CREATE, UPDATE, DELETE, GET, DOWNLOAD, SUCCESS, FAILURE, CONVERT, PURGE
* **“types”**: Filter by type of resource's types. Can be specified multiple times. Available values : SHARE_ENTRY, DOCUMENT_ENTRY, GUEST, WORK_SPACE, WORK_SPACE_MEMBER, WORK_GROUP, WORKGROUP_MEMBER, WORKGROUP_FOLDER, WORKGROUP_DOCUMENT, WORKGROUP_DOCUMENT_REVISION, DOMAIN, USER, DOMAIN_PATTERN, GROUP_FILTER, WORKSPACE_FILTER, FUNCTIONALITY, CONTACTS_LISTS, CONTACTS_LISTS_CONTACTS, UPLOAD_REQUEST_GROUP, UPLOAD_REQUEST, UPLOAD_REQUEST_URL, UPLOAD_REQUEST_ENTRY, UPLOAD_PROPOSITION, ANONYMOUS_SHARE_ENTRY, AUTHENTICATION, USER_PREFERENCE, RESET_PASSWORD, SAFE_DETAIL, PUBLIC_KEY, JWT_PERMANENT_TOKEN, SHARED_SPACE_NODE, MAIL_ATTACHMENT, SHARED_SPACE_MEMBER, DRIVE_MEMBER, DRIVE, WORKGROUP, GUEST_MODERATOR
## 57. Find a list of Upload Requests
This endpoint allows you to inspect the individual components of an individual upload request. When an individual upload request is sent to multiple recipients, each recipient receives their own unique upload request link and session. This endpoint lists all of those individual sessions. 
If the upload request is collective, all recipients will receive the same upload request link. 
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{Uuid}/upload_requests' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “Uuid” are mandatory fields.
**Path Parameters**
* **“actorUuid”**, “UploadRequestGroupUuid” are mandatory fields.
* “uuid” is the unique identifier (UUID) of the parent UploadRequestGroup to inspect.


**Query Parameters**
* “status”: Optional.  To filter upload requests by status.Available values : DELETED, PURGED, ARCHIVED, CLOSED, ENABLED, CANCELED, CREATED
## 58. Update status of an upload request group
This request Updates the status of an entire upload request group, which cascades the change to all nested upload requests within it.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_request_groups/{Uuid}/status/{status}?copy={boolean}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”**, “uuid”, “status” are mandatory fields.
* Allowed values of “status” are:  DELETED, PURGED, ARCHIVED, CLOSED, ENABLED, CANCELED, CREATED

**Query Parameters**
* “copy”: Boolean. Default value is “false”. Set true if the owner wants to copy all documents and the upload request group is in archived status
## 59. Find upload request (which is nested upload request inside an individual upload request)
This endpoint is used to look up the details of a child upload request – which is inside an individual upload request
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_requests/{uuid}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”**, “uuid”are mandatory fields.
* “uuid” is the unique identifier of the nested Upload Request – inside an individual upload request to retrieve.
## 60. Update an upload request (which is nested upload request inside an individual upload request)
This request is to update an nested upload request – which is inside an individual upload request, by replacing its current configuration with the data provided in the request body.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_requests/{uuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <uploadRequestDto>
```

**Path Parameters**
* **“actorUuid”**, “uuid”are mandatory fields.
* “uuid” is the unique identifier of the nested Upload Request – inside an individual upload request to retrieve.
**Request Body**
The request body must contain a complete `<UploadRequestDto>` object:
```json
{
  "uuid": "string",
  "owner": {
    "firstName": "string",
    "lastName": "string",
    "mail": "string"
  },
  "recipients": [
    {
      "firstName": "string",
      "lastName": "string",
      "mail": "string"
    }
  ],
  "activationDate": "2025-08-22T10:39:09.535Z",
  "modificationDate": "2025-08-22T10:39:09.535Z",
  "creationDate": "2025-08-22T10:39:09.535Z",
  "expiryDate": "2025-08-22T10:39:09.535Z",
  "notificationDate": "2025-08-22T10:39:09.535Z",
  "label": "string",
  "status": "DELETED",
  "maxFileCount": 0,
  "maxDepositSize": 0,
  "maxFileSize": 0,
  "canDeleteDocument": true,
  "canClose": true,
  "body": "string",
  "pristine": true,
  "protectedByPassword": true,
  "usedSpace": 0,
  "locale": "ENGLISH",
  "enableNotification": true,
  "canEditExpiryDate": true,
  "collective": true,
  "nbrUploadedFiles": 0,
  "closed": true
}
```
* Fields which are managed by server such as “uuid”; “owner”; “nbrUploadedFiles”; “owner”, are not updatable and will be ignored.
## 61. Update Status of an Nested Upload Request
This request is to change the status of an nested upload request – which is inside an individual upload request

```bash
 curl -X 'PUT' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/upload_requests/{uuid}/status/{status}?copy={boolean}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”**, “uuid”, “status” are mandatory fields.
* “uuid” is the unique identifier of the nested Upload Request – inside an individual upload request to retrieve.
* Allowed values of “status”: DELETED, PURGED, ARCHIVED, CLOSED, ENABLED, CANCELED, CREATED

**Query Parameters**
* “copy” : boolean. This field is optional. Default value is “false”. Only relevant when the new status is ARCHIVED. If set to true, all documents that were uploaded to this request will be copied to the owner's Myspace.
## 62. Find all the user's information from the given uuid
This request will retrieve the complete profile and information for a single user by their unique identifier (UUID).
```bash
curl -X 'GET' \
'https://user.linshare-6-4-on-commit.integration-linshare.org/linshare/webservice/rest/delegation/v2/users/details/{actorUuid}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* **“actorUuid”** is mandatory.
## 63. Looking for user LinShare account, if it does not exists it will be created from ldap directories
This request is to find a user by their email and domain. If the user does not exist in the LinShare database, it will be created from LDAP directories 
```bash
curl -X 'POST' \
   'https://user.linshare-6-4-on-commit.integration-linshare.org/linshare/webservice/rest/delegation/v2/users/details' \
-u "login:password" \
 -H 'accept: application/xml' \
-H 'Content-Type: application/json' \
-d <UserDetailsDto>
```
**Request Body**
* The request body must contain a `<UserDetailsDto>` object specifying the user to find or create:
```json
{
  "mail": "string",
  "domain": "string"
}
```
* “mail” is mandatory: The primary email address of the user to look up.
* “domain” is optional: The UUID of the user's domain.

The process is as follows:
1. The API searches the local LinShare database for a user matching the provided mail (and domain, if specified).
2. If a user is found: It returns the full details of that existing user.
3. If no user is found: It queries the LDAP directories:
If a matching user is found in the LDAP, a new account is provisioned in LinShare with their details, and the new user's profile is returned. 

If the user is not found in either the local database or LDAP directory, a 404 Not Found error is returned.
##64. Find a User by Email
This request retrieve basic information for a user by their primary email address.
```bash
curl -X 'GET' \
'https://user.linshare-6-4-on-commit.integration-linshare.org/linshare/webservice/rest/delegation/v2/users/{email}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “email” is mandatory field, it is the email of the user to find.

**Query Parameters**
* “domainId” is optional.
## 65. Get all workgroup entries
This request will retrieves a list of all file and folder entries located at the root level of a specific workgroup.
```bash
curl -X 'GET' \
'https://user.linshare-6-4-on-commit.integration-linshare.org/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/{workgroupUuid}/entries' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.
## 66. Delete a workgroup entry
This endpoint is used to remove a specific entry ( a file or folder) from a workgroup.
```bash
curl -X 'DELETE' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/{workgroupUuid}/entries' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <ThreadEntry>
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Request Body**
* The request body is mandatory and must contain a `<ThreadEntry>` object - representation of the entry to be deleted:
```json
{
  "uuid": "string",
  "name": "string",
  "description": "string",
  "creationDate": "2025-08-26T08:31:50.486Z",
  "modificationDate": "2025-08-26T08:31:50.486Z",
  "ciphered": true,
  "type": "string",
  "size": 0,
  "metaData": "string",
  "sha256sum": "string",
  "hasThumbnail": true,
  "workGroup": {
    "uuid": "string",
    "creationDate": "2025-08-26T08:31:50.486Z",
    "name": "string"
  },
  "workGroupFolder": {
    "uuid": "string",
    "name": "string",
    "parent": "string",
    "workGroup": "string",
    "description": "string",
    "metaData": "string",
    "lastAuthor": {
      "firstName": "string",
      "lastName": "string",
      "name": "string",
      "mail": "string",
      "uuid": "string",
      "role": "SIMPLE",
      "accountType": "INTERNAL",
      "domain": {
        "uuid": "string",
        "label": "string"
      }
    },
    "creationDate": "2025-08-26T08:31:50.486Z",
    "modificationDate": "2025-08-26T08:31:50.486Z",
    "treePath": [
      {
        "uuid": "string",
        "name": "string"
      }
    ],
    "type": "FOLDER",
    "pathFromParent": "string"
  }
}
```
* “uuid” is required field. It is the unique identifier of the workgroup entry to be deleted.
## 67. Create a Workgroup Entry from a URL
This request will creates a new document entry in a workgroup by downloading a file from a specified public URL.
```bash
curl -X 'POST' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/(workgroupUuid}/entries/url?async={boolean}&strict={boolean}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <DocumentURL>
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Query parameters**
* “async”: boolean. It is optional field. Default value is “false”. Set true to enable asynchronous upload processing.
* “strict”: boolean. It is optional field. Default value is “false”. When the workgroup version is disabled and this field is set true, the server will return an error if an entry with the same name already exists in the workgroup. If set false, the server will automatically rename the new file to avoid a conflict.
**Request Body**
* The request body must contain a `<DocumentURL>` object specifying the source of the file:
```json
{
  "url": "string",
  "fileName": "string",
  "size": 0
}
```
* “url” and “fileName” are mandatory. “size” is optional
## 68. Get a workgroup entry
This request will retrievet the complete metadata for a single, specific entry (a file or folder) within a workgroup by its unique identifier.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/(workgroupUuid}/entries/{Uuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “Uuid” is the the unique identifier  of the specific workgroup entry to retrieve.

**Note**
* The technical account must have permission “Get workgroup entry”
## 69. Delete a workgroup entry
This endpoint provides a direct and standard way to remove a specific entry from a workgroup. The resource to be deleted is identified by its uuid in the URL path
```bash
curl -X 'DELETE' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/(workgroupUuid}/entries/{Uuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “Uuid” is the the unique identifier  of the specific workgroup entry to retrieve.
## 70. Get a workgroup entry headers
This request will check for the existence of a specific workgroup entry and retrieves its metadata via HTTP headers, without downloading the actual response body.
```bash
curl -X 'HEAD' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/{workgroupUuid}/entries/{Uuid}' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “Uuid” is the the unique identifier  of the specific workgroup entry to retrieve.

**Note**
* The technical account must have permission “Get workgroup entry”
## 71. Download a file in a workgroup
This request will download a file within a workgroup 
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/{workgroupUuid}/entries/{actorUuid}/documents/{uuid}/download' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “ Uuid” is the unique identifier of the workgroup file entry to be downloaded.
**Note**
* The technical account must have permission “Get workgroup entry” and “Download workgroup entry”
## 72. Get Asynchronous Task Status
This request will check and retrieve the current status of a long-running asynchronous task, such as a large file upload or a copy operation.
```bash
curl -X 'GET' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups/{workgroupUuid}/entries/{uuid}/async' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “ Uuid” is the unique identifier of the asynchronous task

**Note**
* The technical account must have permission “Find an asynchronous task”
## 73. Download the thumbnail of a file
This request is to download the pre-generated thumbnail image for a specific file entry in a workgroup.
```bash
curl -X 'GET' \
  'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}/entries/{actorUuid}/documents/{uuid}/thumbnail' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “uuid* is the unique identifier of the workgroup file entry for which a thumbnail is requested.

**Note**
* The technical account must have permission “Download thumbnail of workgroup entry”
## 74. Update the workgroup entry properties
This request will update an existing workgroup entry by completely replacing its metadata with the provided data.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}/entries/{actorUuid}/documents/{uuid}' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <ThreadEntry>
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “Uuid” are mandatory fields.
* “uuid* is the unique identifier of the specific workgroup entry to be updated.

**Request Body**
* The request body must contain a `<ThreadEntry>` object:
```json
{
  "uuid": "string",
  "name": "string",
  "description": "string",
  "creationDate": "2025-08-27T11:39:32.619Z",
  "modificationDate": "2025-08-27T11:39:32.619Z",
  "ciphered": true,
  "type": "string",
  "size": 0,
  "metaData": "string",
  "sha256sum": "string",
  "hasThumbnail": true,
  "workGroup": {
    "uuid": "string",
    "creationDate": "2025-08-27T11:39:32.619Z",
    "name": "string"
  },
  "workGroupFolder": {
    "uuid": "string",
    "name": "string",
    "parent": "string",
    "workGroup": "string",
    "description": "string",
    "metaData": "string",
    "lastAuthor": {
      "firstName": "string",
      "lastName": "string",
      "name": "string",
      "mail": "string",
      "uuid": "string",
      "role": "SIMPLE",
      "accountType": "INTERNAL",
      "domain": {
        "uuid": "string",
        "label": "string"
      }
    },
    "creationDate": "2025-08-27T11:39:32.619Z",
    "modificationDate": "2025-08-27T11:39:32.619Z",
    "treePath": [
      {
        "uuid": "string",
        "name": "string"
      }
    ],
    "type": "FOLDER",
    "pathFromParent": "string"
  }
}
```
* “name”, “description” are updatable fields
* Fields which are managed by server such as “uuid”; “creationdate”; “modificationdate”, “ “domain”; “lastAuthor”; “ type” … are not updatable and will be ignored.

**Note**
* The technical account must have permission “Update workgroup entry”
## 75. Get all workgroup members
This request will retrieve a complete list of all users who are members of a specific workgroup, along with their roles and permissions within that workgroup.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}/members' \
  -u "login:password" \
  -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Note**
* The technical account must have permission “List workgroup members”
## 76. Update a workgroup member
This request will update the role and permissions of a single, existing member within a workgroup.
```bash
curl -X 'PUT' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}/members' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <ThreadMember>
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Request Body**
* The request body must contain a complete `<ThreadMember>` object identifying the user and their new permissions:
```json
{
  "admin": true,
  "readonly": true,
  "role": "string",
  "firstName": "string",
  "lastName": "string",
  "userUuid": "string",
  "userMail": "string",
  "userDomainId": "string",
  "threadUuid": "string"
}
```
* “userUuid” is required field
* “role” is the uuid of the new role

**Note**
* The technical account must have permission “Update workgroup member”
## 77. Create a workgroup member
This request will add a new user as a member to a specific workgroup and assigns them an initial role and permissions.
```bash
curl -X 'POST' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}//members' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d <ThreadMember>
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Request Body**
* The request body must contain a `<ThreadMember>` object identifying the user and their new permissions

**Note**
* The technical account must have permission “Update workgroup member”
## 78. Delete a workgroup member
This request will remove a specific user from a workgroup, revoking their access and permissions.
```bash
curl -X 'DELETE' \
 'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}//members' \
  -u "login:password" \
  -H 'accept: application/xml' \
  -H 'Content-Type: application/json' \
  -d  '{
      "userUuid": "81c93e40-2f64-4255-a3b0-9415dfb9c4c5"
}'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid” are mandatory fields.

**Request Body**
* The request body must contain “userUuid” of the workgroup member to be removed.

**Note**
* The technical account must have permission “Delete workgroup member”, “Delete shared space permissions”, “Get shared space permissions”
## 79. Remove a Specific Member from a Workgroup by UUID
This request will remove a Specific Member from a Workgroup by UUID
```bash
curl -X 'DELETE' \
'https:<host>/linshare/webservice/rest/delegation/v2/{actorUuid}/workgroups//{workgroupUuid}//members /{uuis}' \
 -u "login:password" \
 -H 'accept: application/xml'
```
**Path Parameters**
* “actorUuid”, “workgroupUuid”, “uuid” are mandatory fields.
* “uuid” is the unique identifier of the user to be removed from the workgroup.

**Note**
* The technical account must have permission “Delete workgroup member”, “Delete shared space permissions”, “Get shared space permissions”
## 80 Get API version
This request is to retrieve the current version of the Delegation API.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/version' \
-u "login:password" \
-H 'accept: application/xml'
```
## 81. Check if user is authorized
This request verifies the current user's authentication status and retrieves their basic account information.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/authentication/authorized' \
-u "login:password" \
-H 'accept: application/xml
```
## 82. Logout the current user
This endpoint is used to perform a session logout
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/authentication/logout' \
-u "login:password" \
-H 'accept: application/xml
```
## 83. Find a user
This request retrieve basic information for a user by their primary email address.
```bash
curl -X 'GET' \
'https:<host>/linshare/webservice/rest/delegation/v2/users/{mail}' \
-u "login:password" \
-H 'accept: application/xml'
```
**Path Parameters**
* “mail” is mandatory. It is the email address of the user to find.

**Query Parameters**
- “domainId” is optional. It is the UUID of the domain to which the search should be restricted.