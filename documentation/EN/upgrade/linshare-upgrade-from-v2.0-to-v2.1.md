# LinShare upgrade guide

> Note :</br>
 - We explain in this file how to upgrade your LinShare's version. </br>
 - Please note that all the components found in each LinShare's version
(http://download.linshare.org/version/{VERSION}) must be upgraded together. </br>
Each LinShare version folder, contains the dependencies required to install the version properly. </br>


## Overview

* [Note about LinShare versions](#lversions)
* [Necessary artifacts](#artifacts)
* [Upgrade LinShare core](#core)
* [Upgrade LinShare ui-admin](#ui-admin)
* [Upgrade LinShare ui-user](#ui-user)
* [Deploy thumbnail (optional)](#thumbnail)
* [Upgrade tasks](#tasks)

<a name="lversions">

## LinShare Versions

</a>

LinShare version number are named according to the following pattern
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

For this migration, download the following files from this address: http://download.linshare.org/versions/2.1.0 :

  * __linshare-core-2.1.0.war__

  * __linshare-core-2.1.0-sql.tar.bz2__

  * __linshare-ui-admin-3.1.0.tar.bz2__

  * __linshare-ui-user-2.1.0.tar.bz2__

> Note :</br>
 - Download all components  on `/root/downloads` directory</br>

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
Once your service tomcat is stopped, you should extract the content of `linshare-core-2.1.0-sql.tar.bz2` by using this command:
```bash
$ tar xjvf  /root/downloads/linshare-core-2.1.0-sql.tar.bz2
```
Then you will find the necessary file for the migration, titled `linshare-core-2.1.0-sql/postgresql/Migration_2.0.0_to_2.1.0.sql`

Migration scripts are specific for each database management system.
You have one directory by supported database management system.
All scripts are named according to the following pattern "Migration_X.A.0_to_X.B.0.sql".

In order to upgrade LinShare from 2.0 to 2.1 you ALWAYS need to run the script :
```bash
$ psql -h localhost -d linshare -U linshare -f Migration_2.0.0_to_2.1.0.sql
```
You can view the database version through the following query `select * from version`.

Once the migration file is done, you should replace the linShare.war with LinShare-core-2.1.0.war

```bash
$ rm /var/lib/tomcat8/webapps/linShare.war
$ rm -fr /var/lib/tomcat8/webapps/linshare
$ cp  /root/downloads/linshare-core-2.1.0.war /var/lib/tomcat8/webapps/linshare.war
```
##### Activation of batches
At LinShare version 2.1, the batch profile is enabled by default.
This profile allows LinShare to run background processes. The purpose of these processes is to optimize the LinShare data, such as deleting the files permanently from the hard disk.

This profile allows you to enable or disable all planned tasks like cleaning expired sharing, sending notification ...
If you have overridden the default 2.0 value `-Dspring.profiles.active=default,jcloud,mongo` to enable different profiles, please be careful to update your current configuration with the new profile "batches". The default value for 2.1 is now -`Dspring.profiles.active=default,jcloud,mongo,batches`.

Once you changed it you should restart the tomcat service
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
$ tar xjvf /root/downloads/linshare-ui-admin-2.1.0.tar.bz2
$ chown -R apache: /var/www/linshare-ui-admin
```
<a name="ui-user">

## Upgrade LinShare-ui-user
</a>

Deploy the archive of the application __LinShare UI User__ in the Apache 2 repository :

```
$ cd /var/www/
$ rm linshare-ui-user
$ tar xjvf  /root/downloads/linshare-ui-user-2.1.0.tar.bz2
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
the system will work under reduced functionality mode. Some features or data cannot be reachable.
These tasks can be executed simultaneously without disrupting the user's activity.

Once the mandatory tasks have been executed, you can switch to the next step if you want to
re-establish quickly the LinShare service.
The required tasks can take some time depending on your volumetry.

Be careful: All features setup and email templates were reset by the SQL migration script.
Therefore, you must reconfigure your settings before launching migration tasks,
such as expiration times, URL, and email address used when sending notifications.

If you decided to restart the service in reduced functionality mode, you must complete the required tasks before
going any further. The fulfilment of the required tasks can takes a lot of time.

Once all these tasks are done, your LinShare app will be operational.

<a name="thumbnail">

## Enable new thumbnail engine (optional)
</a>

LinShare has a new preview generation engine for a wide range of files :

 - OpenDocument format (ODT, ODP, ODS, ODG)
 - Microsoft documents format (DOCX, DOC, PPTX, PPT, XLSX, XLS)
 - PDF documents
 - Images files (PNG, JPEG, JPG, GIF)
 - Text files (TXT, XML, LOG, HTML ...)

> Note:<br/>
    *  Before using this engine you should have LibreOffice or OpenOffice installed on your machine, the minimum version of libreOffice is : 4.2.8.

By default thumbnail generation engine is set to FALSE. To enable it, you must edit LinShare's configuration file :

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=false
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
This will allow to generate previews after each file upload.

You also have the option to use this engine remotely. For that you must first activate the remote mode :

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Now go to `http://download.linshare.org/versions/` and download the following files:

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Note <br>
By defaults the server is configured to listen on port 80, you can change it, if necessary.

Copy the configuration file `linshare-thumbnail-server-{VERSION}.yml` into `/etc/linshare/linshare-thumbnail-server.yml` and copy the java archive `linshare-thumbnail-server-{VERSION}.jar` into this directory `/usr/local/sbin/linshare-thumbnail-server.jar`,  you can use the following command for that :

$ cp linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
$ cp linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar


* You can automate starting of thumbnail server, by creating a `systemd` service in the `/etc/systemd/system` directory, with the following name `linshare-thumbnail-server.service`.

Edit the `linshare-thumbnail-server.service` file and copy the code below :

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

Now you should enable the service, it will be automatically started after a reboot :

```bash
$ systemctl enable linshare-thumbnail-server.service
```
To __start Thumbnail__, you need first to restart the Tomcat service :

`[root@localhost ~]$ systemctl restart Tomcat`

Use this command to start the service:

```bash
$ systemctl start linshare-thumbnail-server.service
```
