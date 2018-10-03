# LinShare upgrade guide

> Note :</br>
 - We explain in this file how to upgrade your LinShare's version. </br>
 - Please note that all the components found in each LinShare's version
(http://download.linshare.org/version/{VERSION}) must be upgraded together.
 </br>
Each LinShare version folder, contains the dependencies required to install the version properly. </br>


## Overview

* [Note about LinShare versions](#lversions)
* [Necessary artifacts](#artifacts)
* [Backups](#backup)
* [Upgrade LinShare core](#core)
* [Upgrade LinShare ui-admin](#ui-admin)
* [Upgrade LinShare ui-user](#ui-user)
* [Upgrade tasks](#tasks)

<a name="lversions">

## LinShare Versions

</a>

LinShare version number are named according to the [following pattern](https://semver.org/)

X.Y.Z.

* X : Major release
A major version can bring disruptive changes, among which addition/replacement/removal of technologies used in the product.
They could break compatibility between two versions of LinShare.

* Y : Minor release
A minor version brings new functionalities and possibly database schema modification.

* Z : Maintenance release
Only bug fixes. No database schema modification.

<a name="artifacts">

## Necessary artifacts

</a>

For this migration, download the following files from this address: http://download.linshare.org/versions/2.2.0 :

  * __linshare-core-2.2.0.war__

  * __linshare-core-2.2.0-sql.tar.bz2__

  * __linshare-ui-admin-3.2.0.tar.bz2__

  * __linshare-ui-user-2.2.0.tar.bz2__

> Note :</br>
 - Download all components  on `/root/downloads` directory</br>

<a name="backup">

## Backups :

</a>

To avoid any side effect of these critical operations, it is better to store a backup of your database postgres and mongo.

To do that please execute these commands :

 * Postgres Linshare dump :

        pg_dump -h host -p port -U linshare -W  -f dump-linshare.sql

 * MongoDb Linshare dump

        mongodump --host `host` --port `port`

<a name="core">

## Upgrade LinShare-core

</a>

First you need to stop Apache service and tomcat service:

```
$ systemctl apache2 stop
```
```bash
$ systemctl stop tomcat8
```  
Once your service tomcat is stopped, you should extract the content of `linshare-core-2.2.0-sql.tar.bz2` by using this command:
```bash
$ tar xjvf  /root/downloads/linshare-core-2.2.0-sql.tar.bz2
```
Then you will find the necessary file for the migration, named `linshare-core-2.2.0-sql/postgresql/Migration_2.1.0_to_2.2.0.sql`

Migration scripts are specific for each database management system.
You have one directory by supported database management system.
All scripts are named according to the following pattern "Migration_X.A.0_to_X.B.0.sql".

In order to upgrade LinShare from 2.1 to 2.2 you ALWAYS need to run the script :
```bash
$ psql -h localhost -d linshare -U linshare -f Migration_2.1.0_to_2.2.0.sql
```
You can view the database version through the following query `select * from version`.

Once the migration file is done, you should replace the linShare.war with LinShare-core-2.2.0.war

```bash
$ rm /var/lib/tomcat8/webapps/linShare.war
$ rm -fr /var/lib/tomcat8/webapps/linshare
$ cp  /root/downloads/linshare-core-2.2.0.war /var/lib/tomcat8/webapps/linshare.war
```
Now you can start your tomcat again

```bash
$ systemctl start tomcat8
```

<a name="ui-admin">

## Upgrade LinShare-ui-admin

</a>

Deploy the archive of the application __LinShare UI Admin__ in the Apache 2 repository :

```
$ cd /var/www/
$ rm linshare-ui-admin
$ tar xjvf /root/downloads/linshare-ui-admin-3.2.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-admin
```
<a name="ui-user">

## Upgrade LinShare-ui-user
</a>

Deploy the archive of the application __LinShare UI User__ in the Apache 2 repository :

```
$ cd /var/www/
$ rm linshare-ui-user
$ tar xjvf  /root/downloads/linshare-ui-user-2.2.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-user
```
Now you can start your Apache service again.

```
$ systemctl apache2 start
```
<a name="tasks">

## Upgrade task execution in the administration interface
</a>

For this new version, you need to run further migration tasks in the
admin interface : http://linshare-admin.local/#/upgradetasks/list.

All the tasks must be executed by order and succeed in order to complete the upgrade.  

NB: A task can finish with a successful status but errors can be noticed during the progress.
    It is necessary to check the execution reports found in the console.
    In case of errors, you must read the logs of Tomcat server for more details,
    resolve the problems and launch the task before carrying on.

* As long as the tasks with status 'Mandatory' are not completed, the users can not
use the system.

* As long as the tasks with status 'Required' are not completed,
the system will work partially (Some functionality might be deactivated).
These tasks can be executed simultaneously without disrupting the user's activity.

Once the mandatory tasks have been executed, you can switch to the next step if you want to
re-establish quickly the LinShare service.
The required tasks can take some time depending on amout of data.

Once all these tasks are done, your LinShare app will be operational.