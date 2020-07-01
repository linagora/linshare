# LinShare API Documentation
Ce guide fournit quelques exemples de requêtes vers l'API LinShare V2 .

Vous trouverez la documentation officielle sur ce [lien](http://download.linshare.org/versions/), puis selon la version vous pourriez télécharger l'artefact `linshare-core-{VERSION}-documentation-ws-api-userv2.tar.bz2`, extraire les fichiers et ouvrir sur votre navigateur préféré `/linshare-core/index.html`.

## Requête sur L'endpoint Documents
### Déposer un document sur votre espace

```bash
curl -i -u "login:password" http://<host>/linshare/webservice/rest/user/v2/documents -X POST -H "Content-Type: multipart/form-data" -H "Accept: application/json" -F"file=@/tmp/myfile.jpeg"  -F"filesize=49105"
```

### Lister vos documents
```bash
curl -X GET -i -v -u  "login:password" http://<host>/linshare/webservice/rest/user/v2/documents 
```
### Partager
- Pour créer un partage avec les paramètres obligatoires
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

- Vous pouvez ajouter des paramètres optionelles 
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
