# Integration with LemonLDAP::NG

LemonLDAP::NG is an open source Web Single Sign On software (WebSSO).


## Resume


Deployment of LemonLDAP::NG is out of scope of this document, you can find a
lot of documentation about LemonLDAP::NG installation here: https://lemonldap-ng.org/documentation/quickstart.
We assume you already have a running instance of LemonLDAP::NG and LinShare.

For the whole guide, I will assume you are using my favorite Linux distribution, aka Debian.

According to our installation guide, LinShare is deployed on http://linshare-user.local.


/!\ there is two ways to use OIDC:
  * You can only delegate the authentication to OIDC but for the provisioning
    you will still rely on user providers (LDAP or TWAKE) to create/provision
    users.
  * You can also decide to delegate the provisioning to OIDC (full delegation).
    To do that, you need to use the OIDC user provider. Users will be created at
    first connection or when they are added to a sharing or a worgroups. User's
    profile will be created using OIDC claims as source of information. See Step 4.


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
    * Public client: Off
    * for LinShare < 5 : Allowed redirection addresses for login: http://linshare-user.local/#!/oidc
    * for LinShare >= 5 : Allowed redirection addresses for login: http://linshare-user.local/#!/oidc/callback
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
      scope: 'openid email profile'
    },
    oidcEnabled: true,

```

## Step 4: OIDC User Provider (Optional)

As explained above, you can also configure LinShare to create user's profile
from OIDC claims.

In the admin interface, you need to go to [configuration](https://admin.linshare-5-0-on-commit.integration-linshare.org/new/#/configuration)
page then go to a Top or Sub Domain, click on Providers/UserProviders and create
an 'OIDC Provider'. You will be able to provide a discriminant value aka associated
domain identifier, using the claim 'domain_discriminator', in order to create new users in this domain.


Look at documentation above each field for more details. Go step 1 to see how to
add other claims.
