# LINSHARE UPGRADE

> Note :</br>
 - We explain in this file how to upgrade your LinShare instance from 2.3 to 4.0. </br>
 - Please note that all the components found in each version folder, [here](http://download.linshare.org/versions),
 must be upgraded together.
 </br>
Each LinShare version folder contains the dependencies required to install the version properly. </br>

# Prerequisites

## Operating System:

For LinShare 4.0 the recommended OS is **Debian 10 (Buster)**.
The application of this process consists of installing LinShare on a new machine and you will be able to restore databases and the storage space on the new machine
to achieve the migration as we are going to explain in the next steps.

NB: Make sure that your OS is up to date and ready to satisfy LinShare requirements
like Java 11, Tomcat9 and MongoDB 4.2.

## Application's server:

In LinShare 4.0 the used Java version is Java11, to insure that LinShare runs smoothly, the recommended Tomcat version is Tomcat9.

## DataBases:

In LinShare 4.0 both dataBases are upgraded:

* In **Debian 10** the default PostgreSQL's version is 11, it can be used for LinShare (Recommended PostgresSql versions 9, 10 and 11)
* MongoDB from 3.6 to 4.2  


## Overview

 * [Install the new version of LinShare](#lsinstall)
 * [Maintenance of LinShare v2.3 server](#maintenance)
 * [Data backup](#backup)
 * [Data restore on the new machine](#restore)
 * [Database upgrade](#dbupgrade)
 * [Server startup after data migration mode](#startup)
 * [Upgrade tasks](#ugtasks)
 * [Back to nominal mode](#nominal)

# Procedure

## Prerequisites

This procedure presumes that you are using: Java11, Tomcat9, PostgreSQL11, MongoDB 4.2 and apache2 as we can see [here](./requirements.md) in **Debian 10 (Buster)**.

<a name="lsinstall">

## Install the new version of LinShare

</a>

* Download LinShare resources from [here](http://download.linshare.org/versions/4.0.0)

Please download all the component already in the repository of the version
4.0.0 of LinShare.
 * linshare-ui-user.tar.bz2 : Includes the new interface user
 * linshare-ui-admin.tar.bz2 : Includes the admin interface
 * linshare-core.war : Include the LinShare "core" (API REST only)
 * linshare-core-sql.tar.bz2 : Includes the SQL migration scripts.

* Follow the standard installation procedure

On your new machine, install LinShare by following the official [documentation](https://github.com/linagora/linshare/blob/master/documentation/EN/installation/linshare-install-debian.md#linshare-installation-on-debian)

Once LinShare is properly installed and working you can move to the next step.

<a name="maintenance">

## Maintenance mode configuration

</a>

In the archive linshare-ui-user.tar.bz2 you will find an html page named
'error-pages/maintenance.html'. This page is designed to warn users about the maintenance status of the current server.

You have to apply these operations on both LinShare machines v2.3 and v4.0.

* Create the directory /var/www/linshare-maintenance
* Copy the content of the folder named error-pages into the folder /var/www/linshare-maintenance/
* Then add your new maintenance vhost following the server:

 *LinShare v2.3*

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-maintenance.conf

<VirtualHost *:80>
    ServerName linshare-user.local
    DocumentRoot /var/www/linshare-maintenance
    DirectoryIndex maintenance.html
    Header set Cache-Control "max-age=0,no-cache,no-store"
    RedirectMatch 302 ^/linshare.+ /
    RedirectMatch 302 ^/linshare$ /
</Virtualhost>
```

 *LinShare v4.0*

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-maintenance.conf

<VirtualHost *:80>
    ServerName linshare-user.local
    DocumentRoot /var/www/linshare-maintenance
    DirectoryIndex maintenance.html
    Header set Cache-Control "max-age=0,no-cache,no-store"
    ErrorDocument 404 /maintenance.404.json
</Virtualhost>
```

To activate the maintenance mode of LinShare you need to disable the user vhost and activate the maintenance vhost on LinShare V2.3.

```bash
$ a2enmod headers
$ a2ensite linshare-maintenance
$ a2ensite linshare-user.conf
$ systemctl reload apache2
```

The maintenance page should appear instead of the former interface.

Be careful, verify that the button 'REFRESH THE PAGE' redirect to the maintenance page (itself).

You can then begin the upgrade process.

<a name="backup">

## Data backup

</a>

* Stop the tomcat service

```bash
$ systemctl stop tomcat8
```

* Postgres Linshare dump :

```bash
$ pg_dump -h host -p port -U linshare -W  -f dump-linshare.sql
```

* MongoDb Linshare dump

```bash
$ mongodump --host `host` --port `port`
```

* Backup the file system

The data is stored in `/var/lib/linshare`,
a simple disk snapshot would be more than enough to back-up the data.

<a name="restore">

## Data restore on the new machine

</a>

Once the backup is done, transfer the SQL dumps and the file space  
on the new machine to `/var/lib/linshare` (using rsync for example).

Then you will have to set Tomcat as the data owner of `/var/lib/linshare`: `chown -R tomcat9:tomcat9 /var/lib/linshare`

If it is a new machine, you have to add sufficient storage space
in order to copy the former data. If you are using the new filesystem store, you must have
at least the same amount of free space than the old used storage.


You must delete `linshare` database from the new machine in order to load the dump

```bash
$ systemctl stop tomcat9
$ su - postgres
$ psql
> drop database linshare;
> \i dump-linshare.sql
> \q
```

Once this step is achieved, you can move to the next step.

<a name="dbupgrade">

# Database upgrade

</a>

You should extract the content of `linshare-core-4.0.0-sql.tar.bz2` by using this command:

```bash
$ tar xjvf  /root/downloads/linshare-core-4.0.0-sql.tar.bz2
```

Then you will find the necessary file for the migration, named `linshare-core-4.0.0-sql/postgresql/Migration_2.3.0_to_4.0.0.sql`

In order to upgrade LinShare from 2.3 to 4.0 you need to run the script :

```bash
$ psql -h localhost -d linshare -U linshare -f Migration_2.3.0_to_4.0.0.sql
```

You can view the database schema version through the following query `select * from version`.

<a name="startup">

# Server startup after data migration

</a>

Once the former database is loaded and upgraded in version 4.0, make sure that the file transfer `/var/lib/linshare` is complete.

Don't forget to do a `chown -R tomcat9:tomcat9 /var/lib/linshare `

Finally restart your Tomcat server

```
$ systemctl start tomcat9
```

Follow the logs to check if everything is alright: `tail -f /var/log/tomcat9/catalina.out`.

Once the server has restarted, you should be able to log in to the admin interface in order to execute the last migration tasks before restablishing the service.

<a name="ugtasks">

# Upgrade task execution in the administration interface

</a>

For this new version, you need to run further migration tasks in the
admin interface : http://linshare-admin.local/#/upgradetasks/list

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
The required tasks can take some time depending on amout of data.

<a name="nominal">

## Back to nominal mode

</a>

In order to back to the nominal mode you need to disable the maintenance mode and re-activate the user interface using:

```
$ a2ensite linshare-user.conf
$ a2dissite linshare-maintenance
$ systemctl reload apache2
```
