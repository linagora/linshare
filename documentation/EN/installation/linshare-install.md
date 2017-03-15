##Summary

###LINSHARE INSTALLATION

#### 1. [LinShare minimum installation](#installmin)
   * [Download of LinShare](#dlLinshare)
   * [Deployment of the archive and the configuration files](#instalFile)
   * [OpenJDK Java JRE installation](#instalOpenJdk)
   * [Databases (PostgreSQL installation)](#bdd)
   * [Servlet container (Tomcat 7 installation)](#tomcat)
   * [Web server (Apache 2 installation)](#apache)
     1. [Ui-user vhost configuration](#ui-user)
     2. [Ui-admin vhost configuration](#ui-admin)
   * [LinShare configuration and launching](#linconf)
   * [First access](#firstAccess)

#### 2. [Installation of the Upload Request component (optional)](#instalUR)
   1. [Installation of the Upload Request component 1.X (dedicated Vhost)](#ur10)
      * [Download of the module](#dlmoduleUR)
      * [Deployment of the archive](#deployUR)
      * [Apache configuration](#apacheUR)
      * [First access](#firstAccessUR)
   2. [Installation of the component Upload Request 1.1.X and above (in a directory)](#ur11)
      * [Download of the module](#dlmoduleUR1)
      * [Deployment of the archive](#deployUR1)
      * [Apache configuration](#apacheUR1)
      * [First access](#firstAccessUR1)

#### 3. [Installation of the Upload Proposition component (optional)](#instalUP)
   * [Download of the module](#dlmoduleUP)
   * [Deployment of the archive](#deployUP)
   * [Apache configuration via dedicated vhost](#apacheUP)
   * [First access](#firstAccessUP)
   * [Apache Configuration via directory](#apacheUP1)
   * [First access](#firstAccessUP1)

###LINSHARE INSTALLATION

> Note:<br/>
    In this manual, we choosed the components that we recommend, which are PostgreSQL/Tomcat/Apache/JAVA.
    You can however adapt depending upon the components you may choose.


<a name="installmin">
###__Linshare__ minimum Installation
</a>

<a name="dlLinshare">
###Download of __LinShare__
</a>

__LinShare__ is open, free and available at this address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

For this installation, download the following files :

  * __linshare-core-{VERSION}-without-SSO.war__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

<a name="instalFile">
###Deployment of the archive and the configuration files
</a>
To manipulate the archives, it is necessary to use Unzip and Bzip tools :

`[root@localhost ~]$ aptitude install unzip bzip2`

Create the configuration repository of __LinShare__ and past the configuration files :

```
[root@localhost ~]$ mv linshare-core-{VERSION}-without-SSO.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

###Executive environment JAVA (JVM)

__LinShare__ works with OpenJDK and Sun/Oracle Java 7. This section is on OpenJDK Java 7.

<a name="instalOpenJdk">
####Installation of OpenDK
</a>
Install Java Runtime Environment (JRE) of OpenJDK from the repositories :

```
[root@localhost ~]$ aptitude install openjdk-7-jre
[root@localhost ~]$ update-alternatives --config java
```

> Note :<br/>
    * You can ignore the possible errors from the Java plugin.

<a name="bdd">
###Databases
</a>

LinShare needs the use of a database (PostgreSQL) for its files and its configuration. 
This section present an installation with PostgreSQL.

Install PostgreSQL from the repositories :

`[root@localhost ~]$ aptitude install postgresql`

Start the PostgreSQL service :

`[root@localhost ~]$ service postgresql start`

####Secure accesses creation

Modify the PostgreSQL's access gestion file :

```
[root@localhost ~]$ vim /etc/postgresql/<VERSION>/main/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   linshare,linshare_data    linshare                           md5
 host    linshare,linshare_data    linshare      127.0.0.1/32         md5
 host    linshare,linshare_data    linshare      ::1/128              md5
```

> Note :<br/>
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

Create and import the schema of the databases :

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

CREATE DATABASE linshare_data
  WITH OWNER = linshare
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;

GRANT ALL ON DATABASE linshare TO linshare;
GRANT ALL ON DATABASE linshare_data TO linshare;

\q
```

__Caution : if your database is installed in french, replace all the occurrences of "en_US" by "fr_FR".__

> Note :<br/>
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
linshare.db.persistence_manager=org.apache.jackrabbit.core.persistence.bundle.PostgreSQLPersistenceManager
```
<a name="tomcat">
####Servlet container
</a>
LinShare is an Java application compiled and embedded under the WAR (#W#eb #A#pplication a#R#chive) format, so it needs a __servlet container Java__ (Tomcat or Jetty) to run.

The application file **linshare.war** contains the heart (core) of the application __LinShare__ as well as the user interface. The administration interface of the solution is external to the application.

> Note :<br/>
   * The administration interface was externalized from the version 1.6.

This section presents the installation of the Tomcat server.

####Tomcat 7 installation

Install tomcat from the repositories :

`[root@localhost ~]$ aptitude install tomcat7

####Tomcat 7 configuration

To specify the location of the LinShare __configuration__ (_linshare.properties_ file) and also the default start 
options, get the commented options in the first lines of the __linshare.properties__ file and coy-paste them in the tomcat file (/etc/default/tomcat7).

All starting needful options by default to Linshare are indicated in the header of the following configuration files :

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

####Deployment of the archive

Deploy the archive of Linshare application in the tomcat server :

```
[root@localhost ~]$ cp linshare.war /var/lib/tomcat7/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat7:tomcat7 /var/lib/linshare
```
<a name="apache>
####Web server
</a>

The administration interface of __LinShare_ is an application based on web languages HTML/CSS and JavaScript. 
It just needs a simple web server like Apache or nginx.

This section presents the installation of Apache HTTP server.

####Apache 2 installation

Install Apache 2 from the repositories :

`[root@localhost ~]$ aptitude install apache2

#####Vhost configuration
<a name="ui-user">
####ui-user
</a>
To deploy the LinShare application, it is necessary to activate the __mod_proxy__ module on Apache 2. Plus, you 
must add the configuration below to the default file provided by debian :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ mkdir -p linshare
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-user.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-user.conf
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-user.conf
<VirtualHost *:80>
...
ServerName linshare-user.local
#The following is in the case of you create a root document.
DocumentRoot /var/www/linshare
# This option allows you to add a custom repository in the document root, where you can put your personal resources
RedirectMatch ^/(?!custom|linshare) http://linshare-user.local/linshare/
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
</Location>

<Directory /var/www/linshare>
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>

ErrorLog /var/log/apache2/linshare-user-error.log
CustomLog /var/log/apache2/linshare-user-access.log combined
...
</Virtualhost>
```
> Note:<br/>
   * After any modification of a vhost, you nust reload the Apache 2 server :
   `[root@localhost ~]$ service apache2 reload` <br/>
   * In the recent versions of Apache, the default file can be named as default.conf.<br/>
   * If you create a document root, you can create a custom subrepository, in which you can add your logo :<br/>
   `[root@localhost ~]$ mkdir -p linshare/custom`

<a name="ui-admin">
####ui-admin
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
[root@localhost ~]$ a2enmod proxy proxy_http headers
[root@localhost ~]$ vim linshare-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare/webservice/rest/admin
    ProxyPassReverse http://127.0.0.1:8080/linshare/webservice/rest/admin
    ProxyPassReverseCookiePath /linshare /
    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

<Directory /var/www/linshare-ui-admin>
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
...
</Virtualhost>
```
> Note:
   * After any modification of a vhost, you nust reload the Apache 2 server :
   `[root@localhost ~]$ service apache2 reload` <br/>
   * In the recent versions of Apache, the default file can be named as default.conf.<br/>

<a name="linconf">
###LinShare configuration and launching
</a>

Configure the __storage location of the files__ :

```
[root@localhost ~]$ mkdir -p /var/lib/linshare
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
linshare.signature.tmp.dir=/var/lib/linshare/tmp/linSignDocuments
linshare.files.directory=/var/lib/linshare/repository
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
To __start LinShare__, start the tomcat service :

`[root@localhost ~]$ service tomcat7 restart`

To verify that __LinShare__ works, consult the __logs__ file :

`[root@localhost ~]$ tail -f /var/log/tomcat7/catalina.out`

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

Note :
   > You have some vhost's examples in the following repository : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">
###First access
</a>

The __LinShare service__ is now reachable at the following adresses :

For the user interface :

  * __http://linshare-user.local/linshare__

Note :

  > This url must also be inquired in the parameters of your domain. To do so go to the __domain__ functionality and
  enter it in the __Notifcation url__ parameters fiels

For the administration interface :

  * __http://linshare-admin.local/__

####LinShare setting

Connect to LinShare as a Linshare _system administrator_ :

  * Login : __root@localhost.localdomain__

  * Password : __adminlinshare__

Then, to interconnect __Linshare__ with your LDAP user directory, create a new domain from the section "DOMAINS". For further informations, please refer to the __Configuration and administration manual__ of __LinShare__ [__LINSHARE:CONF__].

<a name="instalUR">
##Installation of the Upload Request component (optional)
</a>

<a name="ur10">
###Installation of the component Upload-Request 1.X (dedicated Vhost)
</a>

This module allows to an external account to access a file upload interface, which you can configure in the 
administration interface.

Note :

     - If you activate the "Upload Request" functionnality, you will have to deploy this component.

<a name="dlmoduleUR"> 
####Download of the module
</a>
This module in on free download at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

For this Installation, download the following file according to the version you want :

  * linshare-ui-upload-request-{VERSION}.tar.bz2

<a name="deployUR">
####deployment of the archive
</a>
Deploy the __LinShare__ UI UploadRequest archive in the Apache server repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-uploadrequest-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-upload-request-{VERSION} /var/www/linshare-ui-upload-request
```
<a name="apacheUR">
####Apache Configuration
</a>
To deploy the __LinShare__ upload request interface, it is necessary to activate the __mod_proxy__ module on Apache2. Plus, you must add the configuration bellow to the default apache file :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-upload-request.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-upload-request.conf
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-upload-request.conf
```
#####Version 1.0.X

```
<VirtualHost *:80>
...
ServerName linshare-uploadrequest.local
DocumentRoot /var/www/linshare-ui-upload-request
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare/webservice/rest/uploadrequest
    ProxyPassReverse http://127.0.0.1:8080/linshare/webservice/rest/uploadrequest
    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

<Directory /var/www/linshare-ui-upload-request>
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>
...
</Virtualhost>
```
#####Version 1.1.X

```
<VirtualHost *:80>
...
ServerName linshare-uploadrequest.local
DocumentRoot /var/www/linshare-ui-upload-request
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

<Directory /var/www/linshare-ui-upload-request>
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>
...
</Virtualhost>
```
To access at __LinShare Upload Request__, first start the Core, then restart the Apache2 service :

`[root@localhost ~]$ service apache2 restart`

<a name="firstAccessUR">
###First access
</a>
The __Upload Request service__ is now reachable at the address below :

  * Decicated vhost installation : __http://linshare-upload-request.local/{uuid}__

Note:
   > You need an avaible request form a mail sent by __LinShare__ to use this portal.<br/>
   If you don't have one, you will redirect to a 404 page. The complete url to this portal will be send by mail
   to the recipients of the upload request.

   > You need to inquire the url into your upload request url parameter<br/>
   in your administration interface. To do so, go to your administration interface, choose the __Upload Request__ functionnality,<br/> and inquire the url in the "parameters" fields.

<a name="ur11">
###Installation of the component Upload-Request 1.1.X and above (in a directory)
</a>

<a name="dlmoduleUR1">
####Download of the module
</a>

This module in on free download at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

For this Installation, download the following file according to the version you want :

  * linshare-ui-upload-request-{VERSION}.tar.bz2

<a name="deployUR1">
####deployment of the archive
</a>
Deploy the __LinShare__ UI UploadRequest archive in the Apache server repository :

```
[root@localhost ~]$ cd /var/www/linshare
[root@localhost ~]$ tar xjf linshare-ui-upload-request-{VERSION}.tar.bz2
[root@localhost ~]$ ln -s linshare-ui-upload-request-{VERSION} upload-request
```
<a name="apacheUR1">
####Apache configuration in a directory
</a>
To deploy the Upload-Request interface of __LinShare__, you need to open your linshare-user.conf virtualhost file :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ vim linshare-user.conf
```
And then add the following lines to the virtualhost section:

```
<Directory "upload-request">
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>
```
To access at __LinShare Upload Request__, first start the Core, then restart the Apache2 service :

`[root@localhost ~]$ service apache2 restart`

<a name="firstAccessUR1">
###First access
</a>

The __Upload Request service__ is now reachable at the address below :

  * Repository installation version : __http://linshare-user.local/upload-request/{uuid}__

Note :

  > You need to inquire the url into your upload request url parameter<br/>
  in your administration interface. To do so, go to your administration interface, choose the __Upload Request__ functionnality,<br/> and inquire the url in the "parameters" fields. 

##Install of the __Upload Proposition__ component (optional)

This module allows to an external user, to ask an internal user, to send him an upload request.

<a name="dlmoduleUP">
####Download of the module
</a>
This module in on free download at the following address :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

For this Installation, download the following file according to the version you want :

  * linshare-ui-upload-proposition-{VERSION}.tar.bz2
  * linshare-upload-proposition-{VERSION}.jar
  * linshare-upload-proposition.sh
  * linshare-upload-proposition-production.yml

> Caution :<br/> 
  * this module requires the installation of the Upload Request module.

Enter the following Commands :

```
[root@localhost ~]$ mv linshare-upload-proposition-<VERSION>.jar /usr/local/sbin/linshare-upload-proposition.jar
[root@localhost ~]$ cp linshare-upload-proposition-production.yml /etc/linshare/
[root@localhost ~]$ cp linshare-upload-proposition.sh /ect/init.d/
[root@localhost ~]$ update-rc.d linshare-upload-proposition.sh defaults
[root@localhost ~]$ chmod +x /etc/init.d/linshare-upload-proposition.sh
```
You now have a script "linshare-upload-proposition.sh" allowing you to have the information on your process status, 
and also to stop or restart it.

<a name="apacheUP">
###Apache configuration via dedicated vhost
</a>

Deploy the __LinShare UI Upload-Proposition__ in the Apache2 server repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-upload-proposition-<VERSION>.tar.bz2
[root@localhost ~]$ mv linshare-ui-upload-proposition-<VERSION> /var/www/linshare-ui-upload-proposition
```
To deploy the __LinShare__ Upload-Proposition interface, it is necessary to activate the __mod_proxy__ module on Apache2. Plus, you must add the the configuration below to the default file provided by debian :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-upload-proposition.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-upload-proposition.conf
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-upload-proposition.conf
<VirtualHost *:80>
...
ServerName linshare-upload-proposition.local
DocumentRoot /var/www/linshare-ui-upload-proposition
<Location /linshare>
    ProxyPass http://127.0.0.1:9080/linshare/webservice/rest/uploadproposition
    ProxyPassReverse http://127.0.0.1:9080/linshare/webservice/rest/uploadproposition
    #This header is added to avoid the JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>
<Directory /var/www/linshare-ui-upload-proposition>
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>
...
</Virtualhost>
```
To __access to LinShare Upload-Proposition__, first start LinShare Core, then restart the Apache2 service :

`[root@localhost ~]$ service apache2 restart`

<a name="firstAccessUP">
###First access
</a>

The __Upload Proposition service__ is now reachable at the addresses below.

  * __http://linshare-upload-proposition.local/__

<a name="apacheUP1">
###Apache configuration via a directory
</a>

Deploy the LinShare UI Upload-Proposition in the linshare repository you created in the user section :

```
[root@localhost ~]$ cd /var/www/linshare
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-upload-proposition-<VERSION>.tar.bz2
[root@localhost ~]$ ln -s linshare-ui-upload-proposition-{VERSION} upload-proposition
```
To deploy the __LinShare__ Upload-Proposition interface, open the linshare-user.conf virtualhost configuration file :

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ vim linshare-user.conf
```
and add those lines to the virtualhost section :

```
<Directory "upload-proposition">
	   Options -Indexes
	   AllowOverride None
	   Order Allow,Deny
	   Allow from all
</Directory>
```
To __access to LinShare Upload-Proposition__, first start LinShare Core, then restart the Apache2 service :

`[root@localhost ~]$ service apache2 restart`

<a name="firstAccessUP1">
###First access
</a>
The __Upload Proposition service__ is now reachable at the addresses below.

  * __http://linshare-user.local/upload-proposition/__
