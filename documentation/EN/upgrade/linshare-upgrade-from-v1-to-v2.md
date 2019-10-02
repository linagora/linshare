# LINSHARE UPGRADE

> Note :</br>
 - We explain in this file how to upgrade your linShare's version. </br>
 - Please note that all the components found in each LinShare's version
(http://download.linshare.org/version/ <VERSION>) must be upgraded together. </br>
Each LinShare version folder, contains the dependencies required to install the version properly. </br>


# Prerequisites

## Browsers

The user interface has been entirely rewritten with new technologies like AngularJS.
These new technologies require efficient and recent browsers
like Chrome or Firefox. The application can work on IE11 and Edge
however they will take more time to respond and can damage the user experience.

## Restriction

The LinShare version 2.0 is not iso-functional with the version 1.
Upload proposition and upload request features
have not been added yet to this new version.

These features will be added in LinShare version 2.1.

The MySQL database is no longer being supported, you need to upgrade to
PostgreSQL. Cf https://wiki.postgresql.org/wiki/Converting_from_other_Databases_to_PostgreSQL#MySQL.
The best option is to upgrade your previous LinShare version to v1.12,
check if it work properly, then convert mysql database to PostgreSQL and 
check if it is properly working with postgres. Finally you can upgrade from 
postgres 1.12 to 2.0.
By following those step youre upgrade will succeed.

All parameters and emails templates will be reset during the SQL upgrade. 
Therefore, you must reconfigure your settings before launching migration tasks, 
such as share expiration, base URL notification or default email address used as email sender.

## Architecture

The LinShare version 2.0 introduces two major changes, first by relying on the use of the
NoSQL MongoDB database, and secondly by changing the component in charge of the filestorage.

In version 1 files where stored in the file system using
Apache JackRabbit. In version 2, Apache JCloud is now in charge of
storing all files, for light volumetry we could use filesystem storage, however, for a high volumetry 
you could use an object storage (support of S3 API).
Therefore, you must choose a new backend of files storage.

In addition to MongoDB new component, LinShare needs 
Java 8 too. These two components have a significant impact on the used OS.

We recommend at least Centos 7 or higher and Debian 8 or higher.


# Proceeding

Two approaches can be followed up, the first one involves upgrading the OS then upgrading LinShare,
the other one consists of installing LinShare on a new machine.
You will be able to restore the database and the storage space on the new machine
to achieve the migration.

However, the first approach is not available for Centos 6. We are now going to explain
the second one based on our favourite OS Debian.


NB: Make sure that your OS is up to date and ready to satisfy LinShare requirements
like Java 8, Tomcat7 or higher and MongoDB 3.2.


## Overview

 * Install the new version of LinShare
 * Maintenance of LinShare v1 server.
 * Data backup.
 * Data recovery on the new machine
 * Database upgrade
 * Server startup in data transfert mode.
 * Upgrade task execution in the administration 
   interface - part 1
 * Service reopening in reduced functionality mode.
 * Upgrade task execution in the administration
   interface - part 2
 * Service full reopening.


# Procedure

## Prerequisites

This procedure presumes that you are using the default component (Apache2,
Tomcat et PostgreSQL) in Debian 8 OS (Jessie).



## Install the new version of LinShare

* Download LinShare resources http://download.linshare.org/versions/2.0.1/

Please download all the component already in the repository of the version
2.0.1 or higher of LinShare.
 * linshare-ui-user.tar.bz2 : Includes the new interface user
 * linshare-ui-admin.tar.bz2 : Includes the admin interface
 * linshare-core.war : Include the LinShare "core" (API REST only)
 * linshare-core-sql.tar.bz2 : Includes the SQL migration scripts.

* Follow the standard installation procedure

On your new machine, install LinShare by following the official documentation: https://github.com/linagora/linshare/blob/master/documentation/EN/installation/linshare-install.md

Once LinShare is properly installed and working you can jump to the next step.


## Maintenance mode configuration

In the archive linshare-ui-user.tar.bz2 you will find an html page named
'error-pages/maintenance.html'. This page is designed to warn users about the maintenance status of the current server.

You have to apply these operations on both LinShare machines v1 and v2.

* Create the directory /var/www/linshare-maintenance
* Copy the content of the folder named error-pages into the folder /var/www/linshare-maintenance/
* Then add your new maintenance vhost following the server:

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


## Activation of maintenance mode in LinShare V1

Disable the user vhost and activate the maintenance vhost on LinShare v1.

```bash
$ a2enmod headers
$ a2ensite linshare-maintenance
$ a2dissite linshare-user
$ systemctl reload apache2
```

The maintenance page should appear instead of the former interface.

Be careful, verify that the button 'REFRESH THE PAGE' redirect to the maintenance page (itself).

You can then begin the upgrade process.


## Data backup

* Stop the tomcat service

```bash
$ systemctl stop tomcat7
```

* Backup the database: `linshare`

```bash
$ pg_dump -h localhost -U linshare linshare -f dump-linshare.sql
```

* Backup the database: linshare_data

```bash
$ pg_dump -h localhost -U linshare linshare_data -f dump-linshare-data.sql
```

* Backup the file system

The data is stored in `/var/lib/linshare`,
a simple disk snapshot would be more than enough to back-up the data.

## Data recovery on the new machine

Once the backup is done, transfer the SQL dumps and the file space  
on the new machine to `/var/lib/linshare` (using rsync for example).

Then you will have to set Tomcat as the data owner of `/var/lib/linshare`: `chown -R tomcat8:tomcat8 /var/lib/linshare`

If it is a new machine, you have to add sufficient storage space
in order to copy the former data. If If you are using the new filesystem store, you must have 
at least the same amount of free space than the old used storage.


You must delete `linshare` database from the new machine in order to load the dump

```bash
$ systemctl stop tomcat8
$ su - postgres
$ psql
> drop database linshare;
> \i dump-linshare.sql
> \i dump-linshare-data.sql
> \q
```

Once this step is achieved, jump to next step.


# Database migration

You can get the migration script for the version 2.0 from the LinShare core archive `linshare-core-sql.tar.bz2`

```bash
$ psql -h localhost -U linshare  linshare
> \i Migration_1.12.0_to_2.0.0.sql
```

You can look for the database version through the query `select * from version`.


# Server startup in data migration mode

Once the former database is loaded and upgraded in version 2, make sure that the file transfer `/var/lib/linshare` is complete.
After that, You will switch to a transition mode where both file storages are up and running at the same time.

Don't forget to do a `chown -R tomcat8:tomcat8 /var/lib/linshare `

In order to do that, edit the file linshare.properties:

```
#### JackRabbit storage options ####
# JackRabbit is deprecated but is still in LinShare for upgrade purpose from v1 to v2.
# you have to uncomment and set the directory parameter according to your previous configuration file.
# linshare.files.directory=${LINSHARE_HOME}/var/lib/linshare/repository
# linshare.db.persistence_manager=org.apache.jackrabbit.core.persistence.pool.PostgreSQLPersistenceManager
```

Uncomment the following line and reveal the data path from LinShare v1 :

```
linshare.files.directory=/var/lib/linshare/repository
```

Make sure you have the correct configuration of the software storage brick JackRabbit
in the file: /var/lib/linshare/repository/workspaces/default/workspace.xml.
Especially, the database parameters.

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

Finally, you have to change the start-up Tomcat options for LinShare, by
editing the following file `/etc/default/tomcat8`

Replace the value `-Dspring.profiles.active=default,jcloud,mongo`
by `-Dspring.profiles.active=default,jackrabbit-to-jcloud,mongo,batches` and restart Tomcat:

```
$ systemctl start tomcat8
```

Follow the logs to check if everything is alright: `tail -f /var/log/tomcat8/catalina.out`.

Once the server has restarted, you should be able to log in to the admin interface in order to 
execute the last migration tasks before restablishing the service.


# Upgrade task execution in the administration interface - part 1

For this new version, you need to run further migration tasks in the
admin interface : http://linshare-admin.local/#/upgradetasks/list.

All the tasks must be executed by order and succeed in order to complete the upgrade.  

NB: A task can finish with a succesful status but errors can be noticed during the progress.
    It is necessary to check the execution reports found in the console.
    In case of errors, we must read the logs of Tomcat server for more details,
    resolve the problems and launch the task before carrying on.

* As long as the tasks with status 'Mandatory' are not completed, the users can not
use the system.

* As long as the tasks with status 'Required' are not completed,
the system will work under reduced functionality mode. Some features or data cannot be reachable.
these tasks can be executed simultaneously without disrupting the user activity.

Once the mandatory tasks have been executed, you can switch to the next step if you want to 
re-establish quickly the LinShare service.
The required tasks can take some time depending on your volumetry.

Be careful: All features setup and email templates were reset by the SQL migration script. 
Therefore, you must reconfigure your settings before launching migration tasks, 
such as expiration times, URL, and email address used when sending notifications.

# Service reopening in reduced functionality mode

At this point, either you are using a new URL for the new LinShare app or
you are using the former URL.

If you are using the same URL you must update your DNS settings so that
the public name points towards the new machine. Also change the 
linshare-user vhost by adding these directives to redirect URL toward the new ones.


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

If you are deploying LinShare v2 with a new URL, for example http://linshare-user-v2.local, you can use
the following procedure.

* Creating a migration vhost on LinShare v1

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

Edit the migration.html file and replace the default URL with your own new URL ie 
`onclick="goTo('http://new.server.com')`.

Disable the maintenance vhost and activate the migration vhost:

```bash
$ a2enmod headers
$ a2ensite linshare-migration
$ a2dissite linshare-maintenance
$ systemctl reload apache2
```

A new web page will ask your user to click on the new URL.


# Upgrade task execution in the administration interface - part 2

If you decided to restart the service in reduced functionality mode, you must complete the required tasks before
going any further. The fulfilment of the required tasks can takes a lot of time.

Once all these tasks is done, your LinShare app will be operational.


# Migration completion


## step 1 : Back to nominal mode

In order to finish the migration, it is necessary to disable the former file's backend  
and to get rid of any useless data. This step has to be done during a low traffic period,  
since it can be disruptive.

* Maintenance mode

```
$ a2ensite linshare-maintenance
$ a2dissite linshare-ui-user
$ systemctl reload apache2
```

* Interrupting the Tomcat service `$ systemctl stop tomcat8`

* Disabling the former storage space :

You have to edit the following file `/etc/default/tomcat8` and restore the initial value :
`-Dspring.profiles.active=default,jcloud,mongo`

* Restarting the Tomcat service

```
$ systemctl start tomcat8`
```

* Disabling the maintenance mode

```
$ a2ensite linshare-ui-user
$ a2dissite linshare-maintenance
$ systemctl reload apache2
```

## step 2 : Deleting useless data

You can now delete the data without interupting the service.

* Remove the former database :

```bash
$ su - postgres
$ psql
> drop database linshare_data;
> \q
```

* Remove the former storage space, cf configuration key `linshare.files.directory` :

```
* rm -frv /var/lib/linshare/repository
```

