## Sommaire - Installation de LinShare

   * [Téléchargement de LinShare](#dlLinshare)
   * [Déploiement de l'archive et des fichiers de configuration](#installFile)
   * [Installation de OpenJDK Java JRE](#installOpenJDK)
   * [Installation de PostgreSQL et MongoDB)](#bdd)
   * [Activation du moteur d'aperçu (optionnel)](#thumbnail)
   * [Installation de Tomcat 7](#tomcat)
   * [Serveur web (Installation de httpd)](#apache)
     1. [Configuration vhost ui-user](#ui-user)
     2. [Configuration vhost ui-admin](#ui-admin)
   * [Configuration et lancement de LinShare](#linconf)
   * [Premier accès](#firstAccess)

> Ce guide propose l'installation de la version LinShare 2.1 sur Centos 7 (les autres versions n'étant pas supportées).
  Pour l'installation d'une version antérieure, référez-vous aux branches GitHub, par exemple [LinShare 1.12.x](../../../../maintenance-1.12.x/documentation/EN/installation/linshare-install-centos-7.md)

<a name="dlLinshare">
## Téléchargement de __LinShare__
</a>

__LinShare__  est en libre téléchargement à l’adresse suivante:

[http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Vous y trouverez toutes les versions de LinShare.

Choisissez la version de LinShare en accord avec votre guide d'installation.
Chaque version de LinShare contient tous les composants nécessaires liés à une version spécifique de LinShare.
N'installez pas et n'utilisez pas un composant dont la version est différente de celles que vous trouverez dans le même dossier __sinon, vous risquez de rencontrer des problèmes__ de dépendances et LinShare peut ne pas fonctionner correctement.

Pour cette installation, téléchargez les fichiers, nommés ci-dessous, sur le serveur :

  * __linshare-core-{VERSION}.war__

  * __linshare-core-{VERSION}-sql.tar.bz2__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

  * __linshare-ui-user-{VERSION}.tar.bz2__

<a name="installFile">
## Déploiement de l'archive et des fichiers de configuration
</a>

Afin de manipuler les archives, il est nécessaire d’utiliser les outils `unzip` et `bzip2` :

`[root@localhost ~]# yum install -y unzip bzip2`

Il vous faut créer le répertoire de configuration de __LinShare__, puis y copier les fichiers de configuration par défaut et finir par renommer le fichier d'exemple comme suit :

```
[root@localhost ~]# mkdir -p /etc/linshare
[root@localhost ~]# mv linshare-core-{VERSION}.war /etc/linshare/linshare.war
[root@localhost ~]# unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
Archive:  linshare.war
  inflating: /etc/linshare/linshare.properties.sample  
  inflating: /etc/linshare/log4j.properties
[root@localhost ~]# cd /etc/linshare/
[root@localhost linshare]# mv linshare.properties.sample linshare.properties
```

> Modifiez le fichier `/etc/linshare/log4j.properties` afin de remplacer la ligne ci-dessous par la ligne suivante :

```
log4j.rootCategory=INFO, CONSOLE
```
```
log4j.rootCategory=INFO, LINSHARE
```

> Il faut également vérifier l'emplacement du fichier de log  :
```
log4j.appender.LINSHARE.File=/var/log/tomcat/linshare.log
```


<a name="installOpenJDK">
#### Installation de OpenJDK Java JRE
</a>

__LinShare__  supporte l'OpenJDK ou Sun/Oracle Java en version 8. Ici nous ferons l'installation d'OpenJDK Java 8 depuis les dépôts et l'activerons :

```
[root@localhost ~]$ yum -y install java-1.8.0-openjdk.x86_64
[root@localhost ~]$ update-alternatives --config java
```

> Les éventuelles erreurs relatives au plugin Java peuvent être ignorées.

<a name="bdd">
## Installation de PostgreSQL et MongoDB
</a>

__Linshare__ requière l’utilisation d’une base de données (PostgreSQL) pour ses fichiers et sa configuration.

La base de données MySQL n'est toujours pas prise en charge dans LinShare v2

Ce guide présente une installation avec PostgreSQL.

Installation de PostgreSQL depuis les dépôts:

`[root@localhost ~]$ yum install -y postgresql postgresql-server`


Démarrez le service PostgreSQL:

`[root@localhost ~]$ postgresql-setup initdb`

`[root@localhost ~]$ systemctl enable postgresql`

`[root@localhost ~]$ systemctl start postgresql`

#### Création des accès sécurisés

Adaptez le fichier de gestion des accès de PostgreSQL :

```
[root@localhost ~]$ vim /var/lib/pgsql/data/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   all               postgres               peer
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Note:<br/>
    * Ces lignes se trouvent généralement à la fin du fichier de configuration.<br/>
    * Pour des raisons de sécurité, le service PostgreSQL n’écoute qu’en local.<br/>
    * Pensez à redémarrer/recharger le serveur PostgreSQL après vos modifications pour qu'elles soient prises en compte:<br/>
    `[root@localhost ~]$ service postgresql restart/reload`

Il convient également d'ajouter ces règles dans les premières. En effet, PostgreSQL utilise la première règle valide qui correspond à la demande d'authentification.

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

Créez et importez les schémas de base de données:

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
     * Si besoin, vous disposez d'un script nommé `createDatabase.sh` sous src/main/resources/sql/postgresql/ qui vous fournit les commandes pour créer vos bases de données.

Importez les fichiers SQL « createSchema.sql » et « import-postgresql.sql » :

```
[root@localhost ~]$ tar xjvf linshare-core-*-sql.tar.bz2
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/createSchema.sql
Password for user linshare: {PASSWORD}
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/import-postgresql.sql
Password for user linshare: {PASSWORD}
```

Éditez le fichier de configuration de LinShare:



```
[root@localhost ~]$ vi /etc/linshare/linshare.properties
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password={PASSWORD}
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```

Pour l'installation de LinShare, vous aurez aussi besoin d'installer une base de données mongoDB. Vous pouvez le faire en suivant les commandes suivantes :

Le paquetage mongodb-org n'existe pas dans les référentiels par défaut de CentOS.
Toutefois, MongoDB gère un référentiel dédié. Ajoutons-le à notre serveur.

Avec l'éditeur vi, créez un fichier .repo pour yum, l'utilitaire de gestion de paquets pour CentOS:

```
[root@localhost ~]$ vi /etc/yum.repos.d/mongodb-org.repo
```

Ensuite, ajoutez les informations du référentiel de la dernière version stable au fichier:

```
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
```

Nous pouvons installer le paquet mongodb-org à partir du référentiel en utilisant l'utilitaire yum:

```
[root@localhost ~]$ yum install mongodb-org
```

Avant de démarer le MongoDB, assurez-vous que le fichier que /etc/mongod.conf a l'adresse ip du bind: 127.0.0.1

Ensuite, activez au démarrage (avec chkconfig, `mongod` n'est pas un service natif) et lancez le service MongoDB avec l'utilitaire systemctl:

```
[root@localhost ~]$ chkconfig mongod on
[root@localhost ~]$ systemctl start mongod
```

<a name="thumbnail">
## Activation du moteur d'aperçu (optionnel)
</a>

LinShare dispose d'un moteur de génération d'aperçu pour plusieurs types de fichiers :

- Formats OpenDocument (ODT, ODP, ODS, ODG)
- Formats de documents Microsoft (DOCX, DOC, PPTX, PPT, XLSX, XLS)
- PDF documents
- Fichiers images (PNG, JPEG, JPG, GIF)
- Fichiers text (TXT, XML, LOG, HTML, ...)

> Note:<br/>
    * Avant d'activer le module vous devez avoir installé LibreOffice ou OpenOffice,
    la version minimale requise pour LibreOffice est : 4.2.8.

Pour installer LibreOffice, exécutez la commande suivante dans votre terminal :

      yum -y install libreOffice

Par défault le moteur de génération de thumbnail est mis à FALSE. Pour l'activer vous devez modifier le fichier de configuration de LinShare comme ceci :
```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=false
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Cela va permettre de générer des aperçus après chaque dépôt de fichiers.

Vous avez également la possibilité d'utiliser le moteur de thumbnail à distance. Pour cela il faut activer le remote.mode :

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```

###### Téléchargement et installation du service thumbnail :

Pour utiliser ce mode, allez à cette adresse `http://download.linshare.org/versions/` et téléchargez les fichiers suivants :

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Note <br>
Par défaut, le serveur est configuré pour écouter sur le port 80, vous pouvez le changer, si nécessaire.

Copiez le fichier `linshare-thumbnail-server-{VERSION}.yml` dans `/etc/linshare/linshare-thumbnail-server.yml` et copiez aussi l'archive java `linshare-thumbnail-server-{VERSION}.jar` dans le répertoire  `/usr/local/sbin/linshare-thumbnail-server.jar`, vous pouvez utilisez les commandes suivantes pour ça :

```java
cp linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
```
```java
cp linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

* Vous pouvez automatiser le lancement du serveur thumbnail, en créant un service `systemd` sur le répertoire `/etc/systemd/system`, nommez-le comme suit `linshare-thumbnail-server.service`.

Éditez le fichier `linshare-thumbnail-server.service` et copiez le code ci-dessous :

```java
[Unit]
Description=LinShare thumbnail server
After=network.target

[Service]
Type=idle
KillMode=process
ExecStart=/usr/bin/java -jar /usr/local/sbin/linshare-thumbnail-server.jar server /etc/linshare/linshare-thumbnail-server.yml

[Install]
WantedBy=multi-user.target
Alias=linshare-thumbnail-server.service
```
Vous pouvez maintenant activer le service, il sera lancé automatiquement après un redémarrage:

`systemctl enable linshare-thumbnail-server.service`

Exécutez la commande suivante pour démarrer le service :

`systemctl start linshare-thumbnail-server.service`

<a name="tomcat">
## Installation de Tomcat 7
</a>

LinShare étant une application Java compilée et empaquetée au format WAR (**W** eb **A** pplication a **R** chive), il lui faut donc un conteneur de servlets Java (Tomcat ou Jetty) pour fonctionner.

Ce paragraphe présente l’installation et la configuration du serveur Tomcat.


#### Installation

Installez Tomcat depuis les dépôts:

`[root@localhost ~]$ yum install -y tomcat`

Activez le service :

`[root@localhost tmp]# systemctl enable tomcat`


> Note:<br/>
     * Vérifiez l'état du Tomcat pour vous assurer que le service est actif avec systemctl status tomcat


#### Configuration

Pour spécifier l’emplacement de la __configuration__ de linshare (fichier _linshare.properties_ ) ainsi que les options de démarrage par défaut nécessaire, récupérer les lignes commentées dans l'en-tête dans le fichier __linshare.properties__ file et copier-coller les dans le fichier Tomcat (/etc/sysconfig/tomcat):

L’ensemble des options de démarrage par défaut nécessaires à __Linshare__ asont indiquées dans les en-têtes des fichiers de configuration suivants:

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

Cependant, pour la déclaration de la variable `JAVA_OPT`, il faut concaténer les options, et donc ajouter la ligne suivante dans __/etc/sysconfig/tomcat__ :

` JAVA_OPTS="-Djava.awt.headless=true -Xms512m -Xmx2048m -Dlinshare.config.path=file:/etc/linshare/ -Dlog4j.configuration=file:/etc/linshare/log4j.properties -Dspring.profiles.active=default,jcloud,mongo,batches`

#### Paramètres supplémentaires

Dans le fichier /usr/share/tomcat/conf/catalina.properties de votre tomcat, vous avez une clé de configuration nommée tomcat.util.scan.StandardJarScanFilter.jarsToSkip, vous devez ajouter la ligne du milieu ci-dessous :

```
jetty-*.jar,oro-*.jar,servlet-api-*.jar,tagsoup-*.jar,xmlParserAPIs-*.jar,\
jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\
xom-*.jar
```

#### Déploiement de l'archive

Déployez l’archive de l’application __LinShare__ dans le serveur Tomcat :

```
[root@localhost ~]$ cp linshare.war /usr/share/tomcat/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat:tomcat /var/lib/linshare
```

<a name="apache">
#### Serveur web
</a>

L’interface d’administration de __LinShare__ est une application s’appuyant sur les langages web HTML/CSS et JavaScript. Elle nécessite un simple serveur web de type Apache ou Nginx.

Ce guide présente l’installation de Apache HTTP Server.


#### Installation

Installez Apache 2 depuis les dépôts :

```
[root@localhost ~]$ yum install -y httpd
[root@localhost ~]$ systemctl enable httpd
[root@localhost ~]$ systemctl start httpd
```

<a name="ui-user">
#### Configuration du vhost ui-user
</a>

Pour déployer l’application LinShare, il est nécessaire d’activer le module __mod_proxy__ sur Apache 2.

Vous devez créer vos répertoires dans le répertoire /var /www/, notez que votre nom de répertoire sera le nom de domaine de l'application.
Vous devez donner à votre utilisateur les droits d'accéder aux répertoires aussi.

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
[root@localhost ~]$ chown -R apache: linshare-ui-user
```

Pour déployer l'application __LinShare__, il est nécessaire de créer le fichier de configuration du vhost:

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-user.conf
```

```
<VirtualHost *:80>
...
ServerName linshare-user.local
DocumentRoot /var/www/linshare-ui-user
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-user-error.log
CustomLog /var/log/httpd/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * Après toute modification d'un vhost, il faut recharger le server Apache 2:
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="ui-admin">
#### Configuration du vhost ui-admin
</a>

Deploy the archive of the application __LinShare UI Admin__ in the Apache 2 repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ chown -R apache: linshare-ui-admin
```

Pour déployer l’interface d’administration de __LinShare__ administration interface, il est nécessaire d’activer le module  __mod_proxy__ sur Apache2.

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-admin-error.log
CustomLog /var/log/httpd/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * Après toute modification d'un vhost. il faut recharger le server Apache 2:
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="linconf">
### Configuration et Lancement de LinShare
</a>

Configurez l’ __emplacement de stockage des fichiers__ :

```
[root@localhost ~]$ mkdir -p /var/lib/linshare
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

Configurez l’ __accès à un service SMTP__, pour l’envoi des messages de notification:

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

Profil de fichiers de données disponibles:

* jcloud : Utilisant jcloud comme système de stockage de fichier : Amazon S3, Swift, Ceph, filesystem (que pour les tests).

* gridfs : Using gridfs (mongodb) comme système de stockage de fichier.

* jackrabbit2 : Using jackrabbit comme système de stockage de fichier (NB jackrabbit n'est disponible que pour des raisons de compatibilité avec la v1).

* jackrabbit-to-jcloud : Utilisant Jcloud comme nouveau système de stockage de fichier, jackrabbit comme fallback file data store.

* jackrabbit-to-gridfs : Utilisant GridFS comme nouveau système de stockage de fichier, jackrabbit comme fallback file data store.

Le profil recommandé est jcloud avec swift.

> Note:<br/>
   - Nous utilisons uniquement JackRabbit pour la transition, car il est déprécié.

Pour __démarrer LinShare__, démarrez le service Tomcat :

`[root@localhost ~]$ systemctl restart tomcat`

Afin de vérifier le fonctionnement de __LinShare__ consultez les fichiers des __journaux (logs)__ :

`[root@localhost ~]$ tail -f /var/log/tomcat/catalina.out`

En fin d’un démarrage correct du service, vous devriez avoir les messages suivants :

```
[...]
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Puis redémarrez le service Apache 2:

`[root@localhost ~]$ apachectl restart`

> Note:<br/>
    Vous disposez d'exemples de vhosts dans le repertoire : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">
## Premier accès
</a>

Le __service LinShare__ est désormais accessible aux adresses suivantes:

Pour l’interface utilisateur:

  * http://linshare-user.local/linshare

> Note:<br/>
  Vous devez renseignez cette url dans les paramètres de votre domaine. Pour ce faire, choisissez la fonctionalité __domain__ dans la liste de vos fonctionalités
et renseignez les champs __Url de base pour les notifications__ dans la sous fonctionalité __URL de base pour les notifications par courriel__.

Pour l’interface d’administration :

  * http://linshare-admin.local/

#### Paramétrage de LinShare

Connectez vous à __LinShare__ en tant qu’ __administrateur système__ :

  * Identifiant : root@localhost.localdomain

  * Mot de passe : __adminlinshare__

Ensuite, afin d’interconnecter __Linshare__ avec votre référentiel utilisateurs de type LDAP, créez un nouveau domaine depuis la rubrique « DOMAINES ». Pour plus d’informations, veuillez vous référer au __Guide de configuration et d’administration__ de __LinShare__ [__LINSHARE:CONF__].
