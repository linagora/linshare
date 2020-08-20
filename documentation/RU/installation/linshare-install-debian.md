# Установка LinShare на Debian

   * [Скачать LinShare](#dlLinshare)
   * [Разархивировать и настроить конфигурацию файлов](#instalFile)
   * [Установка OpenJDK Java JRE](#instalOpenJDK)
   * [Установка баз данных (PostgreSQL & mongoDB installation)](#bdd)
     * [Установка PostgreSQL](#postgre)
     * [Установка MongoDB](#mongo)
   * [Активация движка генирации содержимого файлов (опционально)](#thumbnail)
   * [Контейнер сервлета (установка Tomcat 8)](#tomcat)
   * [Веб-сервер (установка Apache 2)](#apache)
     * [Конфигурация vhost для Ui-user](#ui-user)
     * [Конфигурация vhost для Ui-admin](#ui-admin)
   * [Конфигурация и запуск LinShare](#linconf)
   * [Первый запуск](#firstAccess)


### Установка LINSHARE

На этой странице представлена установка __LinShare__ версии 4.0 на *Debian buster 10* (мы не поддерживаем версии Debian старше 8-ой версии).
> Примечание:<br/>
Установка предыдущих поддерживаемых версий __LinShare__ доступна в ветке github :
> - [LinShare 2.3](https://github.com/linagora/linshare/blob/maintenance-2.3.x/documentation/EN/installation/linshare-install-debian.md)
> - [LinShare 2.2](https://github.com/linagora/linshare/blob/maintenance-2.2.x/documentation/EN/installation/linshare-install.md)
> - [LinShare 2.1](https://github.com/linagora/linshare/blob/maintenance-2.1.x/documentation/EN/installation/linshare-install.md)
> - [LinShare 2.0](https://github.com/linagora/linshare/blob/maintenance-2.0.x/documentation/EN/installation/linshare-install.md)


## <a name="dlLinshare">Скачивание __LinShare__</a>

__LinShare__ можно бесплатно и просто скачать по ссылке ниже:

[http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Примечание:<br/>
Вы можете найти все версии LinShare по этой [ссылке](http://download.linshare.org/versions/).
Выберите версию, которая лучше всего подойдет для вас.
Каждая версия LinShare содержит все необходимые компоненты, связанные с конкретной версией LinShare.
Не устанавливайте и не используйте другие версии LinShare после установки приложения.
В противном случае вы рискуете нарушить функциональность вашей изначальной версии LinShare.

> Примечание:<br/>
В этом процессе считается, что файлы загружаются во временную директорию `/tmp/linshare_data`. Конечно, можно использовать другую временную директорию.

Для этой установки скачайте следующие файлы в `/tmp/linshare_data`:
  * linshare-core-{VERSION}.war
  * linshare-core-{VERSION}-sql.tar.bz2
  * linshare-ui-admin-{VERSION}.tar.bz2
  * linshare-ui-user-{VERSION}.tar.bz2

Для управления архивами, вы должны использовать `unzip` и `bzip`:
```bash
apt install unzip bzip2
```

## <a name="instalFile">Разархивировать и настроить кофигурацию файлов.</a>

Создайте репозиторий конфигурации __LinShare__ и вставьте следующие файлы конфигурации:

```bash
mkdir -p /etc/linshare
unzip -j -d /etc/linshare/ /tmp/linshare_data/linshare-core-{VERSION}.war WEB-INF/classes/{linshare,log4j}.*
Archive:  linshare.war
  inflating: /etc/linshare/linshare.properties.sample
  inflating: /etc/linshare/log4j.properties
mv /etc/linshare/linshare.properties.sample /etc/linshare/linshare.properties
```

## <a name="instalOpenJDK">Установка JDK</a>

__LinShare__ требует OpenJDK-11 или Sun/Oracle-JDK 11.
Вы можете установить OpenJDK11 из официальных пакетов Debian:

```bash
apt update
apt install openjdk-11-jdk
```

## <a name="bdd"> Базы данных</a>

**LinShare** использует две СУБД, MongoDB и PostgreSQL.
> Примечание :<br />
Вначале LinShare разрабатывалась с использованием PostgreSQL. Новые функциональные возможности были разработаны с помощью MongoDB. Дорожная карта состоит в том, чтобы перенести все в MongoDB. Задача огромна, поэтому LinShare на данный момент использует обе базы данных.

### <a name="postgre">Установка PostgreSQL</a>

В этом разделе представлена установка PostgreSQL.

Установите PostgreSQL с репозитория:
```bash
apt install postgresql
```
> Поддерживаемые LinShare версии [здесь](./requirements.md)

Запустите PostgreSQL:
```bash
systemctl start postgresql
```

Измените файл доступа к PostgreSQL `/etc/postgresql/11/main/pg_hba.conf`:

```bash
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Примечание:<br/>
    * Эти строки обычно находятся в конце файла.<br/>
    * В целях безопасности postgreSQL работает только локально.

Перезапустите сервер postgreSQL, чтобы применить изменения: <br/>
```bash
systemctl restart postgresql
```

Вы можете сделать это правило первым. PostgreSQL использует первое допустимое правило, которое соответствует запросу проверки подлинности.

Создайте пользователя linshare и базу данных:
> образец пароля **linshare**, используемого для удобства, его необходимо изменить.
```bash
su - postgres
[postgres@localhost ~]$ psql
CREATE ROLE linshare
  ENCRYPTED PASSWORD 'linshare'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

CREATE DATABASE linshare
  WITH OWNER = linshare
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;
GRANT ALL ON DATABASE linshare TO linshare;
\q
```

__Внимание: если ваша база данных установилась на французском, поменяйте все "fr_FR" на "ru_RU".__

Перенесите SQL файлы `createSchema.sql` и `import-postgresql.sql` :

```bash
cd /tmp/linshare_data
tar xjvf linshare-core-*-sql.tar.bz2
psql -h localhost -U linshare -W -d linshare -f linshare-core-sql/postgresql/createSchema.sql
psql -h localhost -U linshare -W -d linshare -f linshare-core-sql/postgresql/import-postgresql.sql
```
Пароль для пользователя linshare: linshare

Измените файл конфигурации LinShare `/etc/linshare/linshare.properties` в соответствии с Вашей потребностью:

```java
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password=linshare
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```
### <a name="mongo">Установка MongoDB</a>

Для установки __LinShare__ вам необходимо установить версию mongoDB - 4.2:

> Поддерживаемые LinShare версии [здесь](./requirements.md)

- Сначала перенесите открытый ключ, используемый системой управления пакетами:

```bash
sudo apt -y install gnupg2
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
```
- Добавьте URL-адрес репозитория в ваш Debian:

```bash
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org.list
```
- Установите пакет mongodb
```bash
sudo apt update
sudo apt -y install mongodb-org
```
При необходимости см. [официальное руководство] (https://docs.mongodb.com/v4.2/tutorial/install-mongodb-on-debian/).

- Выполните следующую команду, чтобы запустить MongoDB:
```bash
sudo systemctl start mongod
```

> В случае ошибок при запуске mongoDB попробуйте:
```bash
chown -R mongodb:mongodb /var/lib/mongodb
chown mongodb:mongodb /tmp/mongodb-27017.sock
```
Затем перезапустите:
```bash
 sudo systemctl restart  mongod.service
```
Теперь сервер MongoDB доступен и готов к использованию.

- Настройка аутентификации MongoDB:
Для включения аутентификации выполните следующие команды

```bash
mongo
```
```bash
> use admin;
```
```bash
> db.createUser(
  {
    user: "linshare",
    pwd: "linshare",
    roles: [
      { role: "readWrite", db: "linshare" },
      { role: "readWrite", db: "linshare-files" } ]
  }
)
```
> образец пароля **linshare** используется для удобства, оно должно быть изменено
- Конфигурация, связанная с LinShare MongoDB

По умолчанию MongoDB конфигурируется со следующей конфигурацией __LinShare__ в файле `/etc/linshare/linshare.properties`, просто измените его следующим образом :

```java
#### Mongo storage options ####

linshare.mongo.connect.timeout=30000
linshare.mongo.socket.timeout=30000

#### Write concern
# MAJORITY: waits on a majority of servers for the write operation.
# JOURNALED: Write operations wait for the server to group commit to the journal file on disk.
# ACKNOWLEDGED: Write operations that use this write concern will wait for acknowledgement,
#	 			using the default write concern configured on the server.
linshare.mongo.write.concern=MAJORITY

#### connection for data
# replicaset: host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
linshare.mongo.data.replicaset=127.0.0.1:27017
linshare.mongo.data.database=linshare
# linshare.mongo.data.credentials=[user:password[@database]]
linshare.mongo.data.credentials=linshare:linshare@admin

#### connection for small files
# Using MongoDb to store very small files (thumbnails, mail attachments, ...)
linshare.mongo.smallfiles.replicaset=127.0.0.1:27017
linshare.mongo.smallfiles.database=linshare-files
linshare.mongo.smallfiles.credentials=linshare:linshare@admin


#### The connection for bigfiles is used just if the `gridfs` spring profile is enabled.
# Store all files in MongoDB GridFS. Not recommended.
linshare.mongo.bigfiles.replicaset=127.0.0.1:27017
linshare.mongo.bigfiles.database=linshare-bigfiles
linshare.mongo.bigfiles.credentials=linshare:linshare@admin

######## Storage options - end ########
```

Для получения более подробной информации о mongo dataBases, используемых в LinShare, Вы можете прочитать это: [документация](https://github.com/linagora/linshare/blob/master/documentation/EN/administration/configuration-administration.md#mongodb)


## <a name="thumbnail">Thumbnail Engine (опционально)</a>


LinShare имеет механизм генерации предварительного просмотра для широкого спектра файлов:

 - OpenDocument format (ODT, ODP, ODS, ODG)
 - Microsoft documents format (DOCX, DOC, PPTX, PPT, XLSX, XLS )
 - PDF documents
 - Images files (PNG, JPEG, JPG, GIF)
 - Text files (TXT, XML, LOG, HTML ...)

> Примечание:<br/>
    *  Перед использованием этого движка на вашем компьютере должен быть установлен LibreOffice или OpenOffice, минимальная версия libreOffice: 4.2.8.

Установка LibreOffice:

```bash
apt update
apt install libreoffice
```

По умолчанию для движка thumbnail установлено значение `FALSE`. Чтобы включить его, вы должны изменить файл конфигурации __LinShare__ `/etc/linshare/linshare.properties`:

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Это позволит создавать превью документов после каждой загрузки файла.

Теперь перейдите по ссылке [http://download.linshare.org/versions/](http://download.linshare.org/versions/) и скачайте следующие файлы:

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Примечание:<br/>
В этом процессе считается, что файлы загружаются во временную директорию `/tmp/linshare_data`. Конечно, можно использовать другую временную директорию.

> Примечание<br>
По умолчанию сервер имеет порт 80. Его можно изменить, если необходимо.

Скопируйте файл конфигурации `linshare-thumbnail-server-{VERSION}.yml` в `/etc/linshare/linshare-thumbnail-server.yml` и скопируйте java архив `linshare-thumbnail-server-{VERSION}.jar` в эту директорию `/usr/local/sbin/linshare-thumbnail-server.jar`, используйте следующие команды для этого:
```java
mv /tmp/linshare_data/linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
mv /tmp/linshare_data/linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

Вы можете автоматизировать запуск сервера, создав `systemd` сервис. Создайте файл `/lib/systemd/system/linshare-thumbnail-server.service`, со следующим содержанием:

```bash
[Unit]
Description=LinShare thumbnail server
After=network.target

[Service]
Type=idle
KillMode=process
ExecStart=/usr/bin/java -jar /usr/local/sbin/linshare-thumbnail-server.jar server /etc/linshare/linshare-thumbnail-server.yml

[Install]
WantedBy=multi-user.target
Alias=linshare-thumbnail-server.service
```

Теперь вы должны активировать сервис, он будет автоматически запущен после перезагрузки. Используйте вторую команду для запуска сервиса:

```bash
systemctl daemon-reload
systemctl enable linshare-thumbnail-server.service
systemctl start linshare-thumbnail-server.service
```

## <a name="tomcat">Установка Tomcat</a>

__LinShare__ является Java приложением, скомпилированным и построенным под формат «WAR»  (**W**eb **A**pplication a**R**chive), поэтому оно нуждается в контейнере сервлета Java (Tomcat или Jetty).

В этом разделе представлена установка сервера Tomcat.

Установите tomcat с репозитория:
```bash
sudo apt install -y tomcat9
```

Чтобы указать местоположение конфигурции __LinShare__  (файл _linshare.properties_), а также начальные параметры, предусмотренные по умолчанию, найдите отмеченные параметры в первых строках файла `linshare.properties` и скопируйте их в файл Tomcat (`/etc/default/tomcat9`):

Все начальные необходимые параметры по умолчанию для Linshare указаны в заголовке следующих файлов конфигурации:

  * `/etc/linshare/linshare.properties`
  * `/etc/linshare/log4j.properties`

Необходимо добавить следующие строки в файл `/etc/default/tomcat9`:

```conf
JAVA_OPTS="${JAVA_OPTS} -Xms512m -Xmx2048m"
JAVA_OPTS="${JAVA_OPTS} -Dlinshare.config.path=file:/etc/linshare/"
JAVA_OPTS="${JAVA_OPTS} -Dlog4j.configuration=file:/etc/linshare/log4j.properties"
```
Если вы хотите изменить расположение директории tmp, вам нужно переопределить директорию по умолчанию, используемую Tomcat9, которая `/tmp`, отредактировав `/etc/default/tomcat9` и добавить:

```conf
CATALINA_TMPDIR=/your/path/tmp
```
> Примечание :<br/>
Если вы столкнулись с ошибкой при переопределении вашего нового пути к каталогу `tmp`, это может быть связано с отсутствием у Tomcat разрешения на запись в вашем новом каталоге.
Вы можете проверить [этот раздел](https://github.com/linagora/linshare/blob/master/documentation/EN/installation/linshare-install-debian.md#linshare-configuration-and-launching).

#### профили
LinShare предоставляет различные профили, которые позволяют условно настроить приложение (другой способ хранения, аутентификация ...).
##### Доступные профили:

Доступные профили аутентификации :
* **default**: процесс аутентификации по умолчанию.
* **sso** : Включить инъекцию заголовков для SSO.

> **NB** Вы должны включить по крайней мере один профиль аутентификации среди профилей аутентификации.

Доступные профили файловых хранилищ данных :
* **jcloud** : Использование jcloud в качестве хранилища файловых данных: Amazon S3, Swift, Ceph, файловая система.
* **gridfs** : Использование gridfs (mongodb) в качестве хранилища файловых данных.
Рекомендуемый профиль для производства - jcloud.

> LinShare использует профиль `jcould` в качестве хранилища данных файловой системы по умолчанию.

Дополнительные профили :
* **batches** : если этот профиль включен, то он включит все задания Quartz (cron tasks).

##### Дополнительная конфигурация:
В файле tomcat `/var/lib/tomcat9/conf/catalina.properties` есть ключ с именем `tomcat.util.scan.DefaultJarScanner.jarsToSkip`.

Добавьте `jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\` где-нибудь в разделе этого ключа.

Установите архив __LinShare__ приложений на сервер Tomcat:
```bash
mv /tmp/linshare_data/linshare.{VERSION}.war /var/lib/tomcat9/webapps/linshare.war
```

## <a name="apache">Веб-сервер</a>

Интерфейс администратора __LinShare__ является приложением основанным на HTML/CSS и JavaScript.
Для этого нужен простой веб-сервер, например Apache или Nginx.

В этом разделе представлена установка HTTP-сервера Apache.

Установите Apache 2 с репозитория:
```bash
apt install -y apache2
```

### Конфигурация Vhost



### <a name="ui-user">ui-user</a>

Чтобы развернуть приложение __LinShare__, необходимо активировать __mod_proxy__ на Apache 2.

Создайте поддиректории в папке `/var/www/`, обратите внимание, что имя репозитория будет именем домена приложения. Назначьте пользователю права доступа к поддиректориям.

```bash
cd /var/www/
tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
chown -R www-data: linshare-ui-user
```

Также вы должны добавить конфигурацию, указанную ниже, в файл по умолчанию предоставленный debian:
```bash
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/linshare-ui-user.conf
sudo a2dissite 000-default.conf
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite linshare-ui-user.conf
sudo a2enmod proxy proxy_http
```

Для развертывания приложения __LinShare__ необходимо создать конфигурационный файл virtualhost. Добавьте файл `/etc/apache2/sites-available/linshare-ui-user.conf` со следующим содержимым:

```xml
<VirtualHost *:80>
ServerName linshare-user.local
DocumentRoot /var/www/linshare-ui-user
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-user-error.log
CustomLog /var/log/apache2/linshare-user-access.log combined
</Virtualhost>
```
### <a name="ui-admin">ui-admin</a>

Разверните архив приложения __LinShare__ UI Admin в репозитории Apache 2:

```bash
cd /var/www/
tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
chown -R www-data: linshare-ui-admin
```

Также вы должны добавить конфигурацию, указанную ниже, в файл по умолчанию предоставленный debian:

```bash
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/linshare-ui-admin.conf
sudo a2dissite default
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite linshare-admin.conf
sudo a2enmod proxy proxy_http headers
```

Для развертывания интерфейса администрирования __LinShare__ необходимо создать конфигурационный файл virtualhost. Измените файл `/etc/apache2/sites-available/linshare-ui-admin.conf` следующим содержанием:

```xml
<VirtualHost *:80>
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #Cette entête est rajoutée pour éviter à IE de faire du cache sur le JSON
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
</Virtualhost>
```

> Примечание :<br/>
Примеры vhost находятся в следующем репозитории : [utils/apache2/vhosts-sample/](.../.../.../utils/apache2/vhosts-sample/linshare-admin.conf)


Перезапустите сервис Apache 2:
```bash
systemctl restart apache2
```

### <a name="linconf">Конфигурация и запуск LinShare</a>

Настройте место хранения файлов в конфигурационном файле __LinShare__ `/etc/linshare/linshare.properties` :

```java
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

В этой конфигурации необходимо создать папку с правильными разрешениями:
```bash
mkdir -p /var/lib/linshare
chown -R tomcat:tomcat /var/lib/linshare
```

Настройте доступ к службе SMTP так, чтобы __LinShare__ мог отправлять уведомления о сообщениях в файле конфигурации __LinShare__ `/etc/linshare/linshare.properties`:

```java
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

В __LinShare__ у вас есть два возможных режима аутентификации: первый - это номинальный режим, а второй - режим sso. Чтобы запустить LinShare, вы должны включить хотя бы один из следующих двух режимов:

* default: процесс аутентификации по умолчанию.
* sso : Активировать вставку заголовков для SSO. Этот профиль включает функции профиля по умолчанию.

Профиль по умолчанию jcloud является файловой системой для тестирования.

Вы можете отменить этот параметр, используя `-Dspring.profiles.active=xxx`
Или вы можете использовать переменную среды: `SPRING_PROFILES_ACTIVE`.

Вы должны включить по крайней мере один профиль проверки подлинности среди профилей проверки и один профиль из профилей хранилища файлов данных, описанных ниже.

Доступные профили хранилища данных файла:
* jcloud: Использование jcloud в качестве хранилища файловых данных: Amazon S3, Swift, Ceph, файловая система.
* gridfs: Использование gridfs (mongodb) в качестве хранилища файловых данных.

> Примечание:<br>
Рекомендуемый профиль для производства - jcloud с Swift.

Tomcat9 находится в песочнице для записи только в свои собственные директории, если вы попытаетесь использовать локальное хранилище Файловой Системы, вам нужно переопределить стандартную конфигурацию Tomcat, создав в `/etc/systemd/system/tomcat9.service.d/` файл с именем `override.conf`, со следующим содержанием:

```
    [Service]
    ReadWritePaths=/var/lib/linshare
```
Тогда вам нужно:
```
systemctl daemon-reload
systemctl restart tomcat9
```

Для __запуска LinShare__ включите сервис tomcat:
```bash
systemctl start tomcat9
```

Чтобы проверить работоспособность __LinShare__, просмотрите файл __logs__:
```bash
tail -f /var/log/tomcat9/catalina.out
```

Если сервис запустился правильно, у вас должны быть следующие сообщения:

```
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Затем перезапустите сервис Apache 2:

```
service apache2 restart
```

### <a name="firstAccess">Первый доступ</a>

> Примечание: <br>
Перед первым обращением к __LinShare__ необходимо добавить `linshare-user.local` и `linshare-admin.local` в `/etc/hosts`.

Теперь __LinShare сервис__ доступен по следующей ссылке:

Пользовательский интерфейс:
  * http://linshare-user.local/linshare
![linshare-user-000002010000047E01400157A9D6C9G6](../../img/linshare-user-000002010000047E01400157A9D6C9G6.png)

> Примечание:<br/>
   Этот URL-адрес также должен быть задан в параметрах вашего домена. Для этого перейдите к функциям __domain__ и
   введите его в поле параметров __notifcation url__

Для интерфейса администратора:

  *  http://linshare-admin.local/

Ниже приведены учетные данные системного администратора по умолчанию:
  * Логин: root@localhost.localdomain
  * Пароль: __adminlinshare__

Пожалуйста, измените пароль в интерфейсе администрирования.

> Примечание :<br/>
Невозможно добавить других пользователей стандарта LinShare локально без LDAP. Смотрите специальную страницу для конфигурации LDAP в [параметры приложения](../администрация/linshare-admin.md).

![linshare-admin-000002010000047E01400157A9D6C9G6](../../img/linshare-admin-000002010000047E01400157A9D6C9G6.png)

