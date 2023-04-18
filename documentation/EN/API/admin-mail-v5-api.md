# LinShare API Documentation
This guide provides a sample requests to LinShare mail admin V5 api.


To find the official documentation you can follow this [link](http://download.linshare.org/versions/).

## Mail configuration
Here is a sample of the mail configuration data transfer object that this API uses:

```json
{
"uuid": "946b190d-4c95-485f-bfe6-d288a2de1edd",
"domain": "LinShareRootDomain",
"name": "Default mail config",
"visible": true,
"readonly": true,
"creationDate": 1659024727653,
"modificationDate": 1659024727653,
"mailLayout": "15044750-89d1-11e3-8d50-5404a683a462",
"mailFooterLangs": {
    "RUSSIAN": {
    "uuid": "a6c8ee84-b5a8-4c96-b148-43301fbccde8",
    "language": "RUSSIAN",
    "readonly": true,
    "mailFooter": "e85f4a22-8cf2-11e3-8a7a-5404a683a462",
    "mailConfig": "946b190d-4c95-485f-bfe6-d288a2de1edd",
    "mailFooterName": "footer html"
    },
    "ENGLISH": {
    "uuid": "bf87e580-fb25-49bb-8d63-579a31a8f81e",
    "language": "ENGLISH",
    "readonly": true,
    "mailFooter": "e85f4a22-8cf2-11e3-8a7a-5404a683a462",
    "mailConfig": "946b190d-4c95-485f-bfe6-d288a2de1edd",
    "mailFooterName": "footer html"
    },
    "FRENCH": {
    "uuid": "a6c8ee84-b5a8-4c96-b148-43301fbccdd9",
    "language": "FRENCH",
    "readonly": true,
    "mailFooter": "e85f4a22-8cf2-11e3-8a7a-5404a683a462",
    "mailConfig": "946b190d-4c95-485f-bfe6-d288a2de1edd",
    "mailFooterName": "footer html"
    }
},
"mailContentLangs": [
    {
    "uuid": "16a7f1aa-ee6d-11e8-9dab-3b0fd56ae1eb",
    "language": "FRENCH",
    "readonly": true,
    "mailContent": "16a7001a-ee6d-11e8-bb18-ef4f3a73c249",
    "mailConfig": "946b190d-4c95-485f-bfe6-d288a2de1edd",
    "mailContentType": "WORK_SPACE_WARN_NEW_MEMBER",
    "mailContentName": ""
    },
    {
    "uuid": "f355793b-17d4-499c-bb2b-e3264bc13dbd",
    "language": "ENGLISH",
    "readonly": true,
    "mailContent": "554a3a2b-53b1-4ec8-9462-2d6053b80078",
    "mailConfig": "946b190d-4c95-485f-bfe6-d288a2de1edd",
    "mailContentType": "SHARE_FILE_SHARE_DELETED",
    "mailContentName": null
    }
]
}
```

### Get ALL

```bash
curl -G 'https://<host>/linshare/webservice/rest/admin/v5/mail_configs' \
-u "login:password" \
-d "domainId:<domainUuid>" \
-d "onlyCurrentDomain:<onlyCurrentDomain>" 
```

Notes: here, a domain configuration is a configuration created on this domain. (Regardless of where it is assigned)

* Both **domainId** and **onlyCurrentDomain** are optional
* User must be allowed to manage requested domain to see its configurations.
* All configurations (private and public) are returned for requested domain.
* If **onlyCurrentDomain** flag is set to false, all parent domains public configurations are returned as well.
* **onlyCurrentDomain** default value is _false_.
* If no domain is specified, user's own domain will be used.

### Assign to domain

```bash
curl -X POST 'https://<host>/linshare/webservice/rest/admin/v5//domains/<domainUuid>/mail_config/<configUuid>/assign' \
-u "login:password" 
```

Notes: here, a domain configuration is a configuration created on this domain. (Regardless of where it is assigned)

* Both **domainUuid** and **configUuid** are mandatory
* User must be allowed to manage requested domain to assign a configuration.
* Public configuration from current domain or any of its parents can be assigned
* Private configuration can only be assigne on their own domain


## Mail layout
Here is a sample of the mail layout data transfer object that this API uses:

```json
{
"uuid": "e858b7f3-aae2-45f3-ad96-0830417d13a7",
"domain": "LinShareRootDomain",
"description": "Layout 1",
"layout": "<html-template>",
"visible": true,
"creationDate": 1666845717701,
"modificationDate": 1666845717701,
"readonly": false,
"messagesFrench": "common.availableUntil = Expire le\ncommon.byYou= | Par vous\ncommon.download= Télécharger\ncommon.filesInShare=Fichiers joints\ncommon.recipients = Destinataires\ncommon.titleSharedThe= Partagé le\ndate.format=d MMMM, yyyy\nproductCompagny=Linagora\nproductName=LinShare\nworkGroupRightAdminTitle = Administration\nworkGroupRightWirteTitle = Écriture\nworkGroupRightContributeTitle = Contribution\nworkGroupRightReadTitle = Lecture\nworkGroupRightContributorTitle = Contributeur\nworkSpaceRoleAdminTitle = WorkSpace: Administrateur\nworkSpaceRoleWriteTitle = WorkSpace: Auteur\nworkSpaceRoleReadTitle = WorkSpace: Lecteur\nwelcomeMessage = Bonjour {0},",
"messagesEnglish": "common.availableUntil = Expiry date\ncommon.byYou= | By you\ncommon.download= Download\ncommon.filesInShare = Attached files\ncommon.recipients = Recipients\ncommon.titleSharedThe= Creation date\ndate.format= MMMM d, yyyy\nproductCompagny=Linagora\nproductName=LinShare\nworkGroupRightAdminTitle = Administrator\nworkGroupRightWirteTitle = Writer\nworkGroupRightContributeTitle = Contributor\nworkGroupRightReadTitle = Reader\nworkSpaceRoleAdminTitle = WorkSpace: Administrator\nworkSpaceRoleWriteTitle = WorkSpace: Writer\nworkSpaceRoleReadTitle = WorkSpace: Reader\nwelcomeMessage = Hello {0},",
"messagesRussian": "common.availableUntil = Срок действия\ncommon.byYou= | Вами\ncommon.download= Загрузить\ncommon.filesInShare = Прикрепленные файлы\ncommon.recipients = Получатели\ncommon.titleSharedThe= Дата создания\ndate.format= d MMMM, yyyy\nproductCompagny= Linagora\nproductName=LinShare\nworkGroupRightAdminTitle = Администратор\nworkGroupRightWirteTitle = Автор\nworkGroupRightContributeTitle = Редактор\nworkGroupRightReadTitle = Читатель\nworkSpaceRoleAdminTitle = WorkSpace: Administrator\nworkSpaceRoleWriteTitle = WorkSpace: Writer\nworkSpaceRoleReadTitle = WorkSpace: Reader\nwelcomeMessage = Здравствуйте, {0},"
}
```

### Get ALL

```bash
curl -G 'https://<host>/linshare/webservice/rest/admin/v5/mail_layouts' \
-u "login:password" \
-d "domainId:<domainUuid>" \
-d "onlyCurrentDomain:<onlyCurrentDomain>" 
```

* Both **domainId** and **onlyCurrentDomain** are optional
* User must be allowed to manage requested domain to see its layouts.
* All layouts (private and public) are returned for requested domain.
* If **onlyCurrentDomain** flag is set to false, all parent domains public layouts are returned as well.
* **onlyCurrentDomain** default value is _false_.
* If no domain is specified, user's own domain will be used.


