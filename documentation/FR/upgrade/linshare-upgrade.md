##Sommaire

###MISE A JOUR DE LINSHARE

#### 1. [Mise à jour du serveur de LinShare (LinShare Core)](#upgradecore)
   * [Téléchargement de LinShare](#dlLinhsare)
   * [Déploiement de l'archive](#deploy)
   * [Mise à jour de la base de données](#bdd)
   * [Redémarrage de votre service](#restart)

#### 2. [Mise à jour de l'interface d'administration de LinShare (LinShare ui-admin)](#upgradeadmin)
   * [Téléchargement de LinShare Admin](#dlLinhsareadmin)
   * [Déploiement de l'archive](#deployadmin)

#### 3. [Mise à jour de l'invitation de dépôt de LinShare (LinShare Upload-Request)](#upgradeur)
   * [Téléchargement de LinShare Upload Request](#dlLinshareur)
   * [Déploiement de l'archive](#deployur)

#### 4. [Mise à jour de la demande d'invitationd de dépôt de LinShare (LinShare Upload-Proposition)](#upgradeup)
   * [Téléchargement de LinShare Upload Proposition](#dlLinshareup)
   * [Déploiement de l'archive](#deployup)


###MISE A JOUR DE LINSHARE

> Note :

 - Dans ce document, nous présentons comment effectuer une mise à jour de votre version de Linshare.
 - L'exemple choisi est celui d'une mise à jour d'un Linshare sans SSO. Notez que pour la version SSO le processus est le même.
 - Veuillez par ailleurs noter que le core et l'interface d'administration doivent être mise à jour conjointement. En effet pour chaque version du core, vous avez une version correspondante cf lien vers tableau
 
<a name="upgradecore">
###Mise à jour du serveur de __Linshare__
</a>

<a name="dlLinshare">
###Téléchargement de __LinShare__
</a>

__LinShare__ est disponible à l'adresse suivante :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

Vous pouvez choisir la version vers laquelle vous souhaitez migrer.

  * __linshare-core-{VERSION}-without-SSO.war__

<a name="deploy">
###Déploiement de l'archive
</a>

Pour déployer l'archive que vous venez de télécharger, vous devez la renommer puis la copier dans le répertoire webapps de votre tomcat :

```
[root@localhost ~]$ service tomcat7 stop
[root@localhost ~]$ cp linshare-core-{VERSION}-without-SSO.war /var/lib/tomcat7/webapps/linshare.war
```

<a name="bdd">
###Mise à jour de la base de données
</a>

> Note :

  - Cette partie traite d'une mise à jour d'une base de donnée évoluant sous postgres. Le processus restera le même dans le cas de mysql.

Si vous effectuez une mise à jour de version mineure (i.e d'une 1.X vers une 1.X), vous aurez besoin de mettre à jour votre base de données.

Pour mettre à jour votre base de données, vous devez procéder de la manière suivante :

```
[root@localhost ~]$ cd linshare.war /var/lib/tomcat7/webapps/
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/Migration_<your-actual-version>_to_<the-next-version>.sql | psql -U linshare -W -d linshare
```

> Note :

  - Si vous effectuez, par exemple de la version 1.6.x to the 1.9.x, vous devez executez les scripts suivants :
    * Migration_1.6.0_to_1.7.0.sql
    * Migration_1.7.0_to_1.8.0.sql
    * Migration_1.8.0_to_1.9.0.sql

<a name="restart">
###Redémarrage de vos services
</a>

Vous pouvez à présent redémarrez votre service tomcat7 :

`[root@localhost ~]$ service tomcat7 start`

<a name="upgradeadmin">
###Mise à jour de l'interface d'administration
</a>

Pour mettre à jour votre interface d'administration, vous devez télécharger la version désirée (compatible avec votre serveur) à l'adresse suivante :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

<a name="deployadmin">
###Déploiement de l'archive
</a>

Déployez l'archive dans de l'application __LinShare UI Admin__ dans votre répertoire Apache 2 :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-admin /var/www/linshare-ui-admin-{VERSION}
```
Modifiez le document root dans votre fichier vhost :

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-admin.conf

<VirtualHost *:80>
...
DocumentRoot /var/www/linshare-ui-admin-{VERSION}
...
</Virtualhost>
```

Puis rechargez votre serveur apache :

`[root@localhost ~]$ sudo service apache2 reload`

Vos interfaces utilisateur et d'administration sont désormais disponibles sous de nouvelles versions à leurs adresses respectives.

<a name="dlLinshareur">
###Téléchargement de LinShare Upload Request
</a>

Pour mettre à jour votre composant __LinShare Upload-Request__, vous devez télécharger la version désirée à l'adresse suivante :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

<a name="deployur">
###Déploiement de l'archive
</a>

Déployez l'archive dans l'application __LinShare Upload-Request__ dans votre répertoire Apache 2 :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-uploadrequest-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-upload-request /var/www/linshare-ui-upload-request-{VERSION}
```
Modifiez le document root dans votre fichier vhost :

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-upload-request.conf

<VirtualHost *:80>
...
DocumentRoot /var/www/linshare-ui-upload-request-{VERSION}
...
</Virtualhost>
```
Puis rechargez votre serveur apache :

`[root@localhost ~]$ sudo service apache2 reload`

Votre application d'invitation de dépôt est désormais disponible à son adresse.

<a name="dlLinshareup">
###Download of LinShare Upload Proposition
</a>

Pour mettre à jour votre composant __LinShare Upload-Proposition__, vous devez télécharger la version désirée à l'adresse suivante :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

<a name="deployup">
###Deployment of the archive
</a>

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-uploadproposition-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-upload-proposition /var/www/linshare-ui-upload-proposition-{VERSION}
```
Modifiez le document root dans votre fichier vhost :

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-upload-proposition.conf

<VirtualHost *:80>
...
DocumentRoot /var/www/linshare-ui-upload-request-{VERSION}
...
</Virtualhost>
```
Puis rechargez votre serveur apache :

`[root@localhost ~]$ sudo service apache2 reload`

Votre application LinShare est désormais mise à jour.