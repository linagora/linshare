# LinShare

## Description

Specially designed to secure paperless file sharings within companies that put
privacy and traceability in the heart of their problems of exchange, LinShare
provides a simple solution completely intuitive.

* Linshare allows employees to upload files into their space
* Linshare can share files with internal or external collaborators
* Linshare offers several features to securely exchange

More information on http://www.linshare.org/

## Live demo:

A Live demo of LinShare is available at https://demo.linshare.org/.
This demo reflects the latest developments done on LinShare, it will be
reseted and updated on regulary basis.

This instance of LinShare is set up with some test users, from user1 to user7 :
 * user1@linshare.org : password1
 * user2@linshare.org : password2
 * user3@linshare.org : password3
 * user4@linshare.org : password4
 * user5@linshare.org : password5
 * user6@linshare.org : password6
 * user7@linshare.org : password7

If you want to share with some external users, use these five email addresses *external1@linshare.org* to *external5@linshare.org*.
External users are just an email address without a LinShare account.

We also provide  guest1@linshare.org to guest5@linshare.org emails adresses,
who are also external accounts but you can use them to create guests.

NB: You won't able to send or receive emails if your email address is not @linshare.org.

In order to see emails sent by LinShare, we also put at your disposal a webmail
available at *https://demo-webmail.linshare.org*.

Webmail passwords :
 * user1@linshare.org : password1
 * ...
 * external1@linshare.org : password1
 * ...
 * external5@linshare.org : password5
 * guest1@linshare.org : password1
 * ...
 * guest5@linshare.org : password5


## All repositories

LinShare is now splitted into multiple repositories.
You can clone the whole project using the following commands :

### Main repository:

* git clone https://github.com/linagora/linshare.git

NB: You can download all components using Maven:

$ mvn dependency:copy-dependencies -DoutputDirectory='linshare'

### LinShare server components:

* git clone https://github.com/linagora/linshare-core.git
* git clone https://github.com/linagora/linshare-ui-admin.git
* git clone https://github.com/linagora/linshare-ui-user.git
* git clone https://github.com/linagora/linshare-ui-upload-request.git
* git clone https://github.com/linagora/linshare-ui-upload-proposition.git
* git clone https://github.com/linagora/linshare-upload-proposition.git

### LinShare client components:

* git clone https://github.com/linagora/linshare-plugin-thunderbird

### For tests and demonstration:

* git clone https://github.com/linagora/linshare-docker

### Recommended version for LinShare's components:

| Version | OS                  | JAVA JRE    | PostgreSQL    | MongoDb     | Tomcat   | Apache  HTTPD   |
|---------|---------------------|---------|---------------|-------------|----------|----------|
| 4.0   | Debian 10  Centos 7 | OpenJDK 11 | postgreSql 11 | MongoDB 4.2 | Tomcat 9 | Apache 2.4 |
| 2.3   | Debian 8, 9 Centos 7  | OpenJDK 8  | postgreSql 9  | MongoDB 3.2 to 3.6| Tomcat 8 | Apache 2.4 |
| 2.2   | Debian 8, Centos 7  | OpenJDK 8  | postgreSql 9  | MongoDB 3.2 | Tomcat 8 | Apache 2.4 |
| 2.1   | Debian 8, Centos 7  | OpenJDK 8  | postgreSql 9  | MongoDB 3.2 | Tomcat 8 | Apache 2.4 |
| 2.0   | Debian 8, Centos 7  | OpenJDK 8  | postgreSql 9  | MongoDB 3.2 | Tomcat 8 | Apache 2.4 |
| 1.12  | Debian 8, Centos 7  | OpenJDK 7  | postgreSql 9  |      X      | Tomcat 7 | Apache 2.2 |
