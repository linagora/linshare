# LinShare API Documentation
This guide provides a sample requests to LinShare user V2 api.


To find the official documentation you can follow this [link](http://download.linshare.org/versions/), and then according to your version you can download the artefact `linshare-core-{VERSION}-documentation-ws-api-userv2.tar.bz2`, then extract and open the `/linshare-core/index.html` file by your favorite browser.

## Sample Documents endpoints
### Upload

```bash
curl -i -u "login:password" http://<host>/linshare/webservice/rest/user/v2/documents -X POST -H "Content-Type: multipart/form-data" -H "Accept: application/json" -F"file=@/tmp/myfile.jpeg"  -F"filesize=49105"
```

### List your documents 
```bash
curl -X GET -i -v -u  "login:password" http://<host>/linshare/webservice/rest/user/v2/documents 
```
### Share
- To create a share with required fields
```bash
curl -X POST '{your_host}/linshare/webservice/rest/user/v2/shares' -u "login:password" -H "Content-Type: application/json" -H "Accept: application/json" -d '{"recipients": [
    {
      "mail": "recipient1_mail"
    },
    {
      "mail": "recipient2_mail"
    }
  ],
  "documents": [
    "document1_uuid",
    "document2_uuid"
  ]}' 
```

- by adding optional fields 
```bash
'{"recipients": [
    {
      "mail": "recipient1_mail"
    },
    {
      "mail": "recipient2_mail"
    },
    ...
  ],
  "documents": [
    "document1_uuid",
    "document2_uuid",
    ...
  ],
  "mailingListUuid": [],
  "secured": true,
  "creationAcknowledgement": true,
  "expirationDate": 1598565599999,
  "enableUSDA": true,
  "notificationDateForUSDA": 1590938422780,
  "sharingNote": "",
  "subject": "{your_mail_subject}",
  "message": "{your_mail_content}"
}'
```
