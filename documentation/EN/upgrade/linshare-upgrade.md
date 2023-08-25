# LinShare upgrade guide

> Note :
- We explain in this file how to upgrade your LinShare's version. </br>
- Please note that all the components found in each LinShare's version
  (http://download.linshare.org/versions/{VERSION}) must be upgraded together.  
  Each LinShare version folder, contains the dependencies required to install the version properly. </br>
- You can find the required versions of LinShare's dependencies [here](../installation/requirements.md)
- This documentation is only a general guide, each specific actions to perform for each migration will be detailed in its file `linshare-upgrade-from-X-to-Y.md` 


## Overview

* [Note about LinShare versions](#lversions)
* [Migration scripts](#scripts)
* [Backups](#backup)
* [Upgrade tasks](#tasks)

<a name="lversions">

## LinShare Versions

</a>

LinShare versions number are named according to the [following pattern](https://semver.org/)

X.Y.Z.

* X : Major release
  A major version can bring disruptive changes, among which addition/replacement/removal of technologies used in the product.
  They could break compatibility between two versions of LinShare.

* Y : Minor release
  A minor version brings new functionalities and possibly database schema modification.

* Z : Maintenance release
  Only bug fixes. No database schema modification.


<a name="scripts">

## Migration scripts

</a>
Migration scripts are specific for each database management system.
You have one directory by supported database management system.
All scripts are named according to the following pattern
"Migration_X.A.0_to_X.B.0.sql".

In order to upgrade LinShare from 1.1 to 1.4 you ALWAYS need to run all scripts :
1. Migration_1.1.0_to_1.2.0.sql
2. Migration_1.2.0_to_1.3.0.sql
3. Migration_1.3.0_to_1.4.0.sql


 <a name="backup">

## Backups :

 </a>

To avoid any side effect of these critical operations, it is better to store a backup of your databases `PostgreSQL` and `MongoDB`.

> Note :  
In this upgrade guide we consider that the default databases PostgreSQL and MongoDB are named `linshare`

To do that please execute these commands :

* Postgres `linshare` dump:

```bash
         pg_dump -h `host` -p `port` -U linshare -W  -f dump-linshare.sql
```

* MongoDb `linshare` dump:

For mongo you can just dump `linshare` database and avoid dumping `linshare-files` because it contains only thumbnail and mail attachments, it won't be impacted by the upgrade process.

```bash
         mongodump --host `host` --port `port` --db=linshare
```


 <a name="tasks">

## Upgrade task execution in the administration interface
 </a>

These are automated task, that you must launch from the administration interface : http://`YourServerName`/#/upgradetasks/list.

All the tasks must be executed by order and succeed in order to complete the upgrade.

NB: A task can finish with a successful status but errors can be noticed during the progress.
It is necessary to check the execution reports found in the console.
In case of errors, you must read the logs of Tomcat server for more details,
resolve the problems and re-launch the task.

* As long as the tasks with status `Mandatory` are not completed, the users can not
  use the system.

* As long as the tasks with status `Required` are not completed,
  the system will work partially (Some functionalities might be deactivated).
  These tasks can be executed simultaneously without disrupting the user's activity.

Once the mandatory tasks have been executed, you can switch to the next step if you want to re-establish quickly the LinShare service.
The required tasks can take some time depending on amount of data to upgrade.

Once all these tasks are done, your LinShare will be operational.

> Note:  
> Some task will require you to have a temporary configuration in your properties file.   
> For instance the task `OPTIONAL_MIGRATE_FILE_DATA_STORAGE_TO_A_NEW_ONE` (which copies files from gridfs storage to jcloud storage), needs to have both filesystem configured at the same time. you can later remove the old configuration.


