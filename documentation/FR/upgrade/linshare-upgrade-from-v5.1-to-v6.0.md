# Guide de mise à jour de LinShare

> Remarque :</br>
 - Nous expliquons dans ce guide comment mettre à jour votre instance LinShare. </br>
 - Tous les composants se trouvant dans (http://download.linshare.org/version/{VERSION}) doivent être mis à jour ensemble. </br>
 Chaque dossier de version LinShare, contient toutes les dépendances requises pour installer correctement cette version. </br>
 - Vous pouvez trouver les versions des dépendances requises pour le fonctionnement de LinShare [ici](../installation/requirements.md)


## Sommaire

* [Remarques sur les versions de LinShare](#lversions)
* [composants nécessaires](#artifacts)
* [Sauvegarde](#backup)
* [Mise à jour des dépendances](#upgrade-dependencies)
* [Mise à jour de LinShare-core](#core)
* [Mise à jour de LinShare-ui-admin](#ui-admin)
* [Mise à jour de LinShare-ui-user](#ui-user)
* [Mise à jour de LinShare-ui-upload-request](#ui-upload-request)
* [Tâches de migration complémentaires ](#tasks)

<a name="lversions">

## Remarques sur les versions de LinShare
</a>

Le numéro de version de LinShare est nommé selon le [modèle suivant](https://semver.org/)
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

Dans cette version de LinShare, une nouvelle interface d'administration est introduite, nous aurons donc besoin de deux composants ui-admin (l'ancien et le nouveau composant), comme cela sera expliqué plus tard.
Notre objectif pour l'avenir est d'implémenter toutes les fonctionnalités de l'ancienne interface dans la nouvelle.

Pour cette migration, il faut télécharger les fichiers suivants à partir de cette adresse http://download.linshare.org/versions/6.0.0 :

* __linshare-core-6.0.0.war__

* __linshare-core-6.0.0-sql.tar.bz2__

* __linshare-ui-admin-6.0.0.tar.bz2__

* __linshare-ui-admin-4.2.7-legacy1.tar.bz2__

* __linshare-ui-user-6.0.0.tar.bz2__

* __linshare-ui-upload-request-6.0.0.tar.bz2__


> Remarque :</br>
 - Télécharger tous les composants dans le répertoire `/root/downloads` </br>

<a name="backup">

## Prérequis :
</a>
Afin d'éviter que les tâches lancées via l'interface d'administration durent beaucoup trop longtemps, il faut s'assurer que les indexes sont présents sur la base mongo.
Pour les créer :

```bash
mongosh --host IP --port PORT
use linshare;
db.audit_log_entries.createIndex({"domain.uuid":1})
db.audit_log_entries.createIndex({"actor.uuid":1})
```

## Backups :

</a>

Afin d'éviter tout effet indésirable suite aux opérations critiques, il est préférable de stocker une sauvegarde de vos bases de données PostgreSQL et MongoDB.

> Note :</br>
Dans ce guide de migration on considère que les bases de données par défauts sont nommées `linshare`

Pour ce faire, veuillez exécuter ces commandes:

* Postgres `linshare` dump :

```bash
       pg_dump -h `host` -p `port` -U linshare -W  -f dump-linshare.sql
```
* MongoDb `linshare` dump

Pour Mongo on peut faire le dump juste sur la base de données `linshare`, car `linshare-files` ne contient que les thumbnails et les mail attachments, elle ne sera pas impacter avec la procédure de migration.

```bash
         mongodump --host `host` --port `port` --db=linshare
```

<a name="upgrade-dependencies">

## Mise à jour des dépendances

</a>

* **PostgreSQL 13**
Nous avons mis à jour PostgreSQL 11 en PostgreSQL 13. [Guide de Migration](https://docs.postgresql.fr/13/upgrading.html)

* **MongoDB**
Nous avons mis à jour Mongo 4.2 en Mongo 5.0. [Guide de Migration](https://www.mongodb.com/docs/manual/release-notes/5.0-upgrade-standalone/)


<a name="core">

## Mettre à jour LinShare-core
</a>

Premièrement vous devez arrêter le service Apache et le service Tomcat:

```bash
$ systemctl stop apache2
```
```bash
$ systemctl stop tomcat9.service
```

Une fois le service Tomcat est arrêté, vous pouvez extraire le contenu de `linshare-core-6.0.0-sql.tar.bz2` en utilisant cette commande :

```bash
$ tar xjvf  /root/downloads/linshare-core-6.0.0-sql.tar.bz2
```
Récupérez maintenant le script SQL nécessaire pour la migration, nommé : `linshare-core-6.0.0-sql/postgresql/Migration_5.1.0_to_6.0.0.sql`

Afin de mettre à jour LinShare de 5.1 à 6.0 vous devez exécuter ce script :

```bash
$ psql -h `host` -d linshare -U linshare -f Migration_5.1.0_to_6.0.0.sql
```
Si ce script produit ce type d'erreur:
```bash
ERROR:  permission denied to create extension "uuid-ossp"
HINT:  Must be superuser to create this extension.
```
alors, vous devrez exécuter les commandes suivantes:
```bash
$ su - postgres
$ psql
postgres=# CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```
enfin, vous pourrez rejouer le script de migration.


Vous pouvez afficher la version de la base de données en exécutant la requête suivante `select * from version`.

Une fois la migration du schéma de la base de données est terminée, vous devez remplacer `linShare.war` par `LinShare-core-6.0.0.war`

```bash
$ rm /var/lib/tomcat9/webapps/linshare.war
$ rm -fr /var/lib/tomcat9/webapps/linshare
$ cp  /root/downloads/linshare-core-6.0.0.war /var/lib/tomcat9/webapps/linshare.war
```

Si vous aviez défini une configuration de Log4J particulière, vous devez la modifier, en effet nous avons migrer à Log4J 2.0.
Vous pouvez suiver le [guide de migration](../administration/how-to-migrate-log4j-configuration.md) à cet effet.

Vous pouvez maintenant démarrer à nouveau le service Tomcat :

```bash
$ systemctl start tomcat9.service
```

<a name="ui-admin">

## Mettre à jour LinShare-ui-admin
</a>

Comme mentionné précédemment pour l'application __LinShare UI Admin__, nous aurons besoin de deux composants, vous pouvez suivre les étapes ci-dessous pour les déployer dans le référentiel apache2 :

```
$ cd /var/www/
$ rm -rf linshare-ui-admin
$ tar xjvf /root/downloads/linshare-ui-admin-4.2.7-legacy1.tar.bz2
$ chown -R www-data: linshare-ui-admin
$ cd linshare-ui-admin
$ tar xjf /tmp/linshare_data/linshare-ui-admin-6.0.0.tar.bz2
$ mv linshare-ui-admin new
```
<a name="ui-user">

## Mise à jour de LinShare-ui-user
</a>

Déployez l'archive de l'application __LinShare UI User__ dans le dossier Apache2 :

```
$ cd /var/www/
$ rm linshare-ui-user
$ tar xjvf  /root/downloads/linshare-ui-user-6.0.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-user
```

<a name="ui-upload-request">

## Upgrade LinShare-ui-upload-request
</a>

Déployez l'archive de l'application __LinShare UI Upload Request__ dans le dossier Apache2 :

```
$ cd /var/www/
$ rm -rf linShare-ui-upload-request
$ tar xjvf  /root/downloads/linshare-ui-upload-request-6.0.0.tar.bz2
$ chown -R www-data: linshare-ui-upload-request
```

Vous pouvez maintenant démarrer le service Apache.

```bash
$ systemctl start apache2
```

<a name="tasks">

## Tâches de migration complémentaires
</a>

Pour cette nouvelle version, vous devez réaliser des tâches de migration complémentaires
dans l'interface d'administration : http://linshare-admin.local/#/upgradetasks/list.

Toutes les tâches doivent être éxécutées pour compléter la mise à jour. Ces tâches doivent
être éxécutées __dans l'ordre__ et se terminer __avec succès__.

> NB: Une tâche peut se terminer en succès mais des erreurs peuvent se produire pendant son déroulement.
    Il est donc nécessaire de bien vérifier les rapports d'éxécution présents dans la console.
    En cas d'erreur, il sera nécessaire de consulter les rapports du serveur Tomcat pour plus de détails,
    de résoudre le problème et de relancer la tâche avant de continuer.

* Tant que les tâches en statut __Obligatoire__ ne sont pas complétées, il sera impossible pour
les utilisateurs d'utiliser le système.

* Tant que les tâches en statut __Requis__ ne sont pas complétées,
le système fonctionnera en mode dégradé. Certaines fonctionnalités ou données ne seront pas
accessibles. Ces tâches pourront être exécutées en parallèle de l'activité des utilisateurs.

Une fois les tâches obligatoires exécutées, effectuez les tâches requises avant de relancer votre application LinShare.
Si des tâches requises n'ont pas été correctement exécutées, votre application sera lancée en mode fonctionnalités dégradées.
Notez que l'exécution des tâches requises peut prendre plus ou moins de temps en fonction de votre volumétrie de données.

Une fois toutes ces tâches effectuées, votre instance LinShare sera opérationnelle.
