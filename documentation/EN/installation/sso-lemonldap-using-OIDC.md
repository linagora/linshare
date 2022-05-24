# Integration with LemonLDAP::NG

LemonLDAP::NG is an open source Web Single Sign On (WebSSO) supporting multiple
protocoles, like CAS, SAML, header injections, OIDC, ... In this case, we are
going to use OIDC which is the recommended protocole.


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
    * given_name => givenName
  * Options/Basic
    * ClientID: linshare
    * Client secret: linshare
    * Public client: Off
    * for LinShare < 5 : Allowed redirection addresses for login: http://linshare-user.local/#!/oidc
    * for LinShare >= 5 : Allowed redirection addresses for login: http://linshare-user.local/#!/oidc/callback, http://linshare-admin.local/new/#/oidc/callback
  * Options/Security
    * Require PKCE: On

NB: Prior LinShare 5.0, it was:
    * name => givenName

Now you need to save to apply the configuration. 
Hint you will need the Issuer identifier URL for the next step, so grab it
before leaving the manager. (See: OpenID Connect Service / Issuer identifier)
In our example we will use "http://auth.linshare.local".

* Add OpenID Relying Party: LinShareMobile
	* exported attributes:
		 * email => mail
 		* family_name => sn
 		* given_name => givenName
	* Options/Basic
		 * ClientID: linshare-mobile
		 * Client secret: linshare
		 * Public client: Off
		 * PostLogoutRedirectUris : "linshare.mobile://oauthredirect" // must be, unless you can change that in mobile
		 * RedirectUris: "linshare.mobile://oauthredirect"  // must be, unless you can change that in mobile

	- Options/Security
		 * Require PKCE: On
		 * 
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

## Step 3.1: LinShare frontend configuration : Ui-User

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

```
    ...
    mobileOidcEnabled: true,
    mobileOidcSetting: {
      authority: 'https://auth.linshare.local',
      client_id: 'linshare-mobile',
      redirect_url: 'linshare.mobile://oauthredirect',
      post_logout_redirect_uri: 'linshare.mobile://oauthredirect',
      response_type: 'code',
      scope: 'openid email profile'
    },
    ...
```

## Step 3.2: LinShare frontend configuration : Ui-Admin

You need to edit the configuration file linshare-ui-admin/new/config/config.js
and add the following keys:

```
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
domain identifier, using the claim `domain_discriminator`, in order to create new users in this domain.

In order to be flexible, this claim is a list (ex ['DOMAIN_8']). For now
LinShare supports only one domain at the time but we expect to be able to
support multiple domains in the futur. This field can also contains application roles, and
only some of them are useful for LinShare, ex: `['APP_1_ROLE_1','APP_2_ROLE_8','LINSHARE_ROLE_VIP','APP_2_ROLE_ADMIN', ...]`
In this example, only `LINSHARE_ROLE_VIP` will be useful to match a domain 'VIP'.
Maybe for other users, it could be `LINSHARE_ROLE_REGULAR`. These other roles can
be provided but will be silently ignored if they do not match any domains.

So you may need to create a new scope, named `linshare` with this new claim.
Then you need to edit ui-user and ui-admin config.js file to change the scope
value as : `scope: 'openid email profile linshare'`


Look at documentation above each field for more details. Go step 1 to see how to
add other claims.
