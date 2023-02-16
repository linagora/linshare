# LinShare

## License
Linshare is released under the terms of the license GNU AGPLv3. For more information please see [here](LICENSE.md)


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

This instance of LinShare is set up with some test users:
- abbey.curry@linshare.org : secret
- amy.wolsh@linshare.org : secret
- anderson.waxman@linshare.org : secret
- cornell.able@linshare.org : secret
- dawson.waterfield@linshare.org : secret
- felton.gumper@linshare.org : secret
- grant.big@linshare.org : secret
- nick.derbies@linshare.org : secret
- peter.wilson@linshare.org : secret
- walker.mccallister@linshare.org : secret


If you want to share with some external users, use these five email addresses *external1@linshare.org* to *external5@linshare.org*.
External users are just an email address without a LinShare account.

We also provide  guest1@linshare.org to guest5@linshare.org emails adresses,
who are also external accounts but you can use them to create guests.

NB: You won't able to send or receive emails if your email address is not @linshare.org.

In order to see emails sent by LinShare, we also put at your disposal a webmail
available at *https://demo-webmail.linshare.org*.

Webmail passwords :
 * abbey.curry@linshare.org : secret
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

### Required versions of LinShare's dependencies:

- You can find the required versions of LinShare's dependencies [here](documentation/EN/installation/requirements.md)

