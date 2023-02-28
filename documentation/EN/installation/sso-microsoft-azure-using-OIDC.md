
# Integration with Microsoft AZURE ACTIVE DIRECTORY

Microsoft Azure Active Directory is an enterprise identity service that provides single sign-on, multifactor authentication, and conditional access.

## Resume

Microsoft AZURE configuration is out of the scope of this document.
You can find a lot of documentation about  Microsoft AZURE configuration here: 
https://learn.microsoft.com/en-us/azure/active-directory-b2c/configure-authentication-sample-spa-app.
We assume you already have a subscription to Microsoft Azure and a running instance of LinShare.

For the whole guide, I will assume you are using my favorite Linux distribution, aka Debian.

According to our installation guide, LinShare is deployed on https://linshare-user.local (https is mandatory).

The Microsoft Azure authentication is supported from Linshare 6.0.2


/!\ there is two ways to use OIDC:
  * You can only delegate the authentication to OIDC but for the provisioning
    you will still rely on LDAP user provider to create/provision
    users.
  * You can also decide to delegate the provisioning to OIDC (full delegation).
    To do that, you need to use the OIDC user provider. Users will be created at
    first connection or when they are added to a sharing or a worgroups. User's
    profile will be created using OIDC claims as source of information. See Step 4.


## Step 1: Microsoft AZURE configuration.

You need to register your application 

1. Sign in to the Azure portal.

2. If you have access to multiple tenants, use the Directories + subscriptions filter  in the top menu to switch to the tenant in which you want to register the application.

3. Search for and select Azure Active Directory.

4. Under Manage, select App registrations > New registration.

5. Enter a display Name for your application. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time and multiple app registrations can share the same name. The app registration's automatically generated Application (client) ID, not its display name, uniquely identifies your app within the identity platform.

6. Specify who can use the application, sometimes called its sign-in audience.
check Accounts in this organizational directory only

7. Don't enter anything for Redirect URI (optional). You'll configure a redirect URI in the next section.

8. Select Register to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's Overview pane. You see the Application (client) ID. Also called the client ID, this value uniquely identifies your application in the Microsoft identity platform.

9. In the Azure portal, in App registrations, select your application.

10. Under Manage, select Authentication.

11. Under Platform configurations, select Add a platform.

12. Under Configure platforms, select Single-page application.

13. Enter a Redirect URI for your app : https://linshare-user.local/oidc/callback


##  Claims creation 
   Microsoft Documentation : https://learn.microsoft.com/en-us/azure/active-directory/develop/active-directory-jwt-claims-customization

1. select Azure Active Directory.

2. select Entreprise applications > your app > Single sign-on > Attributes & Claims

3. Add new claim
   Name: domain_discriminator
   Source: Attribute
   Source Attribute : "linshare_domain_name"
   Select Advanced SAML claims options and check Expose claim in SAML tokens in addition to JWT tokens
   
   Add new claim
   Name: first_name
   Source: Attribute
   Source Attribute : user.givenname
   Select Advanced SAML claims options and check Expose claim in SAML tokens in addition to JWT tokens
   
   Add new claim
   Name: last_name
   Source: Attribute
   Source Attribute : user.surname
   Select Advanced SAML claims options and check Expose claim in SAML tokens in addition to JWT tokens
   
##  Scope creation 

1. select Azure Active Directory.

2. select App registrations > your app > Expose an API

3. Add scope :
   Fill in the mandatory fields
   Scope name : linshare-scope
   Select for Who can consent? : Admins and users 
   Select for the state : enabled



## Step 2: LinShare backend configuration

You need to enable OIDC support in LinShare.
NB: OIDC will not be enabled if you are still using the 'sso' spring profile,
please use 'default' instead.


You need to edit `/etc/linshare/linshare.properties` and add/uncomment the following keys:


```
## OIDC Parameters
oidc.on=true
oidc.issuerUri=https://login.microsoftonline.com/{teant_id}/v2.0/',
oidc.client.id={client_id}
oidc.client.secret={secret}
```

Finally just restart Tomcat : `systemctl restart tomcat`.


## Step 3: LinShare frontend configuration

## Step 3.1: LinShare frontend configuration : Ui-User

You need to edit the configuration file 'linshare-ui-user/config/config.js'
and add the following keys:

```
    ...
    homePage: 'home',
    ...
    oidcEnabled: true,
      oidcForceRedirection: false,
      oidcSetting: {
        authority: 'https://login.microsoftonline.com/{teant id}/v2.0/',
        client_id: '{client_id}',
        client_secret: null,
        scope: 'openid email profile api://{client_id}/linshare-scope',
        loadUserInfo: false
      },

```

## Step 3.2: LinShare frontend configuration : Ui-Admin

You need to edit the configuration file 'linshare-ui-admin/new/config/config.js'
and add the following keys:

```
if (typeof window === 'undefined') {
  global.window = {};
}

window.APP_CONFIGURATION = Object.freeze({
  beta: true,
  legacyAppUrl: '/',
  oidcEnabled: true,
  oidcSetting: {
    authority: 'https://login.microsoftonline.com/{teant_id}/v2.0/',
    client_id: '{client_id}',
    client_secret: null,
    scope: 'openid email profile api://{client_id}/linshare-scope',
    loadUserInfo: false,
  },
});

```


## Step 4: OIDC User Provider (Optional)

As explained above, you can also configure LinShare to create user's profile
from OIDC claims.

In the admin interface, you need to go to [configuration]
page then go to a Top or Sub Domain, click on Providers/UserProviders and create
an 'OIDC Provider'. You will be able to provide a discriminant value aka associated
domain identifier, using the claim `domain_discriminator`, in order to create new users in this domain.




