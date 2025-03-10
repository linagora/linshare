##  Comment se connecter à LinShare sans email

#### 1) Introduction

LinShare est configuré par défaut par accepter uniquement un email lors de la connexion.  
L'objectif de cette documentation est de vous montrer comment configurer LinShare afin de pouvoir se connecter sans email.


#### 2) Configuration

Cette élément de configuration est dans la partie cliente de LinShare `linshare-ui-user`,  
plus précisément dans le fichier `linshare-ui-user/config/config.js`:

```
...
      loginWithMailOnly: true,
...
```

il vous suffit de passer cette valeur à `false`.

Par suite, les utilisateurs pourront se connecter sans email (`peter.wilson` au lieu de `peter.wilson@linshare.org`).  
La valeur utilisée pour l'authentification de l'utilisateur correspond à `uid`  dans la configuration du filtre ldap.  

![](../../EN/administration/images/ldap_authentication_query.png)

voici l'enregistrement ldap correspondant à l'exemple précédent:

![](../../EN/administration/images/ldap_search.png)
