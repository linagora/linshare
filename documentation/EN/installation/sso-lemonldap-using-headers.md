# Integration with LemonLDAP::NG

LemonLDAP::NG is an open source Web Single Sign On (WebSSO) on Debian Jessie.


## Resume


Deployment of LemonLDAP::NG is out of scope of this document, you can find a
lot of documentation about LemonLDAP::NG installation here: https://lemonldap-ng.org/documentation/quickstart.
We assume you already have a running instance of LemonLDAP::NG and LinShare.

For the whole guide, I will assume you are using my favorite Linux distribution, aka Debian.

In standard deployment, LinShare service is published on one URL. We will
reused the same URL declared in the installation guide, linshare-user.local.
In SSO mode, LinShare require an external URL for Guests and Anonymous URL
functionalities. We will keep the original URL for public access and use
linshare-user-sso.local for internal usage.


For LemonLDAP::NG integration, you will have four important steps :
 * Web server configuration:
    Configuration of Apache's vhosts that expose the linshare-ui-user
application.
 * Tomcat configuration
 * Configuration LemonLDAP::NG
    Declaration of a new application in the lemonldap-ng portal with access
rules.
 * LinShare configuration
Once LemonLDAP::NG integration is done, we have to update LinShare configuration
to use good URL for mail notifications.



## Step 1: Web server (Apache)

There is two to integrate an application with LemonLDAP::NG, decentralized (old
way) and centralized (new way).


### Using Apache in decentralized mode

You have to install and deploy the LemonLDAP::NG Handers on the LinShare server

apt-get install lemonldap-ng-handler

This will deploy the default handler vhost : /etc/apache2/sites-available/handler-apache2.conf
Then you can edit it and retrieve the following instructions that you need to
add to your vhost:

```
PerlOptions +GlobalRequest
PerlModule Lemonldap::NG::Handler
```

So you have to deploy 2 vhosts, one protected by LemonLDAP::NG for your internal
users. The second vhost will be used for external access like anonymous URLs or
Guests.

#### Public vhost
```
<VirtualHost *:80>
...
ServerName linshare-user.local
RequestHeader unset Auth-User
...
</Virtualhost>
```

#### Private vhost
```
PerlOptions +GlobalRequest
PerlModule Lemonldap::NG::Handler

<VirtualHost *:80>
...
ServerName linshare-user-sso.local
PerlHeaderParserHandler Lemonldap::NG::Handler
...
</Virtualhost>
```

Then you have to restart Apache: `systemctl restart apache2.service`.


### Using Apache in centralized mode

In a centralized mode, you have to deploy a vhost and its handler on the
LemonLDAP::NG server along all other vhosts/applications. These vhosts only
proxy all trafic to the original application servers. Their main use are to load
and protect the vhost with LemonLDAP::NG instructions. A more detailed guide
will published later.


## Step 2: Tomcat

We also need to update LinShare's Tomcat configuration. We assume you followed
the installation guide and you configuration file is
/etc/linshare/linshare.properties.

At the end of this file, you have to uncomment two parameters:

```
# LinShare will use this header to "authenticate" a user.
# this header must contains an email address of a valid user (LDAP)
sso.header.user=Auth-User
# comma separated list of ip address to be trusted :
sso.header.allowfrom=127.0.0.1
# By default Apache server is deploy on the same host than the tomcat.
```

Then, at the begin of the configuration file, you will find a whole section
explaining how works spring profiles. In our case, we only need to enable "sso"
profile using spring.profiles.active key in /etc/defaut/tomcat.

We may have something like that:
`-Dspring.profiles.active=sso,jcloud,batches`

Finally, you must restart the Tomcat : `systemctl restart tomcat8.service`.


## Step 3: LemonLDAP::NG configuration.

Once the handler is deployed, you have to configure the LemonLDAP::NG manager.
http://manager.example.com/

You have three tasks to do :
* Declare a new protected virtual host (application)
* Update the global logout process
* Declare a new application

### Declare a new protected virtual host (application)

In the manager, go to VirtualHosts section and add a new virtual host with
linshare-user-sso.local as name. Unfold the new created element to add
new rules and set the HTTP header:
  * Rules
    * 000-catch-post-logout (comment)
      * Rule: logout_app_sso https://auth.linagora.com/
      * Expression: ^/linshare/webservice/rest/user/v2/authentication/post-logout
    * 001-unprotect-logout-linshare (comment)
      * Rule: unprotect
      * Expression: ^/linshare/webservice/rest/user/v2/authentication/logout
    * default
      * Rule: accept
  * HTTP Headers
    * Auth-User: $mail

### Update the global logout process

Why do we need a logout forward ?
* If you trigger LinShare logout, we must logout from our sso too.
* If you trigger some application logout, we must logout from LinShare too.

In the manager, go to The General Parameters / Advanced Parameters / Logout Forward section and add a new entry :

New key : LinShare = http://auth.example.com/linshare/webservice/rest/user/v2/authentication/logout


### Declare a new application

you can declare our application in the LemonLDAP::NG Poral with all your
applications. Got to General Parameters / Portal / Menu / Categories and applications and a new application.


## Step 4: LinShare configuration

You will need to update LinShare configuration in the administration interface
(http://linshare-admin.local) with the two LinShare URLs.

First, we have to configure the private URL http://linshare-user-sso.local in the section
`Parameters / Functionalities / Domain / Notification URL` of your root domain `LinShareRootDomain`.
Then, you need to set the public URL for your Guest domains.

Finally, we have to configure the public URL http://linshare-user.local in the section
 Parameters / Functionalities / Anonymous URL / Email notification URL
of your root domain `LinShareRootDomain`.
