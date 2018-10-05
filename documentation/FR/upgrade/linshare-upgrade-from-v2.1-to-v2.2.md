# Guide de mise à jour de LinShare

> Remarque :</br>
 - Nous expliquons dans ce guide comment mettre à jour votre instance LinShare. </br>
 - Tous les composants se trouvant dans (http://download.linshare.org/version/{VERSION}) doivent être mis à jour ensemble. </br>
 Chaque dossier de version LinShare, contient toutes les dépendances requises pour installer correctement cette version. </br>


## Sommaire

* [Remarques sur les versions de LinShare](#lversions)
* [composants nécessaires](#artifacts)
* [Sauvegarde](#backup)
* [Mise à jour de LinShare-core](#core)
* [Mise à jour de LinShare-ui-admin](#ui-admin)
* [Mise à jour de LinShare-ui-user](#ui-user)
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

Pour cette migration, il faut télécharger les fichiers suivants à partir de cette adresse http://download.linshare.org/versions/2.2.0 :

  * __linshare-core-2.2.0-1.war__

  * __linshare-core-2.2.0-sql.tar.bz2__

  * __linshare-ui-admin-3.2.0.tar.bz2__

  * __linshare-ui-user-2.2.0-1.tar.bz2__

> Remarque :</br>
 - Télécharger tous les composants dans le répertoire `/root/downloads` </br>

<a name="backup">

## Backups :

</a>

Afin d'éviter tout effet indésirable suite aux opérations critiques, il est préférable de stocker une sauvegarde de vos bases de données PostgreSQL et MongoDB.

Pour ce faire, veuillez exécuter ces commandes:

* Postgres Linshare dump :

         pg_dump -h host -p port -U linshare -W  -f dump-linshare.sql

* MongoDb Linshare dump

         mongodump --host `host` --port `port`


<a name="core">
## Mettre à jour LinShare-core
</a>

Premièrement vous devez arrêter le service Apache et le service Tomcat:

```bash
$ systemctl apache2 stop
```
```bash
$ systemctl stop tomcat8
```  
Une fois le service Tomcat est arrêté, vous pouvez extraire le contenu de `linshare-core-2.2.0-sql.tar.bz2` en utilisant cette commande :
```bash
$ tar xjvf  /root/downloads/linshare-core-2.2.0-sql.tar.bz2
```
Récupérez maintenant le script SQL nécessaire pour la migration, nommé : `linshare-core-2.2.0-sql/postgresql/Migration_2.1.0_to_2.2.0.sql`

> Remarque :
  - Les scripts de migration sont spécifiques à chaque système de gestion de base de données et suivent le modèle de nommage suivant : `Migration_X.A.0_to_X.B.0.sql`.
  - Vous avez un répertoire par système de gestion de base de données pris en charge.

Afin de mettre à jour LinShare de 2.1 à 2.2 vous devez toujours exécuter ce script :
```bash
$ psql -h localhost -d linshare -U linshare -f Migration_2.1.0_to_2.2.0.sql
```
Vous pouvez afficher la version de la base de données en exécutant la requête suivante `select * from version`.

Une fois la migration du schéma de la base de données est terminée, vous devez remplacer __linshare.war__ par __linshare-core-2.2.0-1.war__

```bash
$ rm /var/lib/tomcat8/webapps/linshare.war
$ rm -fr /var/lib/tomcat8/webapps/linshare
$ cp  /root/downloads/linshare-core-2.2.0-1.war /var/lib/tomcat8/webapps/linshare.war
```
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
$ tar xjvf /root/downloads/linshare-ui-admin-3.2.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-admin
```
<a name="ui-user">
## Mise à jour de LinShare-ui-user
</a>

Déployez l'archive de l'application __LinShare UI User__ dans le dossier Apache 2 :

```
$ cd /var/www/
$ rm linshare-ui-user
$ tar xjvf  /root/downloads/linshare-ui-user-2.2.0-1.tar.bz2
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

> Note :
  Attention : L'ensemble du paramétrage des fonctionnalités ainsi que les modèles de courriel ont été
  réinitialisés par le script de migration SQL. Vous devez donc reconfigurer vos paramètres avant de
  lancer les tâches de migration, tel que les durées d'expiration, l'URL et l'adresse de courriel
  utilisées lors de l'envoi de notifications.

Une fois toutes ces tâches effectuées, votre instance LinShare sera opérationnelle.
