# System Settings

  * [Path and Files](#num1)
  * [Databases](#num2)
      * [PostgreSQL](#num21)
      * [MongoDB](#num22)
  * [SMTP Settings](#num3)
  * [SSO](#num4)
  * [ClamAV antivirus ](#num5)
  * [Job scheduler](#num6)
  * [JWT (JSON Web Token)](#num7)
  * [Application startup modes](#num8)
  * [Document storage](#num9)
  * [Thumbnail engine](#num10)
  * [Additional settings](#num11)

System settings can be done in the file `/etc/linshare/linshare.properties`.
>Note:<br/>
Restarting tomcat is required so that linshare-core can take the settings from `/etc/linshare/linshare.properties` into account.

Here are all parameters from the __properties__ file:

## <a name="num1">Path and Files</a>

-   java.io.tmpdir (`/tmp/` by default).
-   log4j.configuration (`file:/etc/linshare/log4j.properties` by default).
-   linshare.config.path (`file:/etc/linshare/` by default).

## <a name="num2">Databases</a>

### <a name="num21">PostgreSQL</a>

-   linshare.db.driver.class : database driver.
    -   `org.postgresql.Driver` PostgreSQL database driver (by default);
    -   `org.h2.Driver` H2 database driver.
-   linshare.db.username : database username: (`linshare` by default).
-   linshare.db.password : database password: (`linshare` by default).
-   linshare.db.url : database host.
    Format : `connector:base://ip|hostname:port/database_name`: (`jdbc:postgresql://localhost:5432/linshare` by default).
-   linshare.db.pool.maxactive : maximum number of active connections (`100` by default).
-   linshare.db.pool.maxidle : maximum number of standby connections (`30` by default).
-   linshare.db.pool.maxwait : maximum number of waiting connections (`10000` by default).
-   linshare.db.pool.timebetweenevictionrunsmillis : delay between two recoveries (`180000` by default).

### <a name="num22">MongoDB</a>

-   linshare.mongo.client.uri : standard URI connection scheme to connect to (`mongodb://linshare:linshare@127.0.0.1:27017/linshare` by default)
-   linshare.mongo.gridfs.smallfiles.client.uri : standard URI connection scheme to connect to store tiny files such as thumbnails, mail attachments... (`mongodb://linshare:linshare@127.0.0.1:27017/linshare-files` by default).
-   linshare.mongo.gridfs.bigfiles.client.uri: store all files in MongoDB GridFS. Not recommended (`mongodb://linshare:linshare@127.0.0.1:27017/linshare-`bigfiles by default).
-   linshare.mongo.connect.timeout (`30000` by default)
-   linshare.mongo.socket.timeout (`30000` by default)
-   linshare.mongo.write.concern:
    -   `MAJORITY`: waits on a majority of servers for the write operation (by default).
    -   `JOURNALED`: Writes operations wait for the server to group commit to the journal file on disk.
    -   `ACKNOWLEDGED`: Writes operations that use this write concern will wait for acknowledgement, using the default write concern configured on the server.

## <a name="num3">SMTP Settings</a>

-   mail.smtp.host : IP address or domain to connect to SMTP service (`smtp.yourdomain.com` by default).
-   mail.smtp.port : port to connect to SMTP service (`25` by default).
-   mail.smtp.auth.needed :
    -   `true` : enable authentication by username/password in order to connect to SMTP service using `mail.smtp.user` and `mail.smtp.password`.
    -   `false` : no authentication is required (by default).
-   mail.smtp.user : username to connect to SMTP service (`user` by default).
-   mail.smtp.password : password to connect to SMTP service (`password` by default).
-   mail.smtp.charset : Charset used for the SMTP service (`UTF-8` by default).
-   mail.smtp.ssl.enable: (`false` by default)
-   mail.smtp.starttls.enable: (`false` by default)

## <a name="num4">SSO</a>

-   sso.header.allowfrom.enable:
    -   `true`: enable IP address filtering of SSO proxies (by default).
    -   `false`: disable IP address filtering of SSO proxies.
-   sso.header.allowfrom : IP address list of SSO proxies that are allowed to inject HTTP headers. Separator is comma (`127.0.0.1` by default).
-   sso.header.user : HTTP header that contains the user id that is authenticated by the SSO service.

> Note:<br />
Concret example would be the creation of several domains invited in LinShare with several URLs. It would be then possible to force each vhost to search for an authenticated user in a specific domain.

## <a name="num5">ClamAV antivirus</a>

-   virusscanner.clamav.host : IP address of the antivirus host (`localhost` by default).
-   virusscanner.clamav.port : Available port to connect to the host machine (`3310` by default).
-   virusscanner.limit.filesize : Any file larger than the defined size (in bytes) will not be scanned by the antivirus (`50000000`  ( 50 Mégabytes by default). by default)

>Note:<br/>
Activation of this feature can be done in the administration menu of LinShare. See [linshare-admin](linshare-admin.md) for more details.

## <a name="num6">Job scheduler</a>

-   job.document.cleaner.activation
    -   `true` enable job that removes old files ;
    -   `false` disable this job (by default).
-   job.document.cleaner.cron.expression: frequency of the job that clears old files (`00011?`, each year by default).
-   job.ldapgroups.cron.expression (`000/4**?`, every 4 hours by default).
-   job.mimetype.cron.expression: frequency of the job that checks and updates file MIME types (`0300**?`, every day at 0:30 by default).
-   job.shares.cron.expression: frequency of the job that clears expired shares (`0300**?`, every day at 0:30 by default).
-   job.shares.undownloaded.notification.cron.expression (`006**?`, every day at 6:00 by default).
-   job.users.cron.expression (`000**?`, every day at midnight by default).
-   job.users.delay.before.purge (`7` by default).

> Warning :<br />
Even if a job that clears expired data and/or expired shares is configured to run, nothing will be remove unless the setting `job.document.cleaner.activation` is not set to `true`.

## <a name="num7">JWT (JSON Web Token)</a>

-   jwt.global.key.private.path: private key location (by default `/etc/linshare/id_rsa`)
-   jwt.global.key.public.path: public location (by default `/etc/linshare/id_rsa.pub`)
-   jwt.issuer: token issuer of LinShare (by default `LinShare`)
-   jwt.expiration: LinShare token expiration time (by default `300`)
-   jwt.token.max.lifetime: maximum accepted token expiration time coming from any external application (by default `300`)

See [linshare-admin](../../EN/administration/how-to-use-jwt.md) for more details.

## <a name="num8">Application startup mode</a>

-   linshare.mode.production :
    -   `true` : in production (by default);
    -   `false` : otherwise: display server errors details on the clients.

## <a name="num9">Document storage</a>

-   linshare.documents.storage.mode
    -   `filesystem`: stores documents on file system for local storage (by default)
    -   `swift-keystone`: stores documents into swift without region support (generic) (maximum file size is 5GB).
    -   `openstack-swift`: stores documents into openstack swift with region support(regionId will be mandatory) (maximum file size is 5GB).
    -   `s3`: stores documents into Amazon S3 (maximum file size is 5GB).

* For local storage (by default)
-   linshare.documents.storage.filesystem: path to the local storage (`directory=/var/lib/linshare/filesystemstorage` by default)

* For online storage:
-   linshare.documents.storage.endpoint: online storage IP address (`http://127.0.0.1:5000/v2.0` by default)
-   linshare.documents.storage.identity: online storage username (`identity` by default)
-   linshare.documents.storage.credential: online storage password (`password` by default)
-   linshare.documents.storage.bucket: online storage bucket (`e0531829-8a75-49f8-bb30-4539574d66c7` by default)

## <a name="num10">Thumbnail engine</a>

-   linshare.documents.thumbnail.enable :
    -   `true`: enable text and image files thumbnail generation
    -   `false`: Otherwise.
-   linshare.documents.thumbnail.pdf.enable :
    -   `true`: enable libreoffice and pdf document thumbnail generation
    -   `false`: Otherwise (by default).
-   linshare.linthumbnail.dropwizard.server (`http://0.0.0.0:8090/linthumbnail?mimeType=%1$s` by default)

## <a name="num11">Additional settings</a>

-   linshare.download.archive.maximum.size (`900000000` by default)
-   linshare.encipherment.tmp.dir (`/var/lib/linshare/tmp` by default)
-   linshare.multidomain.enable (`false` by default)
-   linshare.rest.files.size.validation (`true` by default)
-   linshare.warn.owner.about.guest.expiration.days.before (`7` by default)
-   mail.attchment.limit.size (`393216` by default)
-   spring.profiles.active (`default,jcloud,mongo,batches` by default)
-   uota.cron.expression (`000**?` by default)
