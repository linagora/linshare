Afin d'améliorer la sécurité au sein de LinShare, la fonctionnalité de vérouillage des comptes a été intégrée depuis la version 4.0.0.
# Règles de verouillage:

Les règles de verrouillage de compte sont utilisées par LinShare pour verrouiller un compte lorsque l'utilisateur tente de se connecter plusieurs fois de suite sans succès.

- Après 3 tentatives : compte verouillé pendant 10 minutes
- Après 6 tentatives : compte verouillé pendant 20 minutes
- Après 9 tentatives : compte verouillé pendant 60 minutes (1 hour)
- Après 12 tentatives : compte verouillé pendant 1440 minutes (1 day)
- Après 15 tentatives : compte verouillé indefiniment (Il est donc indispensable de faire une demande à l'administrateur pour devérouiller le compte)

# Déverouillage des comptes:

L'administrateur a la possibilité de déverouiller le compte d'un utilisateur bloqué.
- Dans le menu à gauhe choisir Utilisateurs 
- Puis la rubrique Configuration des utilisateurs
- Dans la barre de rechercher, mettez le nom de l'utilisateur concerné et selectionez le
- Si le compte de l'utilisateur est verouillé un boutton sera affiché vous donnant la possibilité de déverouiller ce compte

<img src="http://download.linshare.org/screenshots/4.0.0/04.unblock_user.png" alt="unlock_accounts_screeshot" width="600"/>