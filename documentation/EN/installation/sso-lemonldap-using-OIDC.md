# Integration with LemonLDAP::NG

LemonLDAP::NG is an open source Web Single Sign On software (WebSSO).


## Resume


Deployment of LemonLDAP::NG is out of scope of this document, you can find a
lot of documentation about LemonLDAP::NG installation here: https://lemonldap-ng.org/documentation/quickstart.
We assume you already have a running instance of LemonLDAP::NG and LinShare.

For the whole guide, I will assume you are using my favorite Linux distribution, aka Debian.

According to our installation guide, LinShare is deployed on http://linshare-user.local.


## Step 1: LemonLDAP::NG configuration.

You need to add a new relying party named LinShare.

So you need to go to the menu named "OpenID Connect Relying Parties" and then
do:
* Add OpenID Relying Party: LinShare
  * exported attributes:
    * email => mail
    * family_name => sn
    * name => givenName
  * Options/Basic
    * ClientID: linshare
    * Client secret: linshare
    * Allowed redirection addresses for login: http://linshare-user.local/#!/oidc
  * Options/Security
    * Require PKCE: On

Now you need to save to apply the configuration. 
Hint you will need the Issuer identifier URL for the next step, so grab it
before leaving the manager. (See: OpenID Connect Service / Issuer identifier)
In our example we will use "http://auth.linshare.local".

## Step 2: LinShare backend configuration

You need to enablde OIDC support in LinShare.
NB: OIDC will not be enabled if you are still using the 'sso' spring profile,
please use 'default' instead.


You need to edit `/etc/linshare/linshare.properties` and add/uncomment the following keys:

Since LinShare 4.1:
```
## OIDC Parameters
oidc.on=true
oidc.introspectionUri=http://auth.linshare.local/oauth2/introspect
oidc.client.id=linshare
oidc.client.secret=linshare
```

Since LinShare 4.2:
```
## OIDC Parameters
oidc.on=true
oidc.issuerUri=http://auth.linshare.local
oidc.client.id=linshare
oidc.client.secret=linshare
```

Finally just restart Tomcat : `systemctl restart tomcat`.


## Step 3: LinShare frontend configuration

You need to edit the configuration file linshare-ui-user/config/config.js
and add the following keys:

```
    ...
    homePage: 'home',
    ...
    oidcSetting: {
      authority: 'http://auth.linshare.local',
      client_id: 'linshare',
      client_secret: 'linshare',
      redirect_uri: window.location.origin + '/#!/oidc',
      post_logout_redirect_uri: window.location.origin + '/#!/login',
      response_type: 'code',
      scope: 'openid email profile'
    },
    oidcEnabled: true,

```
