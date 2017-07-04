## Sommaire

### INSTALLATION LINSHARE

#### 1. [Installation minimale de Linshare](#install-min)
   * [Téléchargement de LinShare](#dlLinshare)
   * [Déploiement de l'archive et des fichiers de configuration](#instalFile)
   * [Installation de OpenJDK Java JRE](#instalOpenJdk) 
   * [Base de données (Installation de PostgreSQL)](#bdd)
   * [Conteneur de servlet (Installation de Tomcat 8)](#tomcat)
     1. [Configuration vhost ui-user](#ui-user)
     2. [Configuration vhost ui-admin](#ui-admin)
   * [Configuration et lancement de Linshare](#linconf)
   * [Premier accès](#firstAccess)


### INSTALLATION LINSHARE

> Note:<br/>
Ce guide d'installation est pour les versions 2.x LinShare sur Debian 8 Jessie (Les autres distributions de Debian ne sont pas supportées).
L'installation des versions précédentes de LinShare est disponible dans les
branches github par exemple: [LinShare 1.12.x](../../../../maintenance-1.12.x/documentation/FR/installation/linshare-install.md)

<a name="install-min">

#### Installation minimale de __LinShare__

</a>


<a name="dlLinshare">

#### Téléchargement de __LinShare__

</a>

__LinShare__ est en libre téléchargement à l’adresse suivante:

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Note:<br/>
Vous trouverez toutes les versions de LinShare à l'adresse [suivante] (http://download.linshare.org/versions/).
Choisissez la version de LinShare en accord avec votre guide d'installation.
Chaque version de LinShare contient tous les composants nécessaires liés à une version spécifique de LinShare.
N'installez pas et n'utilisez pas un composant dont la version est différente de celles que vous trouverez dans le même dossier.
Sinon, vous risquez de rencontrer des problèmes de dépendances et LinShare peut ne pas fonctionner correctement.

Pour cette installation, téléchargez les fichiers suivants :

  * __linshare-core-{VERSION}.war__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

  * __linshare-ui-user-{VERSION}.tar.bz2__

<a name="instalFile">

#### Déploiement de l'archive et des fichiers de configurations

</a>

Afin de manipuler les archives, il est nécessaire d’utiliser les outils Unzip et Bzip :

`[root@localhost ~]$ aptitude install unzip bzip2 vim`

Créez le répertoire de configuration de __LinShare__ et copiez les fichiers de configuration :

```
[root@localhost ~]$ mv linshare-core-{VERSION}.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

### Environnement d’exécution Java (JVM)

__LinShare__ fonctionne avec OpenJDK et Sun/Oracle Java version 8. Ce guide porte sur OpenJDK Java 8.

<a name="instalOpenJdk">

#### Installation de OpenJDK Java JRE

</a>

Installez Java Runtime Environment (JRE) de OpenJDK depuis les dépôts :

> Note:<br/>
   * Si vous êtes sur Debian jessie, vous devez ajoutez les bakcports pour pouvoir installer JAVA 8.
   Pour ce faire vous devez ajouter cette ligne : `deb http://ftp.debian.org/debian jessie-backports mai` au fichier `/etc/apt/sources.list`.
   Puis vous pouvez installer le package désiré comme suit : `aptitude update; aptitude -t jessie-backports install votre_package`.<br/>

```
[root@localhost ~]$ aptitude install openjdk-8-jre
[root@localhost ~]$ update-alternatives --config java
```

> Remarque:<br/>
    * les éventuelles erreurs relatives au plugin Java peuvent être ignorées.

<a name="bdd">

### Base de données

</a>

__LinShare__ requière l’utilisation d’une base de données (PostgreSQL) 
pour ses fichiers et sa configuration. Ce guide présente une installation avec PostgreSQL.

Installation de PostgreSQL depuis les dépôts :

`[root@localhost ~]$ aptitude install postgresql`

Démarrez le service PostgreSQL :

`[root@localhost ~]$ service postgresql start`

#### Création des accès sécurisés

Adaptez le fichier de gestion des accès de PostgreSQL :

```
[root@localhost ~]$ vim /etc/postgresql/<VERSION>/main/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Note:<br/>
   * Ces lignes se trouvent généralement à la fin du fichier de configuration.<br/>
   * Pour des raisons de sécurité, le service PostgreSQL n’écoute qu’en local.<br/>
   * Pensez à redémarrer/recharger le serveur PostgreSQL après vos modifications pour qu'elles soient prises en compte:<br/>
   `[root@localhost ~]$ service postgresql restart/reload`<br/>

Il convient également d'ajouter ces règles dans les premières. En effet, PostgreSQL utilise la premère règle valide qui correspond à la demande d'authentification.

Créez l’utilisateur « linshare » (mot de passe {PASSWORD}) :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

CREATE ROLE linshare
  ENCRYPTED PASSWORD '{PASSWORD}'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

\q
```

Commandes : pour quitter, tapez « \q » ; pour obtenir de l’aide sous PSQL, tapez « \? ».

Créez et importez les schémas de base de données :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

CREATE DATABASE linshare
  WITH OWNER = linshare
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;


GRANT ALL ON DATABASE linshare TO linshare;

\q
```

__Important : si votre base de données est installée en langue française, remplacez toutes les occurrences de chaîne « en_US » par « fr_FR ».__

> Note:<br/>
    * Au besoin, vous disposez d'un script nommé createDatabase.sh sous `/WEB-INF/classes/sql/postgresql/` qui vous 
   fournit les commandes pour créer vos bases de données.

Importez les fichiers SQL « createSchema.sql » et « import-postgresql.sql » :

```
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/createSchema.sql | psql -h localhost -U linshare -W -d linshare
Password for user linshare: {PASSWORD}
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/import-postgresql.sql | psql -h localhost -U linshare -W -d linshare
Password for user linshare: {PASSWORD}
```

Éditez le fichier de configuration de __LinShare__ :

```
[root@localhost ~]$ vim /etc/linshare/linshare.properties
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password={PASSWORD}
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```

Pour l'installation de LinShare, vous aurez aussi besoin d'installer une base de données mongoDB spécifique (version 3.2), vous pouvez le faire en suivant les commandes suivantes :

Importez d'abord la clé publique utilisée par le système de gestion des paquets:

```
[root@localhost ~]$ apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
```
Vous devez créer un fichier de liste:

```
[root@localhost ~]$ echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
```

Après cela, vous devez recharger les paquets locaux de la base de données:

```
[root@localhost ~]$ apt-get update
```
Installez la dernière version stable de MongoDB:

```
[root@localhost ~]$ apt-get install -y mongodb-org
```

Avant de lancer MongoDB, assurez-vous que le fichier /etc/mongod.conf a l'adresse IP de bind: 127.0.0.1

Pour finir, lancez la commande suivante pour démarrer mongod.

```
[root@localhost ~]$ service mongod start
```

<a name="tomcat">

### Conteneur de servlets

</a>

__LinShare__ étant une application Java compilée et empaquetée au format WAR ( **W**eb **A**pplication a**R**chive), il lui faut donc un __conteneur de servlets Java__ (Tomcat ou Jetty) pour fonctionner.

Ce paragraphe présente l’installation et la configuration du serveur Tomcat.

### Installation de Tomcat 8

Installez Tomcat depuis les dépôts :

`[root@localhost ~]$ aptitude install tomcat8`

#### Configuration de Tomcat 8

Pour spécifier l’emplacement de la __configuration__ de LinShare (fichier __linshare.properties__) ainsi que les 
options de démarrage par défaut nécessaire, récupérer les lignes commentées dans l'en-tête dans 
le fichier __linshare.properties__ et copier-coller les dans le fichier tomcat ( __/etc/default/tomcat8__ ).

L’ensemble des options de démarrage par défaut nécessaires à __LinShare__ sont indiquées dans les en-têtes des fichiers de configuration suivants :

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

#### Déploiement de l'archive

Déployez l’archive de l’application __LinShare__ dans le serveur Tomcat :

```
[root@localhost ~]$ cp linshare.war /var/lib/tomcat8/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat8:tomcat8 /var/lib/linshare
```

<a name="apache">

### Serveur web

</a>

L’interface d’administration de __LinShare__ est une application s’appuyant sur les langages web HTML/CSS et JavaScript. Elle nécessite un simple serveur web de type Apache ou nginx.

Ce guide présente l’installation de Apache HTTP Server.

#### Installation de Apache 2

Installez Apache 2 depuis les dépôts :

`[root@localhost ~]$ aptitude install apache2


#### Configuration du vhost

<a name="ui-user">

#### ui-user

</a>

Deployer l'archive de LinShare application UI User dans le repertoire approprié d'Appache 2 :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
[root@localhost ~]$ mv linshare-ui-user-<VERSION> /var/www/linshare-ui-user
```

Pour déployer l’application LinShare, il est nécessaire d’activer le module __mod_proxy__ sur Apache 2. De plus, il faut ajouter la configuration ci-après au fichier fourni par défaut par Debian :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-user.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2ensite linshare-user.conf
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-user.conf

<VirtualHost *:80>
...
ServerName linshare-user.local
DocumentRoot /var/www/linshare-ui-user
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-user-error.log
CustomLog /var/log/apache2/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * Après toute modification d'un vhost, il faut recharger le server Apache 2 :<br/>
   `[root@localhost ~]$ service apache2 reload` <br/>
   * Dans les versions récentes de Apache, le fichier default peut se nommer default.conf.<br/>
   * Dans le cas où créez un document root, vous pourrez y créer un sous repertoire custom,<br/> 
   dans lequel vous pourrez déployer votre logo :<br/>
   `[root@localhost ~]$ mkdir -p linshare/custom` <br/>

<a name="ui-admin">

#### ui-admin

</a>

Déployez l’archive de l’application __LinShare UI Admin__ dans le répertoire du serveur Apache 2 :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-admin-{VERSION} /var/www/linshare-ui-admin
```

Pour déployer l’interface d’administration de __LinShare__, il est nécessaire d’activer le module __mod_proxy__ sur 
Apache2. De plus, il faut ajouter la configuration ci-après au fichier fourni par défaut par Debian :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-admin.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2ensite linshare-admin.conf
[root@localhost ~]$ a2enmod proxy proxy_http headers
[root@localhost ~]$ vim linshare-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #Cette entête est rajoutée pour éviter à IE de faire du cache sur le JSON
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * Après toute modification d'un vhost. il faut recharger le server Apache 2 :<br/>
    `[root@localhost ~]$ service apache2 reload`<br/>
   * Dans les version récentes de Apache, le fichier default peut se nommer default.conf.<br/>

<a name="linconf">

### Configuration & Lancement de LinShare

</a>

Configurez l’__emplacement de stockage des fichiers__ :

```
[root@localhost ~]$ vim /etc/linshare/linshare.properties
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
linshare.signature.tmp.dir=/var/lib/linshare/tmp/linSignDocuments
linshare.files.directory=/var/lib/linshare/repository
```

Configurez l’__accès à un service SMTP__, pour l’envoi des messages de notification :

```
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

Sur LinShare, vous avez deux modes d'authentification possibles, le permier est celui par défaut et le second est une authification par sso. Pour démarrer LinShare vous devez au moins activer l'un des modes suivants :

* default : processus d'authentification par défaut.
* sso : permet l'injection d'entête pour le SSO. Ce profil inclue les ... du profil par défaut.

Le profil par défaut est jcloud pour le filesystem pour les tests.

Vous pouvez surcharger ces paramètres en utilisant -Dspring.profiles.active=xxx
Ou vous pouvez utiliser une variable d'environnement : SPRING_PROFILES_ACTIVE

Vous devez aussi activer au moins un des profiles de système de sockage de fichiers en dessous :

Available file data store profiles :

* jcloud : Utilisant jcloud comme système de stockage de fichier : Amazon S3, Swift, Ceph, filesystem (que pour les tests).

* gridfs : Using gridfs (mongodb) comme système de stockage de fichier.

* jackrabbit2 : Using jackrabbit comme système de stockage de fichier.

* jackrabbit-to-jcloud : Utilisant Jcloud comme nouveau système de stockage de fichier, jackrabbit comme fallback file data store.

* jackrabbit-to-gridfs : Utilisant GridFS comme nouveau système de stockage de fichier, jackrabbit comme fallback file data store.

Le profil recommandé est jcloud avec swift.

> Note:<br/>
    - Nous utilisons uniquement JackRabbit pour la transition, car il est obsolète.


Pour __démarrer LinShare__, démarrez le service Tomcat :

`[root@localhost ~]$ service tomcat8 restart`

Afin de vérifier le fonctionnement de __LinShare__, consultez les fichiers des __journaux__ (logs) :

`[root@localhost ~]$ tail -f /var/log/tomcat8/catalina.out`

En fin d’un démarrage correct du service, vous devriez avoir les messages suivants :

```
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Puis redémarrez le service Apache 2 :

`[root@localhost ~]$ service apache2 restart`

> Note:<br/>
 Vous disposez d'exemples de vhosts dans le repertoire : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">

### Premier accès

</a>

Le __service LinShare__ est désormais accessible aux adresses suivantes.

Pour l’interface utilisateur :

  * http://linshare-user.local/linshare

> Note:<br/>
  Vous devez renseignez cette url dans les paramètres de votre domaine.<br/>
  Pour ce faire, choisissez la fonctionalité __Domaine__ dans la liste de vos fonctionalités<br/>
  et renseignez la champs __Url de base pour les notifications__ dans la sous fonctionalité __URL de base pour les notifications par courriel__.

Pour l’interface d’administration :

  * http://linshare-admin.local/

#### Paramétrage de LinShare

Connectez vous à __LinShare__ en tant qu’__administrateur système__ de __LinShare__ :

  * Identifiant : root@localhost.localdomain

  * Mot de passe : __adminlinshare__

Ensuite, afin d’interconnecter __LinShare__ avec votre référentiel utilisateurs de type LDAP, créez un nouveau domaine depuis la rubrique « DOMAINES ». 
Pour plus d’informations, veuillez vous référer au __Guide de configuration et d’administration__ de __LinShare__ [__LINSHARE:CONF__].


