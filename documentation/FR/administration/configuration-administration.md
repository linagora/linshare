# Paramétrage système

> Note :<br />
Cette section est basée sur le contenu du document __Linagora_DOC_LinShare-1.7.0_Guide-Config-Admin_fr_20150303.odt__ (version **1.0** du **03/03/2015**). Ce document a été remplacé par cette page courante. Cette courante page est la version la plus actuelle.

  * [Chemins et Fichiers](#num1)
  * [Bases de Données](#num2)
      * [PostgreSQL](#num21)
      * [MongoDB](#num22)
  * [Accès au serveur SMTP](#num3)
  * [SSO](#num4)
  * [Antivirus ClamAV](#num5)
  * [Ordonnanceur de tâches](#num6)
  * [JWT (JSON Web Token)](#num7)
  * [Mode de lancement de l’application web](#num8)
  * [Stockage des documents](#num9)
  * [Moteur d'aperçu](#num10)
  * [Configuration supplémentaire](#num11)

Le paramétrage du système s'effectue dans le fichier `/etc/linshare/linshare.properties`.
>Note :<br />
La prise en compte des paramètres présents dans les fichiers `/etc/linshare/linshare.properties` ne s'effectue que lors du démarrage du conteneur de servlets tomcat.

Voici une liste des clés de paramétrage présentes dans les fichiers __properties__ et classées selon les sujets sur lesquels elles portent.

## <a name="num1">Chemins et Fichiers</a>

-   java.io.tmpdir (par défaut `/tmp/`).
-   log4j.configuration (par défaut `file:/etc/linshare/log4j.properties`).
-   linshare.config.path (par défaut `file:/etc/linshare/`).

## <a name="num2">Bases de Données</a>

### <a name="num21">PostgreSQL</a>

-   linshare.db.driver.class : Le pilote *(driver)* correspondant à la base de données choisie.
    -   `org.postgresql.Driver` pour une base PostgreSQL (par défaut);
    -   `org.h2.Driver` pour une base H2.
-   linshare.db.username : Identifiant du compte pour se connecter à la base de données: (`linshare` par défaut).
-   linshare.db.password : Mot de passe du compte pour se connecter à la base de données: (`linshare` par défaut).
-   linshare.db.url : L’adresse de la base de données.
    Format : `connector:base://ip|hostname:port/nom_de_la_base_de_données`: (`jdbc:postgresql://localhost:5432/linshare` par défaut).
-   linshare.db.pool.maxactive : Nombre maximum de connexions actives sur la base de données (`100` par défaut).
-   linshare.db.pool.maxidle : Nombre maximum de connexions en standby sur la base de données (`30` par défaut).
-   linshare.db.pool.maxwait : Nombre maximum de connexions en attente sur la base de données (`10000` par défaut).
-   linshare.db.pool.timebetweenevictionrunsmillis : Durée entre deux récupération sur la base de données (`180000` par défaut).

### <a name="num22">MongoDB</a>

-   linshare.mongo.client.uri : schéma d'URI de connexion standard pour la connexion à la base de données (`mongodb://linshare:linshare@127.0.0.1:27017/linshare` par défaut)
-   linshare.mongo.gridfs.smallfiles.client.uri : schéma d'URI de connexion standard pour stocker des fichiers légers: miniatures, pièces jointes... (`mongodb://linshare:linshare@127.0.0.1:27017/linshare-files` par défaut).
-   linshare.mongo.gridfs.bigfiles.client.uri: stockage de tous les fichiers en utilisant MongoDB GridFS. Non recommandé (`mongodb://linshare:linshare@127.0.0.1:27017/linshare-`bigfiles par défaut).
-   linshare.mongo.connect.timeout (`30000` par défaut)
-   linshare.mongo.socket.timeout (`30000` par défaut)
-   linshare.mongo.write.concern:
    -   `MAJORITY`: attendre la disponibilité de la majorité des serveurs pour écrire (par défaut).
    -   `JOURNALED`: les opérations d'écriture attendent le serveur pour grouper les commits dans le journal sur le disque.
    -   `ACKNOWLEDGED`: les opérations d'écriture qui utilisent ce context d'écriture attendront une confirmation en utilisant le contexte d'écriture configuré sur le serveur.

## <a name="num3">Accès au serveur SMTP</a>

-   mail.smtp.host : FQDN ou adresse IP du fournisseur du service de messagerie (`smtp.yourdomain.com` par défaut).
-   mail.smtp.port : Port de connexion utilisé par le service de messagerie (`25` par défaut).
-   mail.smtp.auth.needed :
    -   `true` : active l’authentification par identifiant/mot de passe pour se connecter au service SMTP en utilisant le paramétrage des deux clés suivantes : `mail.smtp.user` et `mail.smtp.password`.
    -   `false` : aucune authentification n’est requise (par défaut).
-   mail.smtp.user : Identifiant du compte pour se connecter au service SMTP (`user` par défaut).
-   mail.smtp.password : Mot de passe du compte pour se connecter au service SMTP (`password` par défaut).
-   mail.smtp.charset : Codage utilisé par le service SMTP (`UTF-8` par défaut).
-   mail.smtp.ssl.enable : (`false` par défaut)
-   mail.smtp.starttls.enable : (`false` par défaut)

## <a name="num4">SSO</a>

-   sso.header.allowfrom.enable: 
    -   `true` : active le filtrage d'adresses IP des proxies SSO (par défaut).
    -   `false` : désactive le filtrage d'adresses IP des proxies SSO.
-   sso.header.allowfrom : Liste d'adresses IP des proxies SSO, donc les seules IP autorisées à injecter des en-têtes HTTP. Le séparateur est la virgule (`127.0.0.1` par défaut).
-   sso.header.user : En-tête HTTP contenant l’identifiant de l’utilisateur authentifié par le service de SSO. Généralement, il s’agit de l’adresse de courriel de l’utilisateur (`Auth-User` par défaut).

> Note :<br />
Un cas d'exemple concret serait la création de plusieurs domaines invités dans linshare avec des urls différentes. Il serait alors possible de forcer chaque vhost à rechercher l’utilisateur authentifié dans un domaine particulier.

## <a name="num5">Antivirus ClamAV</a>

-   virusscanner.clamav.host : Adresse de la machine hôte de l’antivirus (`localhost` par défaut).
-   virusscanner.clamav.port : Port disponible pour se connecter à la machine hôte (`3310` par défaut).
-   virusscanner.limit.filesize : Tout fichier supérieur à la taille définie (en octets) ne sera pas scanné par l'antivirus (`50000000`  (par défaut  50 Mégaoctets par défaut).)

>Note :<br />
L’activation de cette fonctionnalité se fait dans le menu d’administration de LinShare. Voir [linshare-admin](linshare-admin.md) pour plus de détails.

## <a name="num6">Ordonnanceur de tâches</a>

-   job.document.cleaner.activation
    -   `true` activer la suppression des anciens fichiers ;
    -   `false` désactiver la tâche (par défaut).
-   job.document.cleaner.cron.expression : Périodicité de la tâche de suppression des anciens fichiers (par défaut `00011?`, soit tous les ans).
-   job.ldapgroups.cron.expression (par défaut `000/4**?`, soit toutes les 4 heures).
-   job.mimetype.cron.expression : Périodicité de la tâche de vérification et mise à jour des types MIME des fichiers (par défaut `0300**?`, soit tous les jours à 0h30).
-   job.shares.cron.expression : Périodicité de la tâche de suppression des partages expirés (par défaut `0300**?`, soit tous les jours à 0h30).
-   job.shares.undownloaded.notification.cron.expression (par défaut `006**?`, soit tous les jours à 6h).
-   job.users.cron.expression (par défaut `000**?`, soit tous les jours à minuit).
-   job.users.delay.before.purge (par défaut `7`).

> Attention :<br />
Par mesure de sécurité, même si une tâche de suppression d'anciens fichiers et/ou d'anciens partages est configurée pour s'exécuter, rien ne sera supprimé tant que le paramètre `job.document.cleaner.activation` n'est pas activé (`true`).

## <a name="num7">JWT (JSON Web Token)</a>

-   jwt.global.key.private.path : emplacement de la clé privée (par défaut `/etc/linshare/id_rsa`)
-   jwt.global.key.public.path : emplacement de la clé publique (par défaut `/etc/linshare/id_rsa.pub`)
-   jwt.issuer : nom de l'émetteur de jeton JSON de LinShare(par défaut `LinShare`)
-   jwt.expiration : durée de vie du jeton JSON généré par LinShare (par défaut `300`)
-   jwt.token.max.lifetime : durée de vie maximum de jeton JSON provenant d'une application externe accepté par LniShare (par défaut `300`)

Voir [linshare-admin](../../EN/administration/how-to-use-jwt.md) [`EN`] pour plus de détails.

## <a name="num8">Mode de lancement de l’application web</a>

-   linshare.mode.production :
    -   `true` : en production (par défaut);
    -   `false` : sinon : affiche les erreurs serveur sur les clients.

## <a name="num9">Stockage des documents</a>

-   linshare.documents.storage.mode
    -   `filesystem`: stockage des fichiers local (par défaut)
    -   `swift-keystone`: stockage des documents sur swift sans support régional (generic) (taille de fichier maximum 5 Go).
    -   `openstack-swift`: stockage des documents sur openstack avec ID régional requis (taille de fichier maximum 5 Go).
    -   `s3`: stockage des documents sur Amazon S3 (taille de fichier maximum 5 Go).

* Stockage local (par défaut)
-   linshare.documents.storage.filesystem: chemin vers le stockage local (`directory=/var/lib/linshare/filesystemstorage` par défaut)

* Stockage en ligne:
-   linshare.documents.storage.endpoint: adresse du stockage en ligne (`http://127.0.0.1:5000/v2.0` par défaut)
-   linshare.documents.storage.identity: nom d'utilisateur (`identity` par défaut)
-   linshare.documents.storage.credential: mot de passe (`password` par défaut)
-   linshare.documents.storage.bucket: bucket (`e0531829-8a75-49f8-bb30-4539574d66c7` par défaut)

## <a name="num10">Moteur d'aperçu</a>

-   linshare.documents.thumbnail.enable :
    -   `true` : Active la génération des aperçus des fichiers texte et image (par défaut);
    -   `false` : Sinon.
-   linshare.documents.thumbnail.pdf.enable :
    -   `true` : Active la génération des aperçus des fichiers exploitant le moteur libreoffice : tout document libreoffice, tout document pdf
    -   `false` : Sinon (par défaut).
-   linshare.linthumbnail.dropwizard.server (par défaut `http://0.0.0.0:8090/linthumbnail?mimeType=%1$s`)

## <a name="num11">Configuration supplémentaire</a>

-   linshare.download.archive.maximum.size (par défaut `900000000`)
-   linshare.encipherment.tmp.dir (par défaut `/var/lib/linshare/tmp`)
-   linshare.multidomain.enable (par défaut `false`)
-   linshare.rest.files.size.validation (par défaut `true`)
-   linshare.warn.owner.about.guest.expiration.days.before (par défaut `7`)
-   mail.attchment.limit.size (par défaut `393216`)
-   uota.cron.expression (par défaut `000**?`)
