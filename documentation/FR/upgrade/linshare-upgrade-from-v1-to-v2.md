# MISE A JOUR DE LINSHARE

> Note :

 - Dans ce document, nous présentons comment effectuer une mise à jour de votre version de LinShare. </br>
 - Veuillez noter que tous les composants présents dans une version de LinShare
(http://download.linshare.org/version/ <VERSION>) doivent être mise à jour conjointement. </br>
En effet chaque répertoire contient un assemblage cohérent pour former le produit LinShare. </br>


# Pré-requis

## Navigateurs

L'interface utilisateur a été entièrement réécrite avec de nouvelles technologies (AngularJS).
Ces nouvelles technologies nécessitent toutefois des navigateurs récents et
performants tel que Chrome ou Firefox. L'application fonctionne sur IE11 et Edge
mais l'interface perd en réactivité et nuire à l'expérience utilisateur.

## Limitation

La version 2.0 de LinShare n'est pas iso-fonctionnelle avec la
version 1. Les fonctionnalités invitation de dépôt et demande d'invitation de
dépôt n'ont pas encore été porté dans cette nouvelle interface.

Ces fonctionalités seront à nouveau présentes dans la version 2.1.

La base de données MySQL n'est plus supportée, vous devrez donc migrer sous
PostgreSQL. Cf https://wiki.postgresql.org/wiki/Converting_from_other_Databases_to_PostgreSQL#MySQL.
La meilleur des statégies sera de migrer votre instance vers la version 1.12,
valider son bon fonctionnement et enfin basculer vers postgresl.
Vous pourrez alors vous assurer facilement de la réussite de votre migration.

NB: Le composant logiciel de stockage JackRabbit possède ses propres paramètres
pour se connecter à la base de données dans le fichier : /var/lib/linshare/repository/workspaces/default/workspace.xml.

L'ensemble du paramétrage des fonctionnalités ainsi que les modèles de courriel seront réinitialisés par le script
de migration SQL. Vous devrez donc reconfigurer votre instance lors du redémarrage.

## Architecture

La version 2.0 de LinShare apporte un changement majeur, l'utilisation de la
base de données NoSQL MongoDB ainsi qu'un changement de la composant en charge du
stockage de fichiers.

En version 1.x les fichiers étaient stockés sur le système de fichiers de votre
OS via l'utilisation de Apache JackRabbit. En version 2, le stockage est
désormais assuré par Apache JCloud permettant un stockage sur le système de
fichiers pour de faible volumétrie et un stockage Cloud via les API S3 pour une forte volumétrie.
Il est donc nécessaire de choisir votre nouveau backend de stockage de fichiers.

Outre l'installation du nouveau composant MongoDB, LinShare requière également
Java 8. Ces deux composants ont donc un impact fort sur l'OS à utiliser.

Nous recommandons au minimum Centos 7 ou supérieur et Debian 8 ou supérieur.


# Déroulement

Deux stratégies s'offre à vous, l'une consiste à mettre à jour l'OS puis LinShare,
l'autre consiste à installer la nouvelle version de LinShare sur une nouvelle machine.
Vous pourrez alors restaurer la base de données et l'espace de stockage sur la nouvelle
machine pour enfin réaliser la migration.

Toutefois, la première stratégie n'étant pas valable pour Centos 6. Nous allons détailler
ici la seconde stratégie en se basant sur notre OS favori Debian pour les exemples.


NB: Assurez-vous que votre OS est suffisament à jour pour supporter l'installation requise
de LinShare à savoir Java 8, Tomcat7 ou superieur et MongoDB 3.2.


## Synthèse

 * Installation de la nouvelle version de LinShare
 * Mise en maintenance du serveur LinShare v1.
 * Sauvegarde des données
 * Restauration des données sur ma nouvelle machine
 * Migration de la base de données
 * Démarrage du serveur en mode migration de données
 * Exécution de tâches de migration complémentaires dans l'interface
   d'administration - partie 1
 * Réouverture du service en mode dégradé.
 * Exécution de tâches de migration complémentaires dans l'interface
   d'administration - partie 2
 * Réouverture complète du service.


# Procédure

## Pré-requis

Cette procédure assume que vous utilisez les composants par défaut (Apache2,
Tomcat et PostgreSQL) sur l'OS Debian 8 (Jessie).



## Installation de la nouvelle version de LinShare

* Téléchargement des ressources http://download.linshare.org/versions/2.0.1/

Veuillez récupérer tous les composants présents dans le répertoire de la version
2.0.1 ou supérieure de LinShare.
 * linshare-ui-user.tar.bz2 : Contient la nouvelle interface utilisateur
 * linshare-ui-admin.tar.bz2 : Contient l'interface administrateur
 * linshare-core.war : Contient uniquement le "moteur" de LinShare (API REST only)
 * linshare-core-sql.tar.bz2 : Contient les scripts de migrations SQL.

* Suivre la procédure classique d'installation
Sur votre nouvelle machine, installer LinShare en suivant la documentation officielle : https://github.com/linagora/linshare/blob/master/documentation/FR/installation/linshare-install.md

Une fois LinShare correctement installé et fonctionnelle vous pourrez alors passer à l'étape suivante.


## Configuration du mode maintenance

Vous trouverez dans l'archive linshare-ui-user.tar.bz2 une page dédiée à la mise
en maintenance du serveur au couleur et au design proche de la nouvelle version : error-pages/maintenance.html

Répétez ces opérations sur les deux machines LinShare v1 et v2.

* Créez le répertoire /var/www/linshare-maintenance
* Copiez le contenu du répertoire error-pages dedans le répertoire /var/www/linshare-maintenance/.
* Puis ajouter votre nouveau vhost de maintenance selon le serveur :

 *LinShare v1*

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-maintenance.conf

<VirtualHost *:80>
    ...
    ServerName linshare-user.local
    DocumentRoot /var/www/linshare-maintenance
    DirectoryIndex maintenance.html
    Header set Cache-Control "max-age=0,no-cache,no-store"
    RedirectMatch 302 ^/linshare.+ /
    RedirectMatch 302 ^/linshare$ /
    ...
</Virtualhost>
```

 *LinShare v2*

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-maintenance.conf

<VirtualHost *:80>
    ...
    ServerName linshare-user.local
    DocumentRoot /var/www/linshare-maintenance
    DirectoryIndex maintenance.html
    Header set Cache-Control "max-age=0,no-cache,no-store"
    ErrorDocument 404 /maintenance.404.json
    ...
</Virtualhost>
```


## Activation du mode maintenance sur LinShare V1

Désactivez le vhost utilisateur et activez le vhost de maintenance sur LinShare v1.

```bash
$ a2enmod headers
$ a2ensite linshare-maintenance
$ a2dissite linshare-user
$ systemctl reload apache2
```

La page de maintenance devrait donc apparaitre en lieu et place de l'ancienne interface.

Attention, vérifiez bien que le bouton 'REFRESH THE PAGE' redirige bien vers la page de maintenanance (elle-même).

Vous pouvez donc commencer la migration.


## Sauvegarde des données

* Arrêt du tomcat

```bash
$ systemctl stop tomcat7
```

* Sauvegarde de la base de données : `linshare`

```bash
$ pg_dump -h localhost -U linshare linshare -f dump-linshare.sql
```

* Sauvegarde de la base de données : linshare_data

```bash
$ pg_dump -h localhost -U linshare linshare_data -f dump-linshare-data.sql
```

* Sauvegarde du système de fichiers

Par défaut les données sont stockées sous `/var/lib/linshare`,
un simple snapshot du disque suffira à sauvegarder les données.

## Restauration des données sur ma nouvelle machine

Une fois les sauvegardes réalisées, transférez les dumps SQL 
et l'espace de fichiers `/var/lib/linshare` (via rsync par example) sur la nouvelle machine.


Attention, vous devez prévoir suffisament d'espace disque dans la nouvelle machine
pour y copier les anciennes données. Il sera nécessaire de prévoir au moins le double
de l'espace si vous avez choisi comme backend de stockage le nouveau système de fichiers.

Vous devrez alors supprimer la base de données `linshare` de la nouvelle machine pour charger le dump

```bash
$ systemctl stop tomcat8
$ su - postgres
$ psql
> drop database linshare;
> \i dump-linshare.sql
> \i dump-linshare-data.sql
> \q
```

Une fois cette étape réalisée, vous pouvez passer à la suivante.


# Migration de la base de données

Depuis l'archive contenant les scripts d'initialisation `linshare-core-sql.tar.bz2`
vous pouvez récupérer le script de migration pour la version 2.0.

```bash
$ psql -h localhost -U linshare  linshare
> \i Migration_1.12.0_to_2.0.0.sql
```

Vous pouvez consulter la version de la base de données via la requête suivante `select * from version`.


# Démarrage du serveur en mode migration de données

Une fois l'ancienne base de données chargée et migrée en version 2, assurez vous que le transfert des fichiers `/var/lib/linshare` est bien terminé.
Ensuite, vous devrez basculer dans un mode de transition ou les deux espaces de stockage de fichiers seront actifs en même temps.

N'oubliez pas de mettre: `chown -R tomcat8:tomcat8 my_folder`

Pour ce faire, éditer le fichier linshare.properties:

```
#### JackRabbit storage options ####
# JackRabbit is deprecated but is is still in LinShare for upgrade purpose from v1 to v2.
# you have to uncomment and set the directory parameter according to your previous configuration file.
# linshare.files.directory=${LINSHARE_HOME}/var/lib/linshare/repository
# linshare.db.persistence_manager=org.apache.jackrabbit.core.persistence.pool.PostgreSQLPersistenceManager
```

Décommentez la ligne 86 et indiquez le chemin des données issue de LinShare v1 :

```
linshare.files.directory=/var/lib/linshare/repository
```

Et assurez-vous de la bonne configuration de la brique logicielle de stockage JackRabbit
dans le fichier : /var/lib/linshare/repository/workspaces/default/workspace.xml.
Particulièrement, celle de la base de données utilisée.

```
cat  ./workspaces/default/workspace.xml
<?xml version="1.0" encoding="UTF-8"?>
<Workspace name="default">
		<!--
			virtual file system of the workspace:
			class: FQN of class implementing the FileSystem interface
		-->

		<FileSystem class="org.apache.jackrabbit.core.fs.local.LocalFileSystem">
                <param name="path" value="${wsp.home}"/>
		</FileSystem>
		<!--
			persistence manager of the workspace:
			class: FQN of class implementing the PersistenceManager interface
		-->
		<PersistenceManager class="org.apache.jackrabbit.core.persistence.bundle.PostgreSQLPersistenceManager">
			<param name="url" value="jdbc:postgresql://localhost/linshare_data"/>
			<param name="user" value="linshare"/>
			<param name="password" value="linshare"/>
			<param name="driver" value="org.postgresql.Driver"/>
			<param name="schemaObjectPrefix" value="${wsp.name}_"/>
			<param name="externalBLOBs" value="false"/>
		</PersistenceManager>
	</Workspace>
```

Enfin, vous devez modifier les options de démarrage du Tomcat pour LinShare,
éditer le fichier suivant `/etc/default/tomcat8`

Remplacez la valeur par défaut `-Dspring.profiles.active=default,jcloud,mongo`
par `-Dspring.profiles.active=default,jackrabbit-to-jcloud,mongo,batches` et démarrez Tomcat:

```
$ systemctl start tomcat8
```

Surveillez dans les logs que tout se passe bien : `tail -f /var/log/tomcat8/catalina.out`.

Une fois le serveur démarré, vous devriez pouvoir vous connecter à l'interface d'administration
pour effectuer les dernières tâches de migration avant de rétablir le service.


# Exécution de tâches de migration complémentaires dans l'interface d'administration - partie 1

Pour cette nouvelle version, vous devez réaliser des tâches de migration complémentaires
dans l'interface d'administration : http://linshare-admin.local/#/upgradetasks/list.

Toutes les tâches doivent être éxécutées pour compléter la mise à jour. Ces tâches doivent
être éxécutées dans l'ordre et se terminer avec succès.

NB: Une tâche peut se terminer en succès mais des erreurs peuvent se produire pendant son déroulement.
    Il est donc nécessaire de bien vérifier les rapports d'éxécution présent dans la console.
    En cas d'erreur, il sera nécessaire de consulter les rapports du serveur Tomcat pour plus de détail,
    de résoudre le problème et de relancer la tâche avant de continuer.

* Tant que les tâches en status 'Obligatoire' ne sont pas complétées, il sera impossible pour
les utilisateurs d'utiliser le système.

* Tant que les tâches en status 'Requis' ne sont pas complétées,
le système fonctionnera en mode dégradé. Certaines fonctionnalités ou données ne seront pas
accessibles. Ces tâches pourront être exécutées en parallèle de l'activité des utilisateurs.

Une fois les tâches obligatoires exécutées, vous pouvez passez à l'étape suivante si vous souhaitez
rétablir le service LinShare le plus rapidement possible.
En effet les tâches requises peuvent être très longues en fonction de votre volumétrie.

Attention : L'ensemble du paramétrage des fonctionnalités ainsi que les modèles de courriel ont été 
réinitialisé par le script de migration SQL. Vous devez donc reconfigurer vos paramètres avant de 
lancer les taches de migration, tel que les durées d'expiration, l'URL et l'adresse de courriel 
utilisées lors de l'envoi de notifications.

# Réouverture du service en mode dégradé

Deux solutions sont possibles, soit vous avez une nouvelle URL pour la nouvelle instance de LinShare soit
vous réutilisez l'ancienne URL.

Si vous utilisez, la même URL il vous suffira de faire la bascule DNS pour
que votre nom public pointe vers la nouvelle machine. Modifiez également le
vhost linshare-user en ajoutant ces instructions pour rediriger les URLs des
anciens couriels vers les nouvelles URLs.


```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-user.conf

<VirtualHost *:80>
    ...

    RewriteEngine  on
    # Rewrite for workgroup url
    RewriteCond %{REQUEST_URI}  ^/linshare/.*/thread/content/(.*)$
    RewriteRule ^/(.*) http://%{SERVER_NAME}/#/sharedspace/workgroups/%1/ [NE,R=302,L]

    # Rewrite for workgroup url
    RewriteCond %{REQUEST_URI}  ^/linshare/thread/content/(.*)$
    RewriteRule ^/(.*) http://%{SERVER_NAME}/#/sharedspace/workgroups/%1/ [NE,R=302,L]

    # Rewrite for received share URL
    RewriteCond %{REQUEST_URI}  ^/linshare/index.listshareddocument.download/(.*)$
    RewriteRule ^/(.*) http://%{SERVER_NAME}/#/files/received?fileUuid=%1 [NE,R=302,L]

    # Rewrite for document URL
    RewriteCond %{REQUEST_URI}  ^/linshare/index.listdocument.download/(.*)$
    RewriteRule ^/(.*) http://%{SERVER_NAME}/#/files/list?fileUuid=%1 [NE,R=302,L]

    # Rewrite for anonymous URL
    RewriteCond %{REQUEST_URI}  ^/linshare/download/(.*)$
    RewriteRule ^/(.*) http://%{SERVER_NAME}/#/external/anonymous/%1 [NE,R=302,L]

    ...
</Virtualhost>
```
> Note: </br>
Ces instructions doivent être ajoutées avant les instructions RedirectMatch pour être prise en compte.

Si vous déployez LinShare v2 sur une nouvelle URL, par exemple http://linshare-user-v2.local, vous pouvez
utiliser la procédure de bascule ci-dessous.

* Création d'un vhost migration sur LinShare v1

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-migration.conf

<VirtualHost *:80>
    ...
    ServerName linshare-user.local
    DocumentRoot /var/www/linshare-maintenance
    DirectoryIndex migration.html
    Header set Cache-Control "max-age=0,no-cache,no-store"


    RewriteEngine  on
    # Rewrite for workgroup url
    RewriteCond %{REQUEST_URI}  ^/linshare/.*/thread/content/(.*)$
    RewriteRule ^/(.*) http://new.server.com/#/sharedspace/workgroups/%1/ [NE,R=302,L]

    # Rewrite for workgroup url
    RewriteCond %{REQUEST_URI}  ^/linshare/thread/content/(.*)$
    RewriteRule ^/(.*) http://new.server.com/#/sharedspace/workgroups/%1/ [NE,R=302,L]

    # Rewrite for received share URL
    RewriteCond %{REQUEST_URI}  ^/linshare/index.listshareddocument.download/(.*)$
    RewriteRule ^/(.*) http://new.server.com/#/files/received?fileUuid=%1 [NE,R=302,L]

    # Rewrite for document URL
    RewriteCond %{REQUEST_URI}  ^/linshare/index.listdocument.download/(.*)$
    RewriteRule ^/(.*) http://new.server.com/#/files/list?fileUuid=%1 [NE,R=302,L]

    # Rewrite for anonymous URL
    RewriteCond %{REQUEST_URI}  ^/linshare/download/(.*)$
    RewriteRule ^/(.*) http://new.server.com/#/external/anonymous/%1 [NE,R=302,L]
    RedirectMatch 302 ^/linshare.+ / 
    RedirectMatch 302 ^/linshare$ /
    ...
</Virtualhost>
```

Editez le fichier migration.html pour renseigner votre nouvelle URL à la place
de la valeur par défaut : `onclick="goTo('http://new.server.com')`.

Désactivez le vhost maintenance et activez le vhost de migration:

```bash
$ a2enmod headers
$ a2ensite linshare-migration
$ a2dissite linshare-maintenance
$ systemctl reload apache2
```

Une nouvelle page invitera les utilisateurs à se rendre vers votre nouvelle URL.


# Exécution de tâches de migration complémentaires dans l'interface d'administration - partie 2

Si vous avez décidé de rétablir le service en mode dégradé, vous devez compléter les tâches requises
avant de passer à l'étape suivante. L'éxécution des tâches requises peut prendre beaucoup de temps.

Une fois celles-ci terminées, votre instance de LinShare sera pleinement opérationnelle.


# Finalisation de la migration


## étape 1 : Retour au mode nominal

Afin de terminer la migration, il est nécessaire de désactiver l'ancien backend de fichiers 
et de se débarasser des données inutiles. Cette étape peut être réaliser pendant une période de
faible influence pour limiter l'impact de la coupure.

* Mise en mode maintenance

```
$ a2ensite linshare-maintenance
$ a2dissite linshare-ui-user
$ systemctl reload apache2
```

* Arrêt du service Tomcat `$ systemctl stop tomcat8`

* Désactivation de l'ancien espace de stockage :

Vous devez éditer le fichier suivant `/etc/default/tomcat8` et restaurer votre valeur initiale :
`-Dspring.profiles.active=default,jcloud,mongo`

* Démarrage du service Tomcat

```
$ systemctl start tomcat8`
```

* Désactivation du mode maintenance

```
$ a2ensite linshare-ui-user
$ a2dissite linshare-maintenance
$ systemctl reload apache2
```

## étape 2 : Suppression des données inutiles

Vous pouvez maintenant supprimer les données sans couper le service.

* Supprimez l'ancienne base de données :

```bash
$ su - postgres
$ psql
> drop database linshare_data;
> \q
```

* Supprimez l'ancien espace de stockage, cf clé de configuration `linshare.files.directory` :

```
* rm -frv /var/lib/linshare/repository
```

