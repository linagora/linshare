##Summary

###LINSHARE UPGRADE

#### 1. [LinShare Core upgrade version](#upgradecore)
   * [Download of LinShare](#dlLinshare)
   * [Deployment of the archive](#deploy)
   * [Database upgrade](#bdd)
   * [Restart of your services](#restart)

#### 2. [LinShare Ui-admin upgrade version](#upgradeadmin)
   * [Download of LinShare Admin](#dlLinshareadmin)
   * [Deployment of the archive](#deployadmin)

#### 3. [LinShare UI-User upgrade version](#upgradeuser)
   * [Download of LinShare User](#dlLinshareuser)
   * [Deployment of the archive](#deployuser)


###LINSHARE UPGRADE

> Note :

 - In this document, we explain how to upgrade your LinShare version.
 - You can find the required versions of LinShare's dependencies [here](../installation/requirements.md)
 - The core and the admin must be both upgraded at the same time. Indeed for each core version, there is an Admin version (CF ...)
 
<a name="upgradecore">
###__Linshare__ Upgrade
</a>

<a name="dlLinshare">
###Download of __LinShare__
</a>

__LinShare__ is avaible at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

You can download the latest release of the core version you want to upgrade to.

  * __linshare-core-{VERSION}.war__

<a name="deploy">
###Deployment of the archive
</a>

To deploy the archive you downloaded and upgrade your __LinShare core__ version, you must rename it and copy it in your tomcat webapps repository :

```
[root@localhost ~]$ service tomcat7 stop
[root@localhost ~]$ cp linshare-core-{VERSION}.war /var/lib/tomcat7/webapps/linshare.war
```

<a name="bdd">
###Database Upgrade
</a>

> Note :

  - This is an postgres upgrade exemple. It is the same for mysql.

If you are doing an upgrade to a minor version (i.e from 1.X to 1.Y), you will need to upgrade your database.

You have then to update your database as the following :

```
[root@localhost ~]$ cd linshare.war /var/lib/tomcat7/webapps/
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/Migration_<your-actual-version>_to_<the-next-version>.sql | psql -U linshare -W -d linshare
```

> Note :

  - If you are upgrading for example from the 1.6.0 to the 1.9.0, you must run the following scripts :
    * Migration_1.6.0_to_1.7.0.sql
    * Migration_1.7.0_to_1.8.0.sql
    * Migration_1.8.0_to_1.9.0.sql

> Note :
  - you must read the following file which contains some particularities about each migration : https://github.com/linagora/linshare-core/blob/master/UPGRADE.md

<a name="restart">
###Restart of your service
</a>

You can now restart your tomcat service :

`[root@localhost ~]$ service tomcat7 start`

<a name="upgradeadmin">
###LinShare ui-admin upgrade version
</a>

To upgrade your LinShare admin version you have to download it at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

<a name="deployadmin">
###Deployment of the archive
</a>

Deploy the archive of the application __LinShare UI Admin__ in the Apache 2 repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-admin /var/www/linshare-ui-admin-{VERSION}
```
Change the DocumentRoot in your vhost file :

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-admin.conf

<VirtualHost *:80>
...
DocumentRoot /var/www/linshare-ui-admin-{VERSION}
...
</Virtualhost>
```
Now reload your apache2 server :

`[root@localhost ~]$ sudo service apache2 reload`

Your LinShare core and admin are now both upgraded and available at them addresses.

<a name="dlLinshareuser">
###Download of LinShare Ui User
</a>

To upgrade your LinShare Ui-User version you have to download it at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

<a name="deployuser">
###Deployment of the archive
</a>

Deploy the archive of the application __LinShare Ui-User__ in the Apache 2 repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-upload-request /var/www/linshare-ui-user-{VERSION}
```
Change the DocumentRoot in your vhost file :

```
[root@localhost ~]$ vim /etc/apache2/sites-available/linshare-user.conf

<VirtualHost *:80>
...
DocumentRoot /var/www/linshare-ui-user-{VERSION}
...
</Virtualhost>
```

Now reload your apache2 server :

`[root@localhost ~]$ sudo service apache2 reload`

Your LinShare Ui-User is now upgraded and available at its address.
