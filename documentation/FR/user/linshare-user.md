# Manuel d'utilisation de LinShare

> Note : Ce manuel est valable pour les versions 2.x de LinShare

## Sommaire
* [1. Accueil](#1-accueil)
* [2. Espace personnel](#2-espace-personnel)
  * [Mes fichiers](#mes-fichiers)
  * [Mes partages reçus](#mes-partages-reçus)
  * [Historique](#historique)
* [3. Dépôts en cours](#3-dépôts-en-cours)
* [4. Espace commun](#4-espace-commun)
* [5. Listes de contacts](#5-listes-de-contacts)
* [6. Comptes invités](#6-comptes-invités)
* [7. Historiques des activités](#7-historique-d-activité)

## Langue

Lorsque vous vous connectez sur l'interface utilisateur de LinShare, une page de connexion s'affiche, c'est à ce moment qu'il vous faut choisir la langue de l'application, en cliquant sur le drapeau en haut à droite de l'écran. Notez qu'il ne vous sera pas possible de la modifier une fois connecté.

## 1. Accueil

Une fois connecté, vous arrivez sur la page d'accueil de votre compte.

Cette page d'accueil est une page de bienvenue, avec trois liens en fonction du paramétrage de votre application LinShare :

- *STOCKER VOS FICHIERS* : qui redirige vers votre [espace personnel](#2-espace-personnel).
- *DÉPOSER & PARTAGER* : qui redirige vers les [dépôts en cours](#3-dépôts-en-cours).
- *GROUPE DE TRAVAIL* qui redirige vers l'[espace commun](#4-espace-commun).

## 2. Espace Personnel

L'espace personnel est divisé en deux parties : vos fichiers et les fichiers que l'on a partagé avec vous.

### Mes fichiers

Sur la page **Mes fichiers**, sont listés tous les fichiers que vous avez déposés sur votre Espace Personnel. Chaque fichier en cours de partage (dont la date d'expiration de partage n'a pas été atteinte) est suffixé par le label "*Partagé*".
Afin de déposer un nouveau fichier, vous avez deux choix :

- Cliquer sur le bouton **+** en haut à gauche de l'écran.
- Glisser-déposer votre fichier depuis votre explorateur de fichiers vers l'espace personnel (le cercle central devient bleu).

Lorsque vous survolez un fichier déposé, 3 logos grisés apparaissent sur le côté droit. De gauche à droite, ces logos correspondent à :

- Afficher les informations sur le fichier.
- Partager le fichier avec d'autres utilisateurs (internes ou externes).
- Télécharger le fichier.

### Mes partages reçus

Dans cette section, vous retrouverez tous les fichiers qui ont été partagés avec vous.

Vous retrouverez la plupart des fonctionnalités de la section **Mes fichiers**.

### Historique

Dans toutes les sections affichant des fichiers, un historique d'activités est disponible sur le coté droit de l'écran(en cliquant sur l'icône ![User logo](../../img/adduser.png)). Cet historique réunit toutes les actions effectuées sur les fichiers.

## 3. Dépôts en cours

Dans cette section, vous retrouverez tous les transferts en cours de votre [Espace Personnel](#2-espace-personnel) et [Espace commun](#4-espace-commun).

Afin de visualiser les documents en cours de transfert vers l'espace personnel, vous devez cliquer sur l'onglet "Espace personnel" en haut à droite, ou sur "Espace commun" pour l'espace commun.

Il est possible de gérer les dépôts depuis cette section, les différentes actions sont situées en haut à droite, à côté des onglets "Espace personnel" et "Espace commun". Ces dernières sont les suivantes :

- Mettre en pause l'upload.
- Redémarrer l'upload.
- Annuler l'upload.
- Nettoyer l'historique de l'upload terminé.

## 4. Espace commun

> La section **Espaces commun** réunit les groupes de travail. Ces groupes de travail sont des zones de partage avec des utilisateurs internes ou invités (voir [Comptes invités](#guests)), disposant d'un compte LinShare.
Chaque utilisateur du groupe de travail voit l'ensemble des fichiers présents.

  - _**Roles**_
    
    La version 2.2 de LinShare introduit un nouveau système de gestion de roles dans les groupes de travail.

    - **Avant LinShare 2.2.x...**


        | Role    | Ouvrir/Télécharger un fichier  | Importer, Renommer fichiers/dossiers | Supprimer fichiers/dossiers          | Voir les membres et leur role      | Mettre à jour le role d'un membre | Supprimer un membre d'un groupe| Mettre à jour/Supprimer un groupe |
        | :-------: |:--------------------------------------| :--------------------------|:-----------------------------| :--------------------------|:------------------| :---------------------| :---------------------|
        | Lecture  | <ul><li> - [x] </li></ul>              | `X`                         |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | Ecriture  | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             |`X`  |
        | Admin   | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |   <ul><li> - [x] </li></ul>   |  <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  |


    - **Ce qui change à partir de LinShare 2.2.x ?**

        Workgroups are managed with 4 different roles:
      
        | Role    | Ouvrir/Télécharger un fichier  | Importer, Renommer fichiers/dossiers | Supprimer fichiers/dossiers          | Voir les membres et leur role      | Mettre à jour le role d'un membre | Supprimer un membre d'un groupe| Mettre à jour/Supprimer un groupe |
        | :-------:    |:--------------------------------------| :--------------------------|:-----------------------------| :--------------------------|:------------------| :---------------------| :---------------------|
        | Lecture       | <ul><li> - [x] </li></ul>              | `X`                         |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | Contribution  | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | Ecriture       | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   | <ul><li> - [x] **Nouveau** </li></ul>   |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | Admin        | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |   <ul><li> - [x] </li></ul>   |  <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  |


  - _**Membres**_

    Une fois un groupe de travail créé (bouton **+** en haut à gauche), il est nécessaire d'ajouter soi-même les membres du groupe.
    Pour celà, plusieurs options sont possibles :

      - Entrer dans le groupe (en cliquant dessus) puis cliquer sur le bouton **+** en haut à gauche puis "Membre".
      - Survoler le groupe avec la souris puis cliquer sur le logo ![User logo](../../img/adduser.png).

    Une barre latérale apparaîtra sur la droite, à partir de là vous pourrez ajouter des membres, en précisant leurs droits d'utilisation : lecture, écriture ou administration (ayant le droit d'ajouter et de supprimer des membres).

  - _**Historique**_

    Dans l'onglet "Activités" de cette barre latérale, on peut voir l'ensemble des actions effectuées dans le groupe de travail (ajout de fichier, partage, suppression de fichier, création de dossier, déplacement de fichier, etc).

  - _**Dossiers**_

    Dans les groupes de travail il est possible de créer une arborescence de dossiers pouvant contenir d'autres dossiers et/ou fichiers.

    Pour ajouter un dossier, il faut cliquer sur le bouton **+** en haut à gauche puis "Dossier".

## 5. Listes de contacts

Pour ajouter une liste de contacts, cliquez sur le bouton **+** en haut à gauche de l'écran.
Cette liste peut être privée ou publique (visible ou pas par les autres utilisateurs du même domaine).
Pour gérer cette liste de contacts, vous pouvez utiliser les boutons qui apparaissent au survol de la liste.

## 6. Comptes invités

Les comptes invités sont les comptes des utilisateurs externes que vous pourrez, une fois ajoutés, ajouter à une liste de contacts, à un groupe de travail, ou encore permettre de partager des fichiers.

## 7. Historique d' activité

Ici vous trouverez l'historique de l'activité de votre compte LinShare. Vous pouvez surveiller les connexions sur LinShare, ou toute autre activité concernant vos partages, vos importations, vos groupes de travail ou encore vos invités.

