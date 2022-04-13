Afin d'améliorer la sécurité au sein de LinShare, la fonctionnalité de verrouillage des comptes a été intégrée depuis la version 4.0.0.
# Règles de verrouillage :

Les règles de verrouillage de compte sont utilisées par LinShare pour verrouiller un compte lorsque l'utilisateur tente de se connecter plusieurs fois de suite sans succès.

- Après 3 tentatives : compte verrouillé pendant 10 minutes
- Après 6 tentatives : compte verrouillé pendant 20 minutes
- Après 9 tentatives : compte verrouillé pendant 60 minutes (1 heure)
- Après 12 tentatives : compte verrouillé pendant 1440 minutes (1 jour)
- Après 15 tentatives : compte verrouillé indéfiniment (Il est donc indispensable de faire une demande à l'administrateur pour déverrouiller le compte)

# Déverrouillage des comptes :

L'administrateur a la possibilité de déverrouiller le compte d'un utilisateur bloqué.
- Dans le menu à gauche, choisir Utilisateurs
- Puis la rubrique Configuration des utilisateurs
- Dans la barre de recherche, mettez le nom de l'utilisateur concerné et sélectionnez le
- Si le compte de l'utilisateur est verrouillé un bouton sera affiché vous donnant la possibilité de déverrouiller ce compte

<img src="http://download.linshare.org/screenshots/4.0.0/04.unblock_user.png" alt="unlock_accounts_screeshot" width="600"/>
