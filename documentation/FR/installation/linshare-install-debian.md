# Installation de LinShare sur Debian

   * [Téléchargement de LinShare](#dlLinshare)
   * [Déploiement de l'archive et des fichiers de configuration](#installFile)
   * [Installation de OpenJDK Java JRE](#instalOpenJDK)
   * [Installation des Bases de Données](#bdd)
     * [Installation de PostgreSQL](#postgre)
     * [Installation de MongoDB](#mongo)
   * [Activation du moteur d'aperçu (optionnel)](#thumbnail)
   * [Installation de Tomcat](#tomcat)
   * [Installation du serveur web](#apache)
     * [Configuration vhost ui-user](#ui-user)
     * [Configuration vhost ui-admin](#ui-admin)
     * [Configuration vhost ui-upload-request](#ui-upload-request)
   * [Configuration et lancement de Linshare](#linconf)
   * [Premier accès](#firstAccess)
   * [Invitation de dépôt](#uploadRequest)

Ce guide propose l'installation de la version __LinShare__ 6.0 sur *Debian bullseye 11*

> Note :<br/>
> Les guides d'installation des versions précédentes sont disponibles ici:
> - [LinShare 5.1](https://github.com/linagora/linshare/blob/maintenance-5.1.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 5.0](https://github.com/linagora/linshare/blob/maintenance-5.0.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 4.2](https://github.com/linagora/linshare/blob/maintenance-4.2.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 4.1](https://github.com/linagora/linshare/blob/maintenance-4.1.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 4.0](https://github.com/linagora/linshare/blob/maintenance-4.0.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 2.3](https://github.com/linagora/linshare/blob/maintenance-2.3.x/documentation/FR/installation/linshare-install-debian.md)
> - [LinShare 2.2](https://github.com/linagora/linshare/blob/maintenance-2.2.x/documentation/FR/installation/linshare-install.md)
> - [LinShare 2.1](https://github.com/linagora/linshare/blob/maintenance-2.1.x/documentation/FR/installation/linshare-install.md)
> - [LinShare 2.0](https://github.com/linagora/linshare/blob/maintenance-2.0.x/documentation/FR/installation/linshare-install.md)

## <a name="dlLinshare">Téléchargement de LinShare</a>

__LinShare__  est en téléchargement libre à l’adresse suivante :

[http://download.linshare.org/versions/](http://download.linshare.org/versions/)

Il existe plusieurs versions de __LinShare__. Choisir la version de __LinShare__ en accord avec le guide d'installation.
Chaque version de __LinShare__ contient tous les composants nécessaires liés à une version spécifique de __LinShare__.
Ne pas installer et utiliser un composant dont la version est différente de celles présentes dans le même dossier : afin d'éviter des problèmes de dépendances.

Dans cette version de LinShare, une nouvelle interface d'administration est introduite, nous aurons donc besoin de deux composants ui-admin (l'ancien et le nouveau composant), comme cela sera expliqué plus tard.
Notre objectif pour l'avenir est d'implémenter toutes les fonctionnalités de l'ancienne interface dans la nouvelle.

> Note :<br/>
Dans cette procédure, on considérera que les fichiers sont téléchargés dans le répertoire temporaire `/tmp/linshare_data`. Il est bien sûr possible d'utiliser n'importe quel autre dossier temporaire.

Pour cette installation, télécharger les fichiers, nommés ci-dessous, sur le serveur :
  * linshare-core-{VERSION}.war
  * linshare-core-{VERSION}-sql.tar.bz2
  * linshare-ui-admin-{VERSION}.tar.bz2
  * linshare-ui-admin-{VERSION}-legacy.tar.bz2
  * linshare-ui-user-{VERSION}.tar.bz2
  * linshare-ui-upload-request-{VERSION}.tar.bz2

Assurez-vous que la langue par défaut de votre système est `en_US.UTF-8` par le biais de cette commande:
```bash
dpkg-reconfigure locales
```

Afin de manipuler les archives, il sera nécessaire d’utiliser les outils `unzip` et `bzip2` :
```bash
aptitude install unzip bzip2
```

## <a name="installFile">Déploiement de l'archive et des fichiers de configuration</a>

Créer le répertoire de configuration de __LinShare__, puis copier les fichiers de configuration par défaut et renommer le fichier d'exemple comme suit :
```bash
mkdir -p /etc/linshare
mv /tmp/linshare_data/linshare-core-{VERSION}.war /etc/linshare/linshare.war
unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j2}.*
Archive:  linshare.war
  inflating: /etc/linshare/linshare.properties.sample  
  inflating: /etc/linshare/log4j2.properties
mv /etc/linshare/linshare.properties.sample /etc/linshare/linshare.properties
chown root:tomcat /etc/linshare/*
chmod 640 /etc/linshare/*
```

## <a name="instalOpenJDK">Installation de OpenJDK Java JRE</a>

__LinShare__  supporte l'OpenJDK ou Sun/Oracle Java en version 11. Voici son installation et son activation depuis les dépôts :

```bash
aptitude update
aptitude install openjdk-11-jre
update-alternatives --config java
```



## <a name="bdd">Installation des Bases de Données</a>

> Note :<br />
Historiquement LinShare était développé sur PostgreSQL. Les nouvelles fonctionnalités ont été développées sur MongoDB. La stratégie est de tout migrer vers MongoDB. La tâche étant fastidieuse, LinShare utilise donc actuellement les deux SGBD.

### <a name="postgre">Installation de PostgreSQL</a>

__Linshare__ requière l’utilisation d’une base de données (PostgreSQL) pour ses fichiers et sa configuration. Ce guide présente une installation avec PostgreSQL.

- La version installée pour est PostgreSQL 13, vous pouvez l'installer avec :

```bash
apt update
apt install postgresql
```

> Vous pouvez trouver les versions requises des dépendances de LinShare [ici](./requirements.md)

Configurer et démarrer le service PostgreSQL :
```bash
service postgresql start
```

Adapter le fichier de gestion des accès de PostgreSQL `/etc/postgresql/11/main/pg_hba.conf` :

```bash
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   all               postgres               peer
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Note :<br/>
Ces lignes se trouvent généralement à la fin du fichier de configuration.
Pour des raisons de sécurité, le service PostgreSQL n’écoute qu’en local.

Redémarrer le service PostgreSQL :
```bash
service postgresql restart
```

Il convient également d'ajouter ces règles dans les premières. En effet, PostgreSQL utilise la première règle valide qui correspond à la demande d'authentification.

Créer l’utilisateur linshare (mot de passe PASSWORD) :
```bash
su - postgres
[postgres@localhost ~]$ psql
CREATE ROLE linshare
  ENCRYPTED PASSWORD 'PASSWORD'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
\q
```

Commandes : pour quitter, taper `\q` pour obtenir de l’aide sous PSQL, taper `\?`.

Créer et importer les schémas de base de données :
```bash
su - postgres
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

> Important :<br/>
Si la base de données est installée en langue française, remplacer toutes les occurrences de chaîne `en_US` par `fr_FR`.

> Note :<br/>
Utiliser éventuellement le script nommé `createDatabase.sh` dans `src/main/resources/sql/postgresql/` qui fournit les commandes pour créer la bases de données.

Importer les fichiers SQL `createSchema.sql` et `import-postgresql.sql` :
```bash
cd /tmp/linshare_data
tar xjvf linshare-core-*-sql.tar.bz2
psql -U linshare -W -d linshare -f linshare-core-sql/postgresql/createSchema.sql
Password for user linshare: PASSWORD
psql -U linshare -W -d linshare -f linshare-core-sql/postgresql/import-postgresql.sql
Password for user linshare: PASSWORD
```

Éditer le fichier de configuration de __LinShare__ `/etc/linshare/linshare.properties` :
```java
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password=PASSWORD
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```

### <a name="mongo">Installation de MongoDB</a>

Pour l'installation de __LinShare__, il est nécessaire d'installer une base de données mongoDB.
**LinShare** requiert MongoDB 5.0
> Vous pouvez trouver les versions des dépendances pour le bon fonctionnement  LinShare [ici](./requirements.md)

- Importer la clé GPG MongoDB

```bash
sudo apt -y install gnupg2
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
```
- Ajouter l'URL du dépôt à votre Debian :
```bash
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org.list
```
- Installation mongodb:

```bash
sudo apt update
sudo apt -y install mongodb-org
```
Regargder le [guide officiel](https://docs.mongodb.com/v5.0/tutorial/install-mongodb-on-debian/).

- Démarrer le serveur MongoDB
```bash
sudo systemctl start mongod
```
Maintenant le serveur MongoDB est disponible et prêt à être utilisé.

- Configurer l'authentification MongoDB:  
Exécutez les commandes suivantes pour activer l'authentification

```bash
mongo
```
```bash
> use admin;
```
```bash
> db.createUser(
  {
    user: "linshare",
    pwd: "linshare",
    roles: [
      { role: "readWrite", db: "linshare" },
      { role: "readWrite", db: "linshare-files" } ]
  }
)
```
>  **linshare** est un exemple de mot de passe, il doit être changé

- Configuration de MongoDB

Par défaut, MongoDB est configuré avec la configuration __LinShare__ suivante dans le fichier `/etc/linshare/linshare.properties`, il suffit de la modifier comme suit :

```java
#### Mongo storage options ####

linshare.mongo.connect.timeout=30000
linshare.mongo.socket.timeout=30000

#### Write concern
# MAJORITY: waits on a majority of servers for the write operation.
# JOURNALED: Write operations wait for the server to group commit to the journal file on disk.
# ACKNOWLEDGED: Write operations that use this write concern will wait for acknowledgement,
#	 			using the default write concern configured on the server.
linshare.mongo.write.concern=MAJORITY

#### connection for data
# replicaset: host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
linshare.mongo.data.replicaset=127.0.0.1:27017
linshare.mongo.data.database=linshare
# linshare.mongo.data.credentials=[user:password[@database]]
linshare.mongo.data.credentials=linshare:linshare@admin

#### connection for small files
# Using MongoDb to store very small files (thumbnails, mail attachments, ...)
linshare.mongo.smallfiles.replicaset=127.0.0.1:27017
linshare.mongo.smallfiles.database=linshare-files
linshare.mongo.smallfiles.credentials=linshare:linshare@admin


#### The connection for bigfiles is used just if the `gridfs` spring profile is enabled.
# Store all files in MongoDB GridFS. Not recommended.
linshare.mongo.bigfiles.replicaset=127.0.0.1:27017
linshare.mongo.bigfiles.database=linshare-bigfiles
linshare.mongo.bigfiles.credentials=linshare:linshare@admin

######## Storage options - end ########
```

Pour plus d'information sur les bases de données Mongo utilisées dans LinShare vous pouvez lire: [documentation](https://github.com/linagora/linshare/blob/master/documentation/FR/administration/configuration-administration.md#mongodb)

## <a name="thumbnail">Activation du moteur d'aperçu (Optionnel)</a>

__LinShare__ dispose d'un moteur de génération d'aperçu pour plusieurs types de fichiers :
- Formats OpenDocument (ODT, ODP, ODS, ODG)
- Formats de documents Microsoft (DOCX, DOC, PPTX, PPT, XLSX, XLS)
- PDF documents
- Fichiers images (PNG, JPEG, JPG, GIF)
- Fichiers text (TXT, XML, LOG, HTML, ...)

> Note :<br/>
Avant d'activer le module, il est nécessaire d'installer LibreOffice : la version minimale requise pour LibreOffice est : 4.2.8.

Pour installer LibreOffice, exécuter la commande suivante :
```bash
aptitude update
aptitude install libreoffice
```

Par défault le moteur de génération de thumbnail est mis à `FALSE`. Pour l'activer il est nécessaire de modifier le fichier de configuration de __LinShare__ dans `/etc/linshare/linshare.properties` :
```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Cela va permettre de générer des aperçus après chaque dépôt de fichiers.

Pour utiliser ce mode, télécharger les fichiers suivants depuis l'adresse [http://download.linshare.org/versions/](http://download.linshare.org/versions/) :
* thumbnail-server-{VERSION}.jar
* thumbnail-server-{VERSION}.yml

> Note :<br/>
Dans cette procédure, on considérera que les fichiers sont téléchargés dans le répertoire temporaire `/tmp/linshare_data`. Il est bien sûr possible d'utiliser n'importe quel autre dossier temporaire.

> Note <br>
Par défaut, le serveur est configuré pour écouter sur le port 80 : il est possible de le changer.

Installer le fichier `thumbnail-server-{VERSION}.yml` dans `/etc/linshare/linshare-thumbnail-server.yml` et installer l'archive java `thumbnail-server-{VERSION}.jar` dans le répertoire  `/usr/local/sbin/linshare-thumbnail-server.jar` :
```java
mv /tmp/linshare_data/thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
mv /tmp/linshare_data/thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

Créer un service systemd permet d'automatiser le lancement du serveur thumbnail en arrière plan. Créer le fichier `/etc/systemd/system/linshare-thumbnail-server.service`, et ajouter le contenu suivant :
```bash
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

Configurer et activer le nouveau service :
```bash
systemctl daemon-reload
systemctl enable linshare-thumbnail-server.service
systemctl start linshare-thumbnail-server.service
```

## <a name="tomcat">Installation de Tomcat</a>

__LinShare__ étant une application Java compilée et empaquetée au format WAR (**W** eb **A** pplication a **R** chive), il lui faut donc un conteneur de servlets Java (Tomcat ou Jetty) pour fonctionner. Ce paragraphe présente l’installation et la configuration du serveur Tomcat.

Installer Tomcat depuis les dépôts :
```bash
aptitude install tomcat9
```

Pour spécifier l’emplacement de la configuration de __LinShare__ (fichier `linshare.properties` ) ainsi que les options de démarrage par défaut nécessaire, récupérer les lignes commentées dans l'en-tête dans le fichier `linshare.properties` et copier-coller les dans le fichier Tomcat (`/etc/default/tomcat9`):

L’ensemble des options de démarrage par défaut nécessaires à __Linshare__ sont indiquées dans les en-têtes des fichiers de configuration suivants :
  * `/etc/linshare/linshare.properties`
  * `/etc/linshare/log4j2.properties`

Il est indispensable de modifier la variable `JAVA_OPTS` lignes ci-dessous : `/etc/default/tomcat9`:

```conf
JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true -Xms512m -Xmx2048m"
JAVA_OPTS="${JAVA_OPTS} -Dlinshare.config.path=file:/etc/linshare/"
JAVA_OPTS="${JAVA_OPTS} -Dlog4j2.configurationFile=file:/etc/linshare/log4j2.properties"
```

Au cas ou vous voulez changer l'emplacement des fichiers temporaires, vous pouvez changer le répertoire utilisé par défaut par Tomcat9 `/tmp` et modifiez `/etc/default/tomcat9` en ajoutant:

```conf
CATALINA_TMPDIR=/your/path/tmp
```

> Note :<br/>
Si vous rencontrez une erreur en surchargeant votre nouveau chemin de répertoire `tmp`, cela peut être dû au manque d'autorisation d'écriture de Tomcat sur votre nouveau répertoire.
Vous pouvez vérifier [cette section](https://github.com/linagora/linshare/blob/master/documentation/FR/installation/linshare-install-debian.md#configuration-et-lancement-de-linshare)

####profiles
LinShare fournis différent profiles qui permettent de conditionner le lancement de l'application selon le besoin (support de stockage, mode d'authentification ...).
Pour configurer les profiles vous devez ajouter la ligne ci-dessous dans `/etc/default/tomcat9`, pour le profile par défaut par exemple:

```config
JAVA_OPTS="${JAVA_OPTS} -Dspring.profiles.active=default,jcloud,batches"
```
Il est requis d'activer au moins un profile d'authentification parmi ceux existants:

* default: profile d'authentification
* sso : Autorise l'injection d'entêtes pour le support du SSO (ex: LemonLDAP)

Profiles de stockage de fichiers :
* jcloud : utiliser  `apache jcloud` mode de stockage de fichiers  : Amazon S3, Swift, Ceph, filesystem.
* gridfs : utiliser `gridfs` (mongodb) comme mode de stockage de fichiers.
Les profiles recommandés sont `jcloud` avec `Swift`

Autres profiles :
* batches : active l'exécution des taches planifiés (ex: expirations des partages)

Dans le fichier `/var/lib/tomcat9/conf/catalina.properties` de tomcat, des retours à la ligne matérialisés par le caractère `\` permettent de réduire la largeur des lignes des valeurs pour chaque clé de configuration. Il y a une clé de configuration nommée `tomcat.util.scan.DefaultJarScanner.jarsToSkip`. Ajouter `jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\` quelque part dans la section associée à cette clé.
Voici un exemple d'extrait du fichier `/var/lib/tomcat9/conf/catalina.properties` avec la ligne ajoutée au milieu :
```java
jetty-*.jar,oro-*.jar,servlet-api-*.jar,tagsoup-*.jar,xmlParserAPIs-*.jar,\
jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\
xom-*.jar
```

Déployer l’archive de l’application __LinShare__ dans le serveur Tomcat :

```bash
mv /tmp/linshare_data/linshare-core-{VERSION}.war /var/lib/tomcat9/webapps/linshare.war
```

## <a name="apache">Installation du serveur web</a>

L’interface d’administration de __LinShare__ est une application s’appuyant sur les langages web HTML/CSS et JavaScript. Elle nécessite un simple serveur web de type Apache ou Nginx. Ce guide présente l’installation de Apache HTTP Server.

Installer Apache 2 depuis les dépôts :
```bash
aptitude install apache2
```

### <a name="ui-user">Configuration vhost ui-user</a>

Pour déployer l’application __LinShare__, il est nécessaire d’activer le module `mod_proxy` sur Apache 2.

Créer les répertoires dans le répertoire `/var/www/`, noter que le nom de répertoire sera le nom de domaine de l'application. Attribuer à l'utilisateur les droits d'accéder aux répertoires aussi.

```bash
mv /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2 /var/www/
cd /var/www/
tar xjf linshare-ui-user-<VERSION>.tar.bz2
chown -R apache: linshare-ui-user
rm -fr /var/www/linshare-ui-user-<VERSION>.tar.bz2
```

De plus, il faut ajouter la configuration ci-après au fichier fourni par défaut par Debian :

```bash
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/linshare-ui-user.conf
sudo a2dissite 000-default
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite linshare-ui-user
sudo a2enmod proxy proxy_http
```

Pour déployer l'application __LinShare__, il est nécessaire de modifier le fichier de configuration du vhost. Modifier le fichier `/etc/apache2/sites-available/linshare-ui-user.conf` avec le contenu suivant :

```xml
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

### <a name="ui-admin">Configuration vhost ui-admin</a>

Comme mentionné précédemment pour l'application __LinShare__ UI Admin, nous aurons besoin de deux composants, vous pouvez suivre les étapes ci-dessous pour les déployer dans le référentiel apache2 :

```bash
cd /var/www/
tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}-legacy.tar.bz2
chown -R www-data: linshare-ui-admin
cd linshare-ui-admin
tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
mv linshare-ui-admin new
```

De plus, il faut ajouter la configuration ci-après au fichier fourni par défaut par Debian :

```bash
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/linshare-ui-admin.conf
sudo a2dissite 000-default
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite linshare-ui-admin
sudo a2enmod proxy proxy_http headers
```

Pour déployer l'application __LinShare__, il est nécessaire de modifier le fichier de configuration du vhost. Modifier le fichier `/etc/apache2/sites-available/linshare-ui-admin.conf` avec le contenu suivant :

```xml
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
### <a name="ui-upload-request">Configuration vhost ui-upload-request(optionnel)</a>

> Note :<br/>
Le composant de l'Invitation de dépôt est facultatif sur LinShare(il n'est pas nécessaire pour le fonctionnement de LinShare), par défaut sa fonctionnalité est activée, donc pour le bon fonctionnement  de cette fonctionnalité, vous devez suivre le guide ci-dessous pour déployer son insterface. Si ce n'est pas le cas, vous pouvez désactiver la fonctionnalité sur l'interface d'administration.

Tout d'abord, veuillez vous rendre à [cette section](#uploadRequest) pour télécharger le module d'invitation de dépôt.
Pour déployer l'interface d'invitation de dépôt de __LinShare__, il faut ouvrir le fichier virtualhost linshare-ui-upload-request.conf et le modifier de la façon suivante :

```
cp /etc/apache2/sites-available/000-default.conf
/etc/apache2/sites-available/linshare-ui-upload-request.conf
sudo a2dissite 000-default
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite linshare-ui-upload-request
sudo a2enmod proxy proxy_http
```

Maintenant vous pouvez changer le fichier comme suit :

```xml
<VirtualHost *:80>
ServerName linshare-upload-request.local
DocumentRoot /var/www/linshare-ui-upload-request
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

ErrorLog /var/log/apache2/linshare-ui-upload-request-error.log
CustomLog /var/log/apache2/linshare-ui-upload-request-access.log combined
</Virtualhost>
```

> Note :<br/>
    Des exemples de vhosts sont disponibles dans le repertoire : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

Redémarrer le service httpd :

```bash
systemctl apache2 reload
```

## <a name="linconf">Configuration et Lancement de LinShare</a>

Configurer l’emplacement de stockage des fichiers dans le fichier de configuration de __LinShare__ `/etc/linshare/linshare.properties` :
```java
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

Dans cette configuration il est nécessaire de créer le dossier avec les bonnes permissions :
```bash
mkdir -p /var/lib/linshare
chown -R tomcat:tomcat /var/lib/linshare
```

Configurer l’accès à un service SMTP, pour l’envoi des messages de notification dans le fichier de configuration de __LinShare__ `/etc/linshare/linshare.properties` :
```java
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

Sur __LinShare__, il existe deux modes d'authentification possibles, le premier est celui par défaut et le second est une authentification par SSO. Pour démarrer LinShare il est nécessaire d'activer l'un des modes suivants :
* default : processus d'authentification par défaut.
* sso : permet l'injection d'entête pour le SSO. Ce profil inclue les "..." du profil par défaut.

Le profile par défaut est `jcloud` pour le filesystem de stockage des fichiers.

Il est possible de surcharger ces paramètres en utilisant `-Dspring.profiles.active=xxx`
Ou bien d'utiliser une variable d'environnement : `SPRING_PROFILES_ACTIVE`.

Activer au moins un des profils de système de sockage de fichiers ci-dessous :
* jcloud : Utilisant `jcloud` comme système de stockage de fichier : Amazon S3, Swift, Ceph, filesystem.
* gridfs : Utilisant `gridfs` (mongodb) comme système de stockage de fichier.

> Note :<br/>
Le profil recommandé pour la production est jcloud.


Tomcat9 peut écrire uniquement dans ses propres répertoires, si vous utilisez le mode local de stockage des fichiers, vous devez surcharger la configuration par défaut de Tomcat, vous devez créer sous `/etc/systemd/system/tomcat9.service.d/` un ficher `override.conf` qui contient:

```
    [Service]
    ReadWritePaths=/var/lib/linshare
```

Puis vous devez:

```
systemctl daemon-reload
systemctl restart tomcat9
```

Démarrer le service tomcat, afin de démarrer l'application __LinShare__ :
```bash
systemctl start tomcat9
```

Afin de vérifier le fonctionnement de __LinShare__, consulter les fichiers des __journaux__ (logs) :
```bash
tail -f /var/log/tomcat9/catalina.out
```

En fin d’un démarrage correct du service, le message suivant devrait apparaître :
```
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```
Puis redémarrez le service Apache:

`[root@localhost ~]$ sudo systemctl restart apache2`

### <a name="firstAccess">Premier accès</a>

> Note: <br>
Avant le premier accès à __LinShare__, vous devez ajouter ` à `/etc/hosts`:

```Bash
127.0.0.1   linshare-user.local
127.0.0.1   linshare-admin.local
127.0.0.1   linshare-upload-request.local
```

Le service __LinShare__ est désormais accessible aux adresses suivantes :

Pour l’interface utilisateur :
  * http://linshare-user.local/

![linshare-user-000002010000047E01400157A9D6C9G6](../../img/linshare-user-000002010000047E01400157A9D6C9G6.png)

Pour l’interface d’administration :
  * http://linshare-admin.local/

Voici les identifiants par défaut du compte administrateur système :
  * Identifiant : root@localhost.localdomain
  * Mot de passe : adminlinshare

Veuillez changer le mot de passe depuis l'interface d'administration.

> Note :<br/>
  Il n'est pas possible d'ajouter d'autres utilisateurs standards LinShare en local sans LDAP. Voir la section dédiée à la configuration du LDAP dans la [paramétrage applicatif](../administration/linshare-admin.md).

![linshare-admin-000002010000047E01400157A9D6C9G6](../../img/linshare-admin-000002010000047E01400157A9D6C9G6.png)

Pour accéder à la nouvelle interface d'administration:
   * http://linshare-admin.local/new/

![linshare-authentication-new-admin-interface](http://download.linshare.org/screenshots/5.0.0/01.authentication.new.admin.portal.png)

![linshare-new-admin-interface](http://download.linshare.org/screenshots/5.0.0/02.new.admin.portal.png)

### <a name="uploadRequest">Installation du portail d'invitation de dépôt</a>

<a name="dlmoduleUR1">

#### Téléchargement du module

</a>

Ce module est disponible gratuitement à l'adresse suivante :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

Pour l'installation, télécharger le fichier suivant selon la version que vous souhaitez :

  * linshare-ui-upload-request-{VERSION}.tar.bz2

>Note :<br/>
  La fonctionnalité d'invitation de dépôt est seulement disponible pour les versions de LinShare entre 1.7 et 1.12, et à partir de LinShare 4.1

<a name="deployUR1">

#### Déploiement de l'archive

</a>

Déployer l'archive __LinShare__ UI UploadRequest dans le dossier du serveur Apache:

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf linshare-ui-upload-request-{VERSION}.tar.bz2
[root@localhost ~]$ chown -R www-data: linshare-ui-upload-request
```

Vous pouvez maintenant suivre la configuration du vhost de l'invitation de dépôt [ici](#ui-upload-request).

Pour accéder au __portail d'invitation de dépôt de LinShare__, démarrer __LinShare core__, et redémarrer le service Apache2 :

`[root@localhost ~]$ service apache2 restart`

<a name="firstAccessUR1">

### Premier accès

</a>

Le __service d'invitation de dépôt__ est maintenant accessible à l'adresse suivante par défaut : __http://linshare-upload-request.local/__

> Note :<br/>
  Vous pouvez modifier l'url avec le paramètre "URl de l'invitation de dépôt" dans l'interface d'administration
  Pour ce faire, rendez vous dans votre interface d'administration, choisissez la fonctionnalité  de __l'invitation de dépôt__, et renseignez l'url dans le champ "paramètres".
