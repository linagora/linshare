## Summary

### LINSHARE INSTALLATION

#### 1. [LinShare minimum installation](#installmin)
   * [Download of LinShare](#dlLinshare)
   * [Deployment of the archive and the configuration files](#instalFile)
   * [OpenJDK Java JRE installation](#instalOpenJdk)
   * [Databases (PostgreSQL & mongoDB installation)](#bdd)
   * [Servlet container (Tomcat 8 installation)](#tomcat)
   * [Web server (Apache 2 installation)](#apache)
     1. [Ui-user vhost configuration](#ui-user)
     2. [Ui-admin vhost configuration](#ui-admin)
   * [LinShare configuration and launching](#linconf)
   * [First access](#firstAccess)


### LINSHARE INSTALLATION

> Note:<br/>
This installation guide is for the 2.x LinShare versions on Debian 8 Jessie (we do not support other Debian's distribution).
Installation of previous version of LinShare are available at
github branches in this case : [LinShare 1.12.x](../../../../maintenance-1.12.x/documentation/EN/installation/linshare-install.md)

<a name="installmin">

### __Linshare__ minimum Installation

</a>

<a name="dlLinshare">

### Download of __LinShare__

</a>

__LinShare__ is open, free and available at this address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Note:<br/>
You may find all the LinShare's versions at the following [link](http://download.linshare.org/versions/).
Pick the LinShare version that best suits your environement.
Each LinShare version contains all the necessary components related to specific version of LinShare.
Do not install or use a different component version other than the ones you'll find within the folder itself.
Otherwise you run the risk of encountering dependencies issues and LinShare may not work properly.


For this installation, download the following files :

  * __linshare-core-{VERSION}.war__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

  * __linshare-ui-user-{VERSION}.tar.bz2__

Version may differ for each component.

<a name="instalFile">

### Deployment of the archive and the configuration files

</a>

To manipulate the archives, it is necessary to use Unzip and Bzip tools :

`[root@localhost ~]$ aptitude install unzip bzip2`

Create the configuration repository of __LinShare__ and past the configuration files :

```
[root@localhost ~]$ mv linshare-core-{VERSION}.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

### Executive environment JAVA (JVM)

__LinShare__ works with OpenJDK and Sun/Oracle Java 8. This section is on OpenJDK Java 8.

<a name="instalOpenJdk">

#### Installation of OpenDK

</a>

Install Java Runtime Environment (JRE) of OpenJDK from the repositories :

> Note:<br/>
   * If you are on a debian jessie, you might need to add jessie backport to your source.list file.<br/>
   To do so follow the following instructions :
   `[root@localhost ~]$ vim /etc/apt/sources.list` and add this line : `deb http://ftp.debian.org/debian jessie-backports main`. Then do : `aptitude  update; aptitude -t jessie-backports install your_package`.

```
[root@localhost ~]$ aptitude install openjdk-8-jre
[root@localhost ~]$ update-alternatives --config java
```

> Note:<br/>
    * You can ignore the possible errors from the Java plugin.

<a name="bdd">

### Databases

</a>

LinShare needs the use of a database (PostgreSQL) for its files and its configuration.

Mysql is not supported anymore in LinShare v2.
 
This section present an installation with PostgreSQL.

Install PostgreSQL from the repositories :

`[root@localhost ~]$ aptitude install postgresql`

Start the PostgreSQL service :

`[root@localhost ~]$ service postgresql start`

#### Secure accesses creation

Modify the PostgreSQL's access gestion file :

```
[root@localhost ~]$ vim /etc/postgresql/<VERSION>/main/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Note:<br/>
    * Those lines are usually at the end of the file.<br/>
    * For security reasons, the postgreSQL service only listen in local.<br/>
    * Restart/reload the postgreSQL server after your modifications for they can be take in consideration:<br/>
    `[root@localhost ~]$ service postgresql restart/reload`

You should also add those rules among the first. Indeed, PostgreSQL uses the first valid rule which match the authentication request.

Create the user "linshare" (password {PASSWORD}) :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

CREATE ROLE linshare
  ENCRYPTED PASSWORD '{PASSWORD}'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

\q
```

Commands: to quit, tape "\q" ; to have help on PSQL, tape "\?".

Create and import the schema of the database :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

CREATE DATABASE linshare
  WITH OWNER = linshare
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;


GRANT ALL ON DATABASE linshare TO linshare;

\q
```

__Caution : if your database is installed in french, replace all the occurrences of "en_US" by "fr_FR".__

> Note:<br/>
     * If you need, there is a script named createDatabase.sql under src/main/resources/sql/postgresql/ who gives 
     you the command to enter for creating your databases.

Import the SQL files "createSchema.sql" and "import-postgresql.sql" :

```
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/createSchema.sql | psql -U linshare -W -d linshare
Password for user linshare: {PASSWORD}
[root@localhost ~]$ unzip -c linshare.war WEB-INF/classes/sql/postgresql/import-postgresql.sql | psql -U linshare -W -d linshare
Password for user linshare: {PASSWORD}
```

Edit LinShare's configuration file :

```
[root@localhost ~]$ vi /etc/linshare/linshare.properties
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password={PASSWORD}
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```

For the LinShare V2 installation, you have to install a specific version of mongoDB which is 3.2:

First import the public key used by the package management system:

```
[root@localhost ~]$ apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
```
Create a list file:

```
[root@localhost ~]$ echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
```

After that you have to reload the local package database:

```
[root@localhost ~]$ apt-get update
```
And install the latest stable version of MongoDB:

```
[root@localhost ~]$ apt-get install -y mongodb-org
```

Before lunching the MongoDB make sure that que file /etc/mongod.conf has the bind ip address: 127.0.0.1

Issue the following command to start mongod:

```
[root@localhost ~]$ service mongod start
```
<a name="tomcat">

#### Servlet container

</a>

LinShare is an Java application compiled and embedded under the WAR (**W**eb **A**pplication a**R**chive) format, so it needs a __servlet container Java__ (Tomcat or Jetty) to run.

This section presents the installation of the Tomcat server.

#### Tomcat 8 installation

Install tomcat from the repositories :

`[root@localhost ~]$ aptitude install tomcat8`

#### Tomcat 8 configuration

To specify the location of the LinShare __configuration__ (__linshare.properties__ file) and also the default start 
options, get the commented options in the first lines of the __linshare.properties__ file and coy-paste them in the tomcat file (/etc/default/tomcat8).

All starting needful options by default to Linshare are indicated in the header of the following configuration files :

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

#### Deployment of the archive

Deploy the archive of Linshare application in the tomcat server :

```
[root@localhost ~]$ cp linshare.war /var/lib/tomcat8/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat8:tomcat8 /var/lib/linshare
```

<a name="apache">

#### Web server

</a>

The administration interface of __LinShare__ is an application based on web languages HTML/CSS and JavaScript. 
It just needs a simple web server like Apache or nginx.

This section presents the installation of Apache HTTP server.

#### Apache 2 installation

Install Apache 2 from the repositories :

```
[root@localhost ~]$ aptitude install apache2
```

##### Vhost configuration

<a name="ui-user">

#### ui-user

</a>

To deploy the LinShare application, it is necessary to activate the __mod_proxy__ module on Apache 2. Plus, you 
must add the configuration below to the default file provided by debian :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-user.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-user.conf
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-user.conf
```

```
<VirtualHost *:80>
...
ServerName linshare-user.local
DocumentRoot /var/www/linshare-ui-user
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-user-error.log
CustomLog /var/log/apache2/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * After any modification of a vhost, you nust reload the Apache 2 server :<br/>
   `[root@localhost ~]$ service apache2 reload` <br/>
   * In the recent versions of Apache, the default file can be named as default.conf.<br/>
   * If you create a document root, you can create a custom subrepository, in which you can add your logo :<br/>
   `[root@localhost ~]$ mkdir -p linshare/custom`

<a name="ui-admin">

#### ui-admin

</a>

Deploy the archive of the application __LinShare UI Admin__ in the Apache 2 repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-admin-{VERSION} /var/www/linshare-ui-admin
```

To deploy the __LinShare__ administration interface, it is necessary to activate the __mod_proxy__ module on Apache 2. Plus, you must add the configuration below to the default file provided by debian :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-admin.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-admin.conf
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2enmod proxy proxy_http headers
[root@localhost ~]$ vim linshare-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * After any modification of a vhost, you nust reload the Apache 2 server: <br/>
   `[root@localhost ~]$ service apache2 reload` <br/>
   * In the recent versions of Apache, the default file can be named as default.conf <br/>

<a name="linconf">

### LinShare configuration and launching

</a>

Configure the __storage location of the files__ :

```
[root@localhost ~]$ mkdir -p /var/lib/linshare
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

Configure the __access of a SMTP server__, for the notification sending :

```
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

On LinShare, you have two possible authentication mode, the first is the nominal mode, and the second is the sso mode. To start LinShare you must at least enable one of those two following modes :

* default : default authentication process.
* sso : Enable headers injection for SSO. This profile includes default profile capabilities

The default profile is jcloud with filesystem for tests purpose.

You can override this parameter using -Dspring.profiles.active=xxx
Or you can use environment variable : SPRING_PROFILES_ACTIVE
You must enable at least one authentication profile among authentication profiles  and one profile among file data store profiles described below.

Available file data store profiles :

* jcloud : Using jcloud as file data store : Amazon S3, Swift, Ceph, filesystem (test only).

* gridfs : Using gridfs (mongodb) as file data store.

* jackrabbit2 : Using jackrabbit as file data store.

* jackrabbit-to-jcloud : Using Jcloud as new file data store, jackrabbit as fallback file data store.

* jackrabbit-to-gridfs : Using GridFS as new file data store, jackrabbit as fallback file data store.

Recommended profile for production is jcloud with Swift.

The default profile is jcloud with filesystem for tests purpose.

> Note:<br/>
    - We only use JackRabbit for the transition, it is deprecated.

To __start LinShare__, start the tomcat service :

`[root@localhost ~]$ service tomcat8 restart`

To verify that __LinShare__ works, consult the __logs__ file :

`[root@localhost ~]$ tail -f /var/log/tomcat8/catalina.out`

If the service start correctly, you should have those following messages:

```
[...]
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Then restart the Apache 2 service :

`[root@localhost ~]$ service apache2 restart`

> Note:<br/>
   You have some vhost's examples in the following repository : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">

### First access

</a>

The __LinShare service__ is now reachable at the following adresses :

For the user interface :

  * http://linshare-user.local/linshare

> Note:<br/>
   This url must also be inquired in the parameters of your domain. To do so go to the __domain__ functionality and
  enter it in the __Notifcation url__ parameters fiels

For the administration interface :

  *  http://linshare-admin.local/

#### LinShare setting

Connect to LinShare as a Linshare _system administrator_ :

  * Login : root@localhost.localdomain

  * Password : __adminlinshare__

Then, to interconnect __Linshare__ with your LDAP user directory, create a new domain from the section "DOMAINS". For further informations, please refer to the __Configuration and administration manual__ of __LinShare__ [__LINSHARE:CONF__].


