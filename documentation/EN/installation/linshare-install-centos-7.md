##Summary

###LINSHARE INSTALLATION

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


###LINSHARE INSTALLATION

> Note:<br/>
    In this manual, we chose components that we recommend, which are Mongo DB - PostgreSQL - Apache Tomcat - Apache httpd - JAVA.
    You can however adapt depending upon the components you may choose.

<a name="installmin">
###__Linshare__ minimum Installation
</a>

<a name="dlLinshare">
###Download of __LinShare__
</a>

__LinShare__ is open, free and available at this address (the LATEST version) :

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

For this installation, download the following files :

  * __linshare-core-{VERSION}.war__
  * __linshare-ui-admin-{VERSION}.tar.bz2__
  * __linshare-ui-user-{VERSION}.tar.bz2__

<a name="instalFile">
###Deployment of the archive and the configuration files
</a>
To manipulate the archives, it is necessary to use Unzip and Bzip tools :

`[root@localhost ~]$ yum install unzip bzip2`

Create the configuration repository of __LinShare__ and past the configuration files :

```
[root@localhost ~]$ mv linshare-core-{VERSION}.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

###Executive environment JAVA (JVM)

__LinShare__ works with OpenJDK and Sun/Oracle Java 8. This section is on OpenJDK Java 8.

<a name="instalOpenJdk">
####Installation of OpenDK
</a>
Install Java Runtime Environment (JRE) of OpenJDK from the repositories :

```
[root@localhost ~]$ yum -y install java-1.8.0-openjdk.x86_64
[root@localhost ~]$ update-alternatives --config java
```

> Note :<br/>
    * You can ignore the possible errors from the Java plugin.

<a name="bdd">
###Databases
</a>

LinShare needs the use of a database (PostgreSQL) for its files and its configuration.

Mysql is not supported yet in LinShare v2 

This section present an installation with PostgreSQL.

Install PostgreSQL from the repositories :

`[root@localhost ~]$ yum install postgresql`


Start the PostgreSQL service :

`[root@localhost ~]$ service postgresql initdb`

`[root@localhost ~]$ service postgresql start`

####Secure accesses creation

Edit the PostgreSQL's access gestion file :

```
[root@localhost ~]$ vim /var/lib/pgsql/data/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   all               postgres               peer
 local   linshare,linshare_data    linshare                           md5
 host    linshare,linshare_data    linshare      127.0.0.1/32         md5
 host    linshare,linshare_data    linshare      ::1/128              md5

```

> Note :<br/>
    * Those lines are usually at the end of the file.<br/>
    * For security reasons, the postgreSQL service only listen in local.<br/>
    * Restart/reload the postgreSQL server to apply the modifications:<br/>
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
     * If you need, there is a script named createDatabase.sql under src/main/resources/sql/postgresql/ which gives
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

For the LinShare V2 installation, mongoDB is also required. You can install it by following these steps :

The mongodb-org package does not exist within the default repositories for CentOS. 
However, MongoDB maintains a dedicated repository. Let's add it to our server.
With the vi editor, create a .repo file for yum, the package management utility for CentOS:

```
[root@localhost ~]$ vi /etc/yum.repos.d/mongodb-org.repo
```
Then, add the repository information for the latest stable release to the file:

```
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc

```
We can install the mongodb-org package from the repository using the yum utility:

```
[root@localhost ~]$ yum install mongodb-org
```
Before lunching the MongoDB make sure that que file /etc/mongod.conf has the bind ip address: 127.0.0.1

Next, start the MongoDB service with the systemctl utility:
```
[root@localhost ~]$ systemctl start mongod


<a name="tomcat">
####Servlet container
</a>
LinShare is a Java application compiled and embedded under the WAR (#W#eb #A#pplication a#R#chive) format, so it needs a __servlet container Java__ (Tomcat or Jetty) to run.

This section presents the installation of the Tomcat server.

####Tomcat 7 installation


Install Tomcat from the repositories :

`[root@localhost ~]$ yum install tomcat`



> Note :<br/>
     * Check the Tomcat status to make sure the service is active with systemctl status tomcat
  
####Tomcat 7 Configuration 


To specify the location of the LinShare __configuration__ (_linshare.properties_ file) and also the default start
options, get the commented options in the first lines of the __linshare.properties__ file and copy-paste them in the Tomcat file (/etc/sysconfig/tomcat):


All starting needful options by default to Linshare are indicated in the header of the following configuration files :

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

####Deployment of the archive

Deploy the archive of Linshare application in the Tomcat server :

```
[root@localhost ~]$ cp linshare.war /usr/share/tomcat/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat:tomcat /var/lib/linshare
```
<a name="apache">
####Web server
</a>

The administration interface of __LinShare_ is an application based on HTML/CSS and JavaScript.
It just needs a simple web server like Apache or Nginx.

This section presents the installation of Apache HTTP server.

####Apache 2 installation
Install Apache 2 from the repositories :

```
[root@localhost ~]$ yum install httpd
```
It will bring Apache/2.4.6 (CentOS)

#####Vhost configuration
<a name="ui-user">
####ui-user
</a>
To deploy the LinShare application, it is necessary to activate the __mod_proxy__ module on Apache 2. 
You need to create your directories in the /var/www/ directory, note that your directory name will be your application domain name.
You need to give your user rights to access to the directories too. 

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
```

To deploy the LinShare application, it is necessary to create the virtualhost configuration file :

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-user.conf

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

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-user-error.log
CustomLog /var/log/httpd/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:<br/>
   * After any modification of a vhost, you must reload the Apache 2 server :
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="ui-admin">
####ui-admin
</a>
Deploy the archive of the application __LinShare UI Admin__ in the Apache 2 repository :

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
```
To deploy the __LinShare__ administration interface, it is necessary to activate the __mod_proxy__ module on Apache 2.

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-admin-error.log
CustomLog /var/log/httpd/linshare-user-access.log combined
...
</Virtualhost>
```

> Note:
   * After any modification of a vhost, you must reload the Apache 2 server :
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="linconf">
###LinShare configuration and launching
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

On LinShare, you have two possible authentication mode, the first is the nominal mode, and the second is the sso mode. To start LinShare you must at least enable one of those two following modes:

* default : default authentication process.
* sso : Enable headers injection for SSO. This profile includes default profile capabilities

The default profile is jcloud with filesystem for tests purpose.

You can override this parameter using -Dspring.profiles.active=xxx
Or you can use environment variable : SPRING_PROFILES_ACTIVE
You must enable at least one authentication profile among authentication profiles and one profile among file data store profiles described below.

Available file data store profiles :

* jcloud : Using jcloud as file data store : Amazon S3, Swift, Ceph, filesystem (test only).

* gridfs : Using gridfs (mongodb) as file data store.

* jackrabbit2 : Using jackrabbit as file data store.

* jackrabbit-to-jcloud : Using Jcloud as new file data store, jackrabbit as fallback file data store.

* jackrabbit-to-gridfs : Using GridFS as new file data store, jackrabbit as fallback file data store.

Recommended profile for production is jcloud with Swift.

The default profile is jcloud with filesystem for tests purpose.

> Note
   - We only use JackRabbit for the transition, it is deprecated.

To __start LinShare__, start the Tomcat service :

`[root@localhost ~]$ systemctl restart Tomcat`

To verify that __LinShare__ works, consult the __logs__ file :

`[root@localhost ~]$ tail -f /opt/tomcat/logs/catalina.out`

If the service start correctly, you should have those following messages:

```
[...]
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Then restart the Apache 2 service :

`[root@localhost ~]$ apachectl restart`

Note :
   > You have some vhost's examples in the following repository : [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">
###First access
</a>
The __LinShare service__ is now reachable at the following adresses :

For the user interface :

  * __http://linshare-user.local/linshare__

Note :

  > This url must also be inquired in the parameters of your domain. To do so, go to the __domain__ functionality and
  enter it in the __notifcation url__ parameters fields

For the administration interface :

  * __http://linshare-admin.local/__

####LinShare setting

Connect to LinShare as a Linshare _system administrator_ :

  * Login : __root@localhost.localdomain__

  * Password : __adminlinshare__

Then, to interconnect __Linshare__ with your LDAP user directory, create a new domain from the section "DOMAINS". For further informations, please refer to the __Configuration and$



