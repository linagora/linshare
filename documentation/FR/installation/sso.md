# Intégration avec LemonLDAP :: NG

LemonLDAP :: NG est un Web Single Sign On (WebSSO) open source.

## Resumé

Le déploiement de LemonLDAP :: NG: vous pouvez trouver la documentation officielle de l'installation de LemonLDAP :: NG ici: [Installation guide](https://lemonldap-ng.org/documentation/quickstart).

Nous supposons que vous disposez déjà d'une instance en cours d'exécution de LemonLDAP :: NG et LinShare, et pour tout le guide la distribution Linux utilisée est Debian.

Dans le déploiement standard, pour accèder à LinShare nous allons réutiliser la même URL déclarée dans le guide d'installation `linshare-user.local`.
En mode SSO, LinShare nécessite une URL externe pour les invités et pour la fonctionnalité URL anonymes.
Nous allons conserver l'URL d'origine pour l'accès public et utiliser `linshare-user-sso.local` pour un usage interne.

Pour l'intégration de LemonLDAP :: NG, il y a quatre étapes importantes à suivre:
 * Configuration du serveur Web: Configuration des vhosts d'Apache qui exposent l'application linshare-ui-user.
 * Configuration de Tomcat.
 * Configuration LemonLDAP :: NG: Déclaration d'une nouvelle application dans le portail lemonldap-ng avec des règles d'accès.
 * Configuration de LinShare: Une fois l'intégration de LemonLDAP :: NG est terminée, nous devons mettre à jour la configuration de LinShare pour utiliser une bonne URL pour les notifications par courrier électronique.

 ## Étape 1: Configuration du serveur Web (Apache)

 Il y a deux modes pour intégrer une application avec LemonLDAP :: NG, décentralisé (ancien mode) et centralisé (nouvel mode).

 ### Apache en mode décentralisé

 Vous devez installer et déployer les LemonLDAP :: NG Handers sur le serveur LinShare

 `apt-get install lemonldap-ng-handler`

Cela déploiera le gestionnaire par défaut vhost: `/etc/apache2/sites-available/handler-apache2.conf`.
Ensuite, vous pouvez le modifier et ajouter les instructions suivantes à votre vhost:

```
PerlOptions +GlobalRequest
PerlModule Lemonldap::NG::Handler
```

Vous devez donc déployer 2 vhosts:
  * Le premier vhost sera protégé par LemonLDAP :: NG pour vos utilisateurs internes.
  * Le deuxième vhost sera utilisé pour l'accès externe comme les URL anonymes ou les invités.

  #### vhost public:
  ```
  <VirtualHost *:80>
  ...
  ServerName linshare-user.local
  RequestHeader unset Auth-User
  ...
  </Virtualhost>
  ```

  #### vhost privé:
  ```
  PerlOptions +GlobalRequest
  PerlModule Lemonldap::NG::Handler

  <VirtualHost *:80>
  ...
  ServerName linshare-user-sso.local
  PerlHeaderParserHandler Lemonldap::NG::Handler
  ...
  </Virtualhost>
  ```

Ensuite, vous devez redémarrer Apache: `systemctl restart apache2.service`.

### Apache en mode centralisé

En mode centralisé, vous devez déployer un vhost et son gestionnaire sur le
Serveur LemonLDAP :: NG avec tous les autres vhosts / applications. Ces vhosts  
proxy tout le trafic vers les serveurs d'applications d'origine. Leur utilisation principale est de charger et de protéger le vhost avec les instructions LemonLDAP :: NG.


## Étape 2: Configuration du Tomcat

Nous devons également mettre à jour la configuration Tomcat de LinShare. Nous supposons que vous avez suivi le guide d'installation, dans votre fichier de configuration `/etc/linshare/linshare.properties`, Vous devez décommenter ces paramètres:

```
#******************** SSO
# LemonLDAP::NG / SiteMinder HTTP request authenticator
sso.header.user=Auth-User
sso.header.domain=Auth-Domain
# comma separated list of ip address to be trusted :
sso.header.allowfrom.enable=true
sso.header.allowfrom=127.0.0.1

```

Ensuite, au début du fichier de configuration, vous trouverez toute une section
expliquant comment fonctionne les profils spring. Dans notre cas, il suffit d'activer le profil `sso`:

`-Dspring.profiles.active=sso,jcloud,batches`

Enfin, vous devez redémarrer Tomcat: `systemctl restart tomcat8.service`.

## Étape 3: Configuration de LemonLDAP::NG

Une fois le handler est déployé, vous devez configurer le gestionnaire LemonLDAP :: NG. `http://manager.example.com/`

Vous avez trois tâches à accomplir:
  * Déclarez un nouvel hôte virtuel protégé (application)
  * Mettre à jour le processus de déconnexion globale
  * Déclarez une nouvelle application

### Déclarez un nouvel hôte virtuel protégé (application)

Dans le gestionnaire, accédez à la section Hôtes virtuels et ajoutez un nouvel hôte virtuel avec `linshare-user-sso.local` comme nom. Dépliez le nouvel élément créé pour ajouter de nouvelles règles et définir:

```
* Rules
  * 000-catch-post-logout (comment)
    * Rule: logout_app_sso https://auth.linagora.com/
    * Expression: ^/linshare/webservice/rest/user/v2/authentication/post-logout
  * 001-unprotect-logout-linshare (comment)
    * Rule: unprotect
    * Expression: ^/linshare/webservice/rest/user/v2/authentication/logout
  * default
    * Rule: accept
* HTTP Headers
  * Auth-User: $mail
```

### Mettre à jour le processus de déconnexion globale

Pourquoi avons-nous besoin d'une déconnexion globale?
* Si vous déclenchez la déconnexion LinShare, nous devons également nous déconnecter de notre sso.
* Si vous déclenchez une déconnexion d'application, nous devons également nous déconnecter de LinShare.
Dans le gestionnaire, accédez à la section Paramètres généraux / Paramètres avancés / Déconnexion et ajoutez une nouvelle entrée:

Nouvelle clé: LinShare = http://auth.example.com/linshare/webservice/rest/user/v2/authentication/logout

### Déclarez une nouvelle application

vous pouvez déclarer notre application dans le portail LemonLDAP :: NG avec toutes vos applications. Accédez à Paramètres généraux /Portail /Menu /Catégories et applications et une nouvelle application.

## Étape 4: Configuration de LinShare

Vous devrez mettre à jour la configuration LinShare dans l'interface d'administration `linshare-admin.local` avec les deux URL LinShare.

Tout d'abord, vous devez configurer l'URL privée `linshare-user-sso.local` dans la section ` Fonctionnalités / Domaine / Url de base pour les notifications `de votre domaine racine `LinShareRootDomain`.

Ensuite, vous devez définir l'URL publique de vos domaines invités.
Enfin, vous devez configurer l'URL publique `linshare-user.local` dans la section ` Fonctionnalités /  URL anonymes / URL de notification courriel ` de votre domaine racine `LinShareRootDomain`.
