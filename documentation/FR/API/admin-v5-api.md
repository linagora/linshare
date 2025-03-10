# LinShare ADMIN API Documentation
Ce guide fournit quelques exemples de requêtes vers l'API Admin de LinShare V5 .

Vous trouverez la documentation officielle sur ce [lien](http://download.linshare.org/versions/).

## Requête sur L'endpoint Users
L'API users manipule l'objet USERS, qui sera ici parfois représenté par `<userDto>` dont voici un exemple contenu:
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
Note: les champs "secondFAUuid", "secondFAEnabled", "creationDate", "modificationDate", "expirationDate", "comment" et "author" sont ignorés en entrée.

### Créer un utilisateur
La requête suivante permet de créer un utilisateur dans la base de donnée de Linshare.
```bash
curl -X POST 'http://<host>/linshare/webservice/rest/admin/v5/users' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto> 
```
* Les champs obligatoires sont "**mail**", "**domain**" et "**role**".
* Le champ "**uuid**" est ignoré.
* Un super admin peut créer dans tous les domaines
* Un administrateur de domaine ne peut créer que dans le domaine qu'il administre
* Si un utilisateur existe déjà (mail existant sur ce domaine), il ne sera pas édité.

### éditer un utilisateur
La requête\ suivante permet de modifier un utilisateur dans la base de donnée de Linshare.
```bash
curl -X PUT 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto>
```
* Les champs obligatoires sont "**uuid**", "**domain**", "**role**", "**locked**" et "**externalMailLocale**".
* Le champ "**uuid**" peut être récupéré soit du chemin de la requête, soit de l'objet.
* Les champs "**mail**", "**domain**" et "**secondFAUuid**"/"**secondFAEnabled**" ne sont pas éditables.
* Les champs laissées a vide dans l'objet en entrée ne sont pas édités dans la base.
* Un root (ou super admin) peut éditer dans tous les domaines
* Un administrateur de domaine ne peut éditer que dans le domaine qu'il administre
* L'édition ne crée pas l'utilisateur si il n'existe pas déjà dans la base de donnée

### Supprimer un utilisateur
La requête\ suivante permet de supprimer un utilisateur dans la base de donnée de Linshare.
```bash
curl -X DELETE 'http://<host>/linshare/webservice/rest/admin/v5/users' \
-u "login:password" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-d <userDto>
```
ou alternativement :
```bash
curl -X DELETE 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" 
```

* Le champ "**uuid**" est obligatoires et peut être récupéré soit du chemin de la requête, soit de l'objet.
* Il n'est pas nécessaire d'envoyer un objet
* Un root (ou super admin) peut supprimer dans tous les domaines
* Un administrateur de domaine ne peut supprimer que dans le domaine qu'il administre

### Récupérer un utilisateur
La requête\ suivante permet de récupérer un utilisateur dans la base de donnée de Linshare.
```bash
curl -X GET 'http://<host>/linshare/webservice/rest/admin/v5/users/<user-uuid>' \
-u "login:password" 
```

* Le champ "**uuid**" est obligatoire.
* Un root (ou super admin) peut voir les utilisateurs de tous les domaines
* Un administrateur de domaine ne peut voir que dans le domaine qu'il administre



### Récupérer plusieurs utilisateurs
La requête\ suivante permet de récupérer une liste ordonnée d'utilisateurs de la base de donnée de Linshare, en filtrant les résultats selon certains critères.
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

* Aucun champ n'est obligatoire.
* Le champ "**domain**" est déprécié.
* Le champ "**domains**", permet de restreindre la recherche a certains domaines
* Les champs **"sortOrder"** et **"sortField"** permettent d'ordonner les résultats (par défaut tri ascendant sur la date de modification)
* Les champs **"mail"**, **"firstName"**, **"lastName"**, **"role"** et **"type"** sont de type string et permettent filtrer selon respectivement: le mail, prénom, nom, role et type de compte (exemple "INTERNAL", "GUEST") des utilisateurs.
* Les champs **"restricted"**, **"canCreateGuest"** et **"canUpload"** sont de type booléen et permettent filtrer selon leur champ associé les utilisateurs.
* Si un moins un des champs **"greaterThan"** ou **"lowerThan"** est renseigné, ne seront retourné que les utilisateurs dont le nombre de modérateur est compris entre ces bornes. Auquel cas le champ "**moderatorRole**" peut être utilisé pour restreindre encore plus en fonction du role des modérateurs.
* Les champs **"pageNumber"** et **"pageSize"** permettent de contrôler la pagination des résultats, par défaut page 0 de 50 éléments.
* Un root (ou super admin) peut voir les utilisateurs de tous les domaines
* Un administrateur de domaine peut voir en fonction des domaines qu'il administre



### Récupérer plusieurs utilisateurs avec autocomplete
La requête\ suivante permet de récupérer des utilisateurs d'après un échantillon.
```bash
curl -G 'http://<host>/linshare/webservice/rest/admin/v5/users/autocomplete/<pattern>' \
-u "login:password" \
-d 'accountType=<type>' \
-d 'domain=<domain-uuid>'
```

* Le champ "**pattern**" est obligatoire. Les utilisateurs dont un des champs "mail", "firstName" ou "lastName" contiennent ce pattern seront retournés.
* Le champ "**accountType**" est optionnel. Il permet de restreindre le type de compte des utilisateurs retournées (exemple "INTERNAL", "GUEST")
* Le champ "**domain**" est optionnel. Il permet de restreindre les recherches à un domaine précis; en son absence tous les domaines accessibles par le demandeur seront interrogés.
* Le nombre d'élément retournés est limité à 20.
* Un root (ou super admin) peut voir les utilisateurs de tous les domaines
* Un administrateur de domaine peut voir en fonction des domaines qu'il administre   
   

*Comportement*   
* Si le demandeur un invité : on retourne les contacts correspondants depuis la base de donnée
* Si le demandeur est interne :
  * on cherche les invités correspondants
  * on y ajoute les utilisateurs internes en fonction du user provider défini sur chaque domaine
    * _LDAP_ : depuis le ldap
    * _OIDC_ : depuis la base de donnée (+ ldap si configuré dans les propriétés de l'application `oidc.ldap.connectionUuid` et `oidc.ldap.provider.patternUuid`)
    * _TWAKE_ & _TWAKE_GUEST_ : endpoint configuré dans le provider twake






