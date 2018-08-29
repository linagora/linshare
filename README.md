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

This instance of LinShare is set up with some test users, from user1 to user7.
For user1@linshare.org, password is password1, and so on for other users.

In order to see emails sent by LinShare, we also put at your disposal a webmail
available at https://demo-webmail.linshare.org. The underlying mail server won't
accept email if the recipient is different than the test users (@linshare.org).

If you want to share with some fake external users, use these following email addresses :

* external1@linshare.org with mailbox : password1
* external2@linshare.org with mailbox : password2


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

