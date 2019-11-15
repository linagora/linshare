#  Eclipse programation environment installation

##  Download

It is essential to use the following version of Eclipse: Eclipse IDE for java Developers and it is better to download
it from the site: http://www.eclipse.org/downloads/

##  Plugins installation

You need the following three plugins

    * eGit
    * Maven Integration for Eclipse
    * Run-jetty-Run

Or you will find them on the eclipse marketplace. To go on your Eclipse's marketplace run your Eclipse, open the help
window and click on «Eclipse Marketplace...». A new window will open and you can now search for your plugins and simply
install them.

##  Cloning the sources of linshare

You can now install git if you do not have it yet:

    ~$ apt-get install git

Now you can clone the project in your Eclipse workspace folder using : git clone https://github.com/linagora/linshare-core.git
Or you can clone directly your sources from Eclipse board.

## Cloning sources in Eclipse

To clone your sources directly from Eclipse, go on the git view and click on the "clone new repository" link. Fill the
blancks and click on next. This allows you to commit directly from Eclipse to your repository.

## Environment configuration

Once you have cloned your sources Eclipse will start building your project. Usually you will have in the console an error
while buiding dependencies because a plugin is missing. To fix it, right click on it, choose quick fix, this will
prompt you to download the "Maven build helper" plugin, agree and click on "Discover" then next. It will rebuild
your project and normally you will not have any errors again.

     * Creation of your databases and postgresql configuration:

Open a terminal and download Postgresql, if you don't have it yet, - type - :

    ~$ apt-get install postgresql
    ~$ service postgresq start

NB: to execute this commands you have to be on root mode.

Edit the following file /etc/postgresql/<VERSION>/main/pg_hba.conf in the following way to grant access to your user to your databases


    # TYPE  DATABASE                  USER                   METHOD
    local   all               linshare                           md5
    local   all               linshare_data                           md5
    host    all               linshare      127.0.0.1/32         md5
    host    all               linshare_data      127.0.0.1/32         md5
    host    all               linshare      ::1/128              md5

Once done, stay in the root mode and enter:

    ~$ su - postgres
    ~$ psql

You are now on the postgresql command mode and you can create your user and your databases. Open a new tab within your terminal,
then go in your sources and find the createDatabase.sh file in /src/main/resources/sql/postgresql/, then execute it. This will
generate all sql queries to create your user and your databases. Copy the instructions and paste them to your psql shell.
Your user and databases are now created. You can quit the postgresql mode.

Go in the postgresql directory in your sources and execute the following command lines:

    ~$  psql -U linshare -W -d linshare < createSchema.sql
    ~$  psql -U linshare -W -d linshare < import-postgresql.sql

Reload your postrgresql's service.

NB:
    - To avoid to always have to type your password during the connection to postgresql, you can can create a .pgpass file
      in your /home/user/ repository. The pgpass file contain the following line:

     - host_name:port:database:user:password

      Each of the variable are acting like regex, they match a pattern so if you put * in the variable value it will match
      everything.

## Linshare configuration

Create a repository "configurations" (mkdir configurations) in your workspace and execute the command lines:

    ~$ cd configurations
    ~$ mkdir my_conf1
    ~$ cd my_conf1
    ~$ cp ../../YOUR_LINSHARE_REPOSITORY/src/main/resources/linshare.properties.sample linshare.properties
    ~$ cp ../../YOUR_LINSHARE_REPOSITORY/src/main/resources/log4j.properties

Edit the linshare.properties:

         #******************** DATABASE
     ### PostgreSQL
     linshare.db.username=linshare
     linshare.db.password=<YOUR_PASSWORD>
     linshare.db.driver.class=org.postgresql.Driver
     linshare.db.url=jdbc:postgresql://localhost:5432/linshare
     linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
     linshare.db.persistence_manager=org.apache.jackrabbit.core.persistence.bundle.PostgreSQLPersistenceManager

     #******************** MAIL CONFIGURATION TO SEND MAIL INFORMATION TO USER

     mail.smtp.host=my.smtp.com
     # leave it blank to disable email notifications

     #******************** GENERAL PROPERTIES

     #set to true in tapestry production environnement
     linshare.productionMode=false
     #local work directory to encrypt/decrypt data
     linshare.encipherment.tmp.dir=YOUR_PATH_TO_YOUR_WORKSPACE/workspace/configurations/my_conf1/tmp
     #local work directory to sign data
     linshare.signature.tmp.dir=YOUR_PATH_TO_YOUR_WORKSPACE/workspace/configurations/my_conf1/tmp/LinSignDocuments
     #directory used to store shared files
     linshare.files.directory=YOUR_PATH_TO_YOUR_WORKSPACE/workspace/configurations/my_conf1/repository

Do not forget to create the repositories in your configuration repository.

NB : to run the tests in eclipse you need to configure a temporary directory. You can declare it as a environment variable
(LINSHARE_HOME) in your .bashrc file. To do that open your .bashrc file and add this line:

    export LINSHARE_HOME='/home/YOUR_USER/tmp/linshare'

You could also configure this variable in eclipse environment

then source it:

    ~$ source .bashrc

## Adding Our CA to your keystore
Update your certificates and access the nexus repository by https (Ubuntu):

     ~$ cd /usr/share/ca-certificates
     ~$ mkdir gandi
     ~$ cp /tmp/GandiStandardSSLCA2.pem gandi/
     ~$ ls gandi/* >> /etc/ca-certificates.conf
     ~$ update-ca-certificates
     ~$ /var/lib/dpkg/info/ca-certificates-java.postinst configure

The last command will only works on Debian like system. It will update jdk and jre keystore. You can also do it manually by typing the following command:

Update Java certificates keystore using keytool :

       ~$ sudo keytool -import -alias gandica -file /usr/share/ca-certificates/gandi/GandiStandardSSLCA2.pem -keystore /usr/lib/jvm/java-7-openjdk/jre/lib/security/cacerts

## Maven mirros

You may need to add our nexus to your maven mirrors configuration if you have some
missing jars.

    ~$ mkdir ~/.m2/
    ~$ cd ~/.m2/
    ~$ cp /etc/maven/settings.xml .

Edit this new file, and add the following lines in the section <mirrors></mirrors> :

<mirror>
    <id>internal-repository</id>
    <url>https://nexus.linagora.com/content/groups/linshare/</url>
    <mirrorOf>*</mirrorOf>
</mirror>




## Maven and servers configuration:

> Note
* For LinShare 2.3 and previous versions, the java version used is Java 8, we can use Jetty as a server.
* For LinShare 2.4 Java 11 is used, we need to configure Tomcat server, Jetty is not functional with this Java version.

### Maven and Jetty configuration:

Go to your Eclipse and click on the "run" tab then choose "run configuration"

   * Creation of the jetty's profile:

Richt click on Jetty Webapp and choose new. Rename it the way you want, you can see that some options are already pre-filled.
Add the those lines to the VM arguments :

      -Dlog4j.configuration=file:${workspace_loc}/configurations/my_conf1/log4j.properties
      -Dlinshare.config.path=file:${workspace_loc}/configurations/my_conf1
      -XX:MaxPermSize=256m -Djava.awt.headless=true -Xms512m -Xmx1538m  -XX:-UseSplitVerifier

   * Creation of the Maven's profiles:

If you want to use a full embedded LinShare (h2 database and ldap in memory), you could use profiles embedded inside maven pom with jetty plugin for eclipse.

Richt click on Jetty Webapp and choose new. Rename it the way you want. in the Goals write "jetty:run" and in the
Profiles: "h2,local". 

In the Environment tab create a new variable, name it LINSHARE_HOME, and set it's value (${workspace/configurations/my_conf1})projects/linshare/files.

  * Maven command line :

The embedded jetty plugin inside maven pom allows you to run linshare for maven command line.
You could use embedded profiles or external configuration like in eclipse.

# temporary directory for h2 database, tests, ...
export LINSHARE_HOME=/tmp/linshare/
# run full embedded linshare
mvn jetty:run -Ph2,local

### Tomcat server installation and configuration:

###### Download Tomcat 9
You need to download the Tomcat archive from its official website [official download](https://tomcat.apache.org/download-90.cgi) .

###### Add tomcat Server to Eclipse
Extract the archive and Go on your Eclipse and click on the __Window__ menu and select __Preferences__. Sereach __Server__ and select __Runtime Environment__
Click on __Add...__ button and select Tomcat9,  click on __Next__ and browse into the __apache-tomcat-9.0.21__ directory.

On __Window__ menu click on __Show view__ and select __Server__.
You can create a new server by going on File>New>server. click next and move linshare-core project to the right to configure it on the server.

###### Server configuration

On servers views, double click on your linshare server, and click on __Open launch configuration__.
- In the Arguments tab you have add those lines:

      -Dlog4j.configuration=file:${workspace_loc}/configurations/my_conf1/log4j.properties
      -Dlinshare.config.path=file:${workspace_loc}/configurations/my_conf1
      -Djava.awt.headless=true -Xms512m -Xmx1538m

- And in the Environment tab create a new variable named "LINSHARE_HOME", which have the value of linshare.properties file path :

    ${workspace_loc}/configurations/my_conf1

###### Important:
Be aware to the Context on the tab "Modules", change the path to __/linshare"__.
## Linshare admin panel configuration:

Download the admin archive from the forge: http://download.linshare.org/versions
Then follow the default intallation guide.
