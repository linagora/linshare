# Guide de mise à jour de LinShare

> Remarque :</br>
 - Nous expliquons dans ce guide comment mettre à jour votre version de LinShare. </br>
 - Tous les fichiers se trouvant dans (http://download.linshare.org/version/{VERSION}) doivent être migrés ensemble. </br>
 Chaque dossier de version LinShare, contient toutes les dépendances requises pour installer correctement cette version. </br>


## Sommaire

* [Remarque sur les versions de LinShare](#lversions)
* [Artefacts nécessaires](#artifacts)
* [Mettre à jour LinShare-core](#core)
* [Mettre à jour LinShare-ui-admin](#ui-admin)
* [Mettre à jour LinShare-ui-user](#ui-user)
* [Tâches de migration complémentaires ](#tasks)
* [Déploiement du moteur de d'aperçus (optionnel)](#thumbnail)

<a name="lversions">
## Remarque sur les versions de LinShare
</a>

Le numéro de version de LinShare est nommé selon le modèle suivant
X.Y.Z.

* X : Version majeure

Une version majeure peut apporter des changements critiques, parmi lesquels l'ajout/ remplacement ou la suppression des technologies utilisées dans le produit.
Ils pourraient provoquer des incompatibilités entre deux versions de LinShare.

* Y : Version mineure

Une version mineure apporte de nouvelles fonctionnalités et éventuellement des modifications sur le schéma de la base de données.

* Z : Version de maintenance

Seulement des corrections de bugs. Aucune modification du schéma de la base de données.

<a name="artifacts">
## Artefacts nécessaires
</a>

Pour cette migration, il faut télécharger les fichiers suivants à partir de cette adresse http://download.linshare.org/versions/2.1.0 :

  * __linshare-core-2.1.0.war__

  * __linshare-core-2.1.0-sql.tar.bz2__

  * __linshare-ui-admin-3.1.0.tar.bz2__

  * __linshare-ui-user-2.1.0.tar.bz2__

> Remarque :</br>
 - Télécharger tous les composants dans le répertoire `/root/downloads` </br>

<a name="core">
## Mettre à jour LinShare-core
</a>

Premièrement vous devez arrêter le service Apache et le service tomcat:

```bash
$ systemctl apache2 stop
```
```bash
$ systemctl stop tomcat8
```  
Une fois le service tomcat est arrêté, vous pouvez extraire le contenu de `linshare-core-2.1.0-sql.tar.bz2` en utilisant cette commande :
```bash
$ tar xjvf  /root/downloads/linshare-core-2.1.0-sql.tar.bz2
```
Vous trouverez maintenant le script SQL nécessaire pour la migration, nommé : `linshare-core-2.1.0-sql/postgresql/Migration_2.0.0_to_2.1.0.sql`

> Remarque :
  - Les scripts de migration sont spécifiques à chaque système de gestion de base de données et suivent le modèle de nommage suivant : `Migration_X.A.0_to_X.B.0.sql`.
  - Vous avez un répertoire par système de gestion de base de données pris en charge.

Afin de mettre à jour LinShare de 2.0 à 2.1 vous devez toujours exécuter ce script :
```bash
$ psql -h localhost -d linshare -U linshare -f Migration_2.0.0_to_2.1.0.sql
```
Vous pouvez afficher la version de la base de données en exécutant la requête suivante `select * from version`.

Une fois la migration du schéma de la base de données est terminée, vous devez remplacer __linshare.war__ par __Linshare-core-2.1.0.war__

```bash
$ rm /var/lib/tomcat8/webapps/linShare.war
$ rm -fr /var/lib/tomcat8/webapps/linshare
$ cp  /root/downloads/linshare-core-2.1.0.war /var/lib/tomcat8/webapps/linshare.war
```
##### Activation des batches

Dans LinShare 2.1, les batches sont activés par défaut.
Ce profil permet à LinShare d'exécuter des processus en arrière plan, l'activation/désactivation de toutes les tâches planifiées (ex: la suppression des partages expirés), l'envoi de notifications... Le but de ces processus est d'optimiser les données de LinShare, telles que la suppression permanente des fichiers du disque dur.

Si vous avez modifié les valeurs par défaut de la 2.0 (`-Dspring.profiles.active=default,jcloud,mongo`) pour activer différents profiles, vous devez alors mettre à jour votre configuration en ajoutant le nouveau profil __Batches__. La valeur par défaut pour LinShare 2.1 est : `Dspring.profiles.active=default,jcloud,mongo,batches`.

Vous pouvez maintenant démarrer à nouveau le service Tomcat :

```bash
$ systemctl start tomcat8
```

<a name="ui-admin">
## Mettre à jour LinShare-ui-admin
</a>

Déployez l'archive de l'application __LinShare UI Admin__ dans le dossier Apache 2 :

```
$ cd /var/www/
$ rm linshare-ui-admin
$ tar xjvf /root/downloads/linshare-ui-admin-2.1.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-admin
```
<a name="ui-user">
## Mise à jour de LinShare-ui-user
</a>

Déployez l'archive de l'application __LinShare UI User__ dans le dossier Apache 2 :

```
$ cd /var/www/
$ rm linshare-ui-user
$ tar xjvf  /root/downloads/linshare-ui-user-2.1.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-user
```

Vous pouvez maintenant démarrer le service Apache.

```
$ systemctl apache2 start
```
<a name="tasks">
## Tâches de migration complémentaires
</a>

Pour cette nouvelle version, vous devez réaliser des tâches de migration complémentaires
dans l'interface d'administration : http://linshare-admin.local/#/upgradetasks/list.

Toutes les tâches doivent être éxécutées pour compléter la mise à jour. Ces tâches doivent
être éxécutées dans l'ordre et se terminer avec succès.

> NB: Une tâche peut se terminer en succès mais des erreurs peuvent se produire pendant son déroulement.
    Il est donc nécessaire de bien vérifier les rapports d'éxécution présent dans la console.
    En cas d'erreur, il sera nécessaire de consulter les rapports du serveur Tomcat pour plus de détails,
    de résoudre le problème et de relancer la tâche avant de continuer.

* Tant que les tâches en statut __Obligatoire__ ne sont pas complétées, il sera impossible pour
les utilisateurs d'utiliser le système.

* Tant que les tâches en statut __Requis__ ne sont pas complétées,
le système fonctionnera en mode dégradé. Certaines fonctionnalités ou données ne seront pas
accessibles. Ces tâches pourront être exécutées en parallèle de l'activité des utilisateurs.

Une fois les tâches obligatoires exécutées, vous pouvez passez à l'étape suivante si vous souhaitez
rétablir le service LinShare le plus rapidement possible.
En effet les tâches requises peuvent être très longues en fonction de votre volumétrie.

Attention : L'ensemble du paramétrage des fonctionnalités ainsi que les modèles de courriel ont été
réinitialisé par le script de migration SQL. Vous devez donc reconfigurer vos paramètres avant de
lancer les tâches de migration, tel que les durées d'expiration, l'URL et l'adresse de courriel
utilisées lors de l'envoi de notifications.

Si vous avez décidé de redémarrer le service en mode fonctionnalités dégradé, vous devez effectuer les tâches requises avant d'aller plus loin.
L'accomplissement des tâches requises peut prendre beaucoup de temps.

Une fois toutes ces tâches effectuées, votre application LinShare sera opérationnelle.

<a name="thumbnail">
## Activation du moteur d'aperçu (Optionnel)
</a>
LinShare dispose d'un moteur de génération d'aperçu pour plusieurs types de fichiers :

- Formats OpenDocument (ODT, ODP, ODS, ODG)
- Formats de documents Microsoft (DOCX, DOC, PPTX, PPT, XLSX, XLS)
- PDF
- Fichiers images (PNG, JPEG, JPG, GIF)
- Fichiers texte (TXT, XML, LOG, HTML, ...)

> Note:<br/>
    * Avant d'activer le module vous devez avoir installé LibreOffice ou OpenOffice,
    la version minimale requise pour LibreOffice est : 4.2.8.

Pour installer LibreOffice, exécutez la commande suivante dans votre terminal :

     aptitude update
     aptitude install libreoffice

Par défault le moteur de génération d'aperçus est mis à FALSE. Pour l'activer vous devez modifier le fichier de configuration de LinShare comme ceci :
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

Vous avez également la possibilité d'utiliser le moteur d'aperçus à distance. Pour cela il faut d'abord activer le remote.mode :

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```

Vous pouvez maintenant, allez à cette adresse `http://download.linshare.org/versions/` et téléchargez les fichiers suivants :

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Note <br>
Par défaut, le serveur est configuré pour écouter sur le port 80, vous pouvez le changer, si nécessaire.

Copiez le fichier `linshare-thumbnail-server-{VERSION}.yml` dans `/etc/linshare/linshare-thumbnail-server.yml` et copiez aussi l'archive java `linshare-thumbnail-server-{VERSION}.jar` dans le répertoire  `/usr/local/sbin/linshare-thumbnail-server.jar`, à l'aide des commandes suivantes :

```java
cp linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
```
```java
cp linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

* Vous pouvez automatiser le lancement du serveur d'aperçus, en créant un service `systemd` sur le répertoire `/etc/systemd/system`, nommez-le comme suit `linshare-thumbnail-server.service`.

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

Pour démarrer le serveur __Thumbnail__, vous devez redémarrer le service Tomcat d'abord :

`[root@localhost ~]$ systemctl restart Tomcat`

Exécutez la commande suivante pour démarrer le service d'aperçus :

`systemctl start linshare-thumbnail-server.service`
