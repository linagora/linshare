# LinShare upgrade guide

> Note :
 - We explain in this file how to upgrade your LinShare's version. </br>
 - Please note that all the components found in each LinShare's version
(http://download.linshare.org/versions/{VERSION}) must be upgraded together.  
Each LinShare version folder, contains the dependencies required to install the version properly. </br>
- You can find the required versions of LinShare's dependencies [here](../installation/requirements.md)


## Overview

* [Note about LinShare versions](#lversions)
* [Required artifacts](#artifacts)
* [Backups](#backup)
* [Upgrade dependencies](#upgrade-dependencies)
* [Upgrade LinShare core](#core)
* [Upgrade LinShare ui-admin](#ui-admin)
* [Upgrade LinShare ui-user](#ui-user)
* [Upgrade LinShare-ui-upload-request](#ui-upload-request)
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

<a name="artifacts">

## Required artifacts

</a>


In this new version of LinShare a new admin interface is introduced, so we will need two ui-admin components (old component and new one), as it will be explained later.
Our goal for the future is to implement all features in the old interface into the new one.

For this migration, download the following files from this address: http://download.linshare.org/versions/6.0.0 :

  * __linshare-core-6.0.0.war__

  * __linshare-ui-admin-6.0.0.tar.bz2__

  * __linshare-ui-admin-4.2.7-legacy1.tar.bz2__

  * __linshare-ui-user-6.0.0.tar.bz2__

  * __linshare-ui-upload-request-6.0.0.tar.bz2__

> Note :</br>
 - In this upgrade guide we suppose that all components are downloaded on `/root/downloads` directory</br>

 <a name="backup">

 ## Backups :

 </a>

 To avoid any side effect of these critical operations, it is better to store a backup of your databases `PostgreSQL` and `MongoDB`.

 > Note :</br>
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

<a name="upgrade-dependencies">

## Upgrade dependencies

</a>

* **PostgreSQL 13**
We switched to PostgreSQL 13 from PostgreSQL 11. [Upgrade Guide](https://www.postgresql.org/docs/13/upgrading.html)

* **MongoDB**
We switched from Mongo 4.2 to 5.0 version. [Upgrade Guide](https://www.mongodb.com/docs/manual/release-notes/5.0-upgrade-standalone/)


 <a name="core">

 ## Upgrade LinShare-core

 </a>

 First you need to stop Apache and Tomcat services:

 ```bash
 $ systemctl stop apache2
 ```
 ```bash
 $ systemctl stop tomcat9.service
 ```  

 Once your Tomcat service is stopped, you should extract the content of `linshare-core-6.0.0-sql.tar.bz2` by using this command:

 ```bash
 $ tar xjvf  /root/downloads/linshare-core-6.0.0-sql.tar.bz2
 ```
 Then you will find the required file for the migration, named `linshare-core-6.0.0-sql/postgresql/Migration_5.1.0_to_6.0.0.sql`

 In order to upgrade LinShare from 5.0 to 5.1 you need to run the migration script as follow:

 ```bash
 $ psql -h `host` -d linshare -U linshare -f Migration_5.0.0_to_5.1.0.sql
 ```

The next step, you should replace the `linShare.war` with `LinShare-core-6.0.0.war`:

 ```bash
 $ rm /var/lib/tomcat9/webapps/linshare.war
 $ rm -fr /var/lib/tomcat9/webapps/linshare
 $ cp  /root/downloads/linshare-core-6.0.0.war /var/lib/tomcat9/webapps/linshare.war
 ```

If you have defined a custom Log4j configuration, you should migrate it as we upgrade to Log4J version 2.x.  
You can follow the [migration guide](../administration/how-to-migrate-log4j-configuration.md) for this purpose.

 ```bash
 $ systemctl start tomcat9.service
 ```

 <a name="ui-admin">

## Upgrade UI applications
In this versions we've changed the format for the URLs of the SPA applications to remove '#' symbol from URLs due to 
some of the OIDC providers don't support it in the callback urls. So you will need to change your Apache configuration 
and add a rewrite rule to serve index.html for every path except static resources.

### LinShare-ui-admin Apache configuration
```apache
<Directory /usr/local/apache2/htdocs/linshare-ui-admin/new>
      RewriteEngine on
      RewriteCond %{REQUEST_FILENAME} -f [OR]
      RewriteCond %{REQUEST_FILENAME} -d
      RewriteRule ^ - [L]
      RewriteRule ^ index.html [L]
    </Directory>
```

### LinShare-ui-user Apache configuration
```apache
<Directory /usr/local/apache2/htdocs/linshare-ui-user>
    RewriteEngine on
    RewriteBase /
    RewriteCond %{REQUEST_FILENAME} !-f [OR]
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^ - [L]
    RewriteRule ^ index.html [L]
</Directory>
```

 ## Upgrade LinShare-ui-admin

 </a>


 As mentioned before for application __LinShare UI Admin__ we will need two components, you can follow the steps bellow to deploy them in the apache2 repository :

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

 ## Upgrade LinShare-ui-user
 </a>

 Deploy the archive of the application __LinShare UI User__ in the Apache2 repository :

 ```
 $ cd /var/www/
 $ rm -rf linshare-ui-user
 $ tar xjvf  /root/downloads/linshare-ui-user-6.0.0.tar.bz2
 $ chown -R www-data: linshare-ui-user
 ```

 <a name="ui-upload-request">

 ## Upgrade LinShare-ui-upload-request
 </a>

 Deploy the archive of the application __LinShare UI Upload Request__ in the Apache2 repository :

 ```
 $ cd /var/www/
 $ rm -rf linShare-ui-upload-request
 $ tar xjvf  /root/downloads/linshare-ui-upload-request-6.0.0.tar.bz2
 $ chown -R www-data: linshare-ui-upload-request
 ```

 Now you can start your Apache service again.

 ```
 $ systemctl start apache2
 ```

 <a name="tasks">

 ## Upgrade task execution in the administration interface
 </a>

 For this new version, you need to run further upgrade tasks in the
 admin interface : http://`YourServerName`/#/upgradetasks/list.

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
