## Оглавление

### Установка LinShare

#### 1. [Минимальная установка LinShare](#installmin)
   * [Скачать LinShare](#dlLinshare)
   * [Разархивировать и настроить конфигурацию файлов](#instalFile)
   * [Установка OpenJDK Java JRE](#instalOpenJDK)
   * [База данных (PostgreSQL & mongoDB installation)](#bdd)
   * [Активация движка генирации содержимого файлов (необязательно)](#thumbnail)
   * [Контейнер сервлета (установка Tomcat 8)](#tomcat)
   * [Веб-сервер (установка Apache 2)](#apache)
     1. [Конфигурация vhost для Ui-user](#ui-user)
     2. [Конфигурация vhost для Ui-admin](#ui-admin)
   * [Конфигурация и запуск LinShare](#linconf)
   * [Первый запуск](#firstAccess)


### Установка LINSHARE

> Примечание:<br/>
Это инструкция для установки 2.х LinShare версии на 8 Jessie (мы не поддерживаем других дистрибутивов Debian).
Установка предыдущей версии LinShare доступна в
ветке github : [LinShare 1.12.x](../../../../maintenance-1.12.x/documentation/EN/installation/linshare-install-debian.md)

<a name="installmin">

### Минимальная установка __Linshare__

</a>

<a name="dlLinshare">

### Скачивание __LinShare__

</a>

__LinShare__ можно бесплатно и просто скачать по ссылке ниже:

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Примечание:<br/>
Вы можете найти все версии LinShare по этой [ссылке](http://download.linshare.org/versions/).
Выберите версию, которая лучше всего подойдет для вас.
Каждая версия LinShare содержит все необходимые компоненты, связанные с конкретной версией LinShare.
Не устанавливайте и не используйте другие версии LinShare после установки приложения.
В противном случае вы рискуете нарушить функциональность вашей изначальной версии LinShare.


Для этой установки скачайте следующие файлы:

  * __linshare-core-{VERSION}.war__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

  * __linshare-ui-user-{VERSION}.tar.bz2__

Версия может отличаться для каждого компонента.

<a name="instalFile">

### Разархивировать и настроить кофигурацию файлов.

</a>

Для управления архивами, вы должны использовать Unzip и Bzip:

`[root@localhost ~]$ aptitude install unzip bzip2`

Создайте репозиторий конфигурации __LinShare__ и вставьте следующие файлы конфигурации:

```
[root@localhost ~]$ mv linshare-core-{VERSION}.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

### Исполнительная среда JAVA (JVM)

__LinShare__ работает с OpenJDK и Sun / Oracle Java 8. Этот раздел посвящен OpenJDK Java 8.

<a name="instalOpenJDK">

#### Установка OpenDK

</a>

Установите Java Runtime Environment (JRE) от OpenJDK с репозиториев:

> Примечание:<br/>
   * Если вы используете debian jessie, вам может потребоваться добавить jessie backport в файл source.list.<br/>
   Чтобы это сделать, следуйте следующим инструкциям:
   `[root@localhost ~]$ vim /etc/apt/sources.list` и добавьте эту строку: `deb http://ftp.debian.org/debian jessie-backports main`. Затем сделайте: `aptitude  update; aptitude -t jessie-backports install your_package`.

```
[root@localhost ~]$ aptitude install openjdk-8-jre
[root@localhost ~]$ update-alternatives --config java
```

> Примечание:<br/>
    * Вы можете проигноривовать возможные ошибки, вызванные плагином Java.

<a name="bdd">

### Базы данных

</a>

LinShare необходимо использовать базу данных (PostgreSQL) для своих файлов и конфигурации.

MySQL больше не поддерживается в LinShare v2.

В этом разделе представлена установка с PostgreSQL.

Установите PostgreSQL с репозитория:

`[root@localhost ~]$ aptitude install postgresql`

Запустите PostgreSQL:

`[root@localhost ~]$ service postgresql start`

#### Создание безопасного доступа

Измените файл доступа к PostgreSQL:

```
[root@localhost ~]$ vim /etc/postgresql/<VERSION>/main/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Примечание:<br/>
    * Эти строки обычно находятся в конце файла.<br/>
    * В целях безопасности postgreSQL работает только локально.<br/>
    * ерезапустите / перезагрузите сервер postgreSQL, чтобы применить изменения: <br/>
    `[root@localhost ~]$ service postgresql restart/reload`

Вы можете сделать это правило первым. PostgreSQL использует первое допустимое правило, которое соответствует запросу проверки подлинности.

Создайте пользователя "linshare" (пароль {PASSWORD}) :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

CREATE ROLE linshare
  ENCRYPTED PASSWORD '{PASSWORD}'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

\q
```

Команды: чтобы выйти, напишите "\q" ; чтобы посмотреть помощь по PSQL, напишите "\?".

Создайте и импортируйте схему базы данных:

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

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

> Примечание:<br/>
     * При необходимости вы можете обратиться к скрипту с именем createDatabase.sql в src/main/resources/sql/postgresql/, который даст вам команду ввода для создания ваших баз данных.

Перенесите SQL файлы "createSchema.sql" и "import-postgresql.sql" :

```
[root@localhost ~]$ tar xjvf linshare-core-*-sql.tar.bz2
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/createSchema.sql
Password for user linshare: {PASSWORD}
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/import-postgresql.sql
Password for user linshare: {PASSWORD}
```

Измените файл конфигурации LinShare's:

```
[root@localhost ~]$ vi /etc/linshare/linshare.properties
#******************** DATABASE
### PostgreSQL
linshare.db.username=linshare
linshare.db.password={PASSWORD}
linshare.db.driver.class=org.postgresql.Driver
linshare.db.url=jdbc:postgresql://localhost:5432/linshare
linshare.db.dialect=org.hibernate.dialect.PostgreSQLDialect
```

Для установки LinShare V2 вам необходимо установить специальную версию mongoDB - 3,2:

Сначала перенесите открытый ключ, используемый системой управления пакетами:

```
[root@localhost ~]$ apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
```
Создать файл списка:

```
[root@localhost ~]$ echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
```

После этого вам необходимо перезагрузить локальную базу данных пакетов:

```
[root@localhost ~]$ apt-get update
```
И установить последнюю стабильную версию MongoDB:

```
[root@localhost ~]$ apt-get install -y mongodb-org
```

Перед запуском MongoDB убедитесь, что файл /etc/mongod.conf имеет ip-адрес привязки: 127.0.0.1

Выполните следующую команду, чтобы запустить mongod:

```
[root@localhost ~]$ service mongod start
```

<a name="thumbnail">
#### Включить новый движок (опционально)
</a>

LinShare имеет механизм генерации предварительного просмотра для широкого спектра файлов:

 - OpenDocument format (ODT, ODP, ODS, ODG)
 - Microsoft documents format (DOCX, DOC, PPTX, PPT, XLSX, XLS )
 - PDF documents
 - Images files (PNG, JPEG, JPG, GIF)
 - Text files (TXT, XML, LOG, HTML ...)

> Примечание:<br/>
    *  Перед использованием этого движка на вашем компьютере должен быть установлен LibreOffice или OpenOffice, минимальная версия libreOffice: 4.2.8.

Установка LibreOffice:

aptitude update
aptitude install libreoffice

По умолчанию для движка thumbnail установлено значение FALSE. Чтобы включить его, вы должны изменить файл конфигурации LinShare:

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=false
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Это позволит создавать превью документов после каждой загрузки файла.

У вас также есть возможность использовать этот движок удаленно. Для этого вы должны сначала активировать удаленный режим:

```java
#******** LinThumbnail configuration
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Теперь перейдите по ссылке `http://download.linshare.org/versions/` и скачайте следующие файлы:

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Примечание<br>
По умолчанию сервер имеет порт 80. Его можно изменить, если необходимо.

Скопируйте файл конфигурации `linshare-thumbnail-server-{VERSION}.yml` в `/etc/linshare/linshare-thumbnail-server.yml` и скопируйте java архив `linshare-thumbnail-server-{VERSION}.jar` в эту директорию `/usr/local/sbin/linshare-thumbnail-server.jar`, используйте следующие команды для этого:

```java
cp linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
```
```java
cp linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

* Вы можете автоматизировать запуск сервера, создав сервис `systemd` в каталоге `/ etc / systemd / system` со следующим именем `linshare-thumbnail-server.service`.

Измените файл linshare-thumbnail-server.service` и скопируйте приведенный ниже код:

```java
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
Теперь вы должны активировать сервис, он будет автоматически запущен после перезагрузки:

`systemctl enable linshare-thumbnail-server.service`

Используйте эту команду для запуска сервиса:

`systemctl start linshare-thumbnail-server.service`

<a name="tomcat">

#### Контейнер servlet

</a>

LinShare является Java приложением, скомпилированным и построенным под формат «WAR»  (Web Application a*R*chive), поэтому оно нуждается в контейнере сервлета Java (Tomcat или Jetty).

В этом разделе представлена установка сервера Tomcat.

#### Установка Tomcat 8

Установите tomcat с репозитория:

`[root@localhost ~]$ aptitude install tomcat8`

#### Дополнительные параметры

У вас есть ключ конфигурации "tomcat.util.scan.StandardJarScanFilter.jarsToSkip" в файле /var/lib/tomcat8/conf/catalina.properties, добавьте в него среднюю строку:

```
jetty-*.jar,oro-*.jar,servlet-api-*.jar,tagsoup-*.jar,xmlParserAPIs-*.jar,\
jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\
xom-*.jar
```
#### Конфигурация Tomcat 8

Чтобы указать местоположение LinShare __configuration__ (файл _linshare.properties_), а также начальные параметры, предусмотренные по умолчанию, найдите отмеченные параметры в первых строках файла __linshare.properties__ и скопируйте их в файл Tomcat (/etc/sysconfig/tomcat8):

Все начальные необходимые параметры по умолчанию для Linshare указаны в заголовке следующих файлов конфигурации:

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__

#### Разархивация

Разверните архив приложения Linshare на сервере tomcat:

```
[root@localhost ~]$ cp linshare.war /var/lib/tomcat8/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat8:tomcat8 /var/lib/linshare
```

<a name="apache">

#### Веб-сервер

</a>

Интерфейс администратора __LinShare__ является приложением основанным на HTML/CSS и JavaScript.
Для этого нужен простой веб-сервер, например Apache или Nginx.

В этом разделе представлена установка HTTP-сервера Apache.

#### Установка Apache 2

Установите Apache 2 с репозитория:

```
[root@localhost ~]$ aptitude install apache2
```

##### Конфигурация Vhost

<a name="ui-user">

#### ui-user

</a>

Чтобы развернуть приложение LinShare, необходимо активировать __mod_proxy__ на Apache 2. Также вы
должны добавить конфигурацию, указанную ниже, в файл по умолчанию предоставленный debian:

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-user.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-user.conf
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2enmod proxy proxy_http
[root@localhost ~]$ vim linshare-user.conf
```

```
<VirtualHost *:80>
...
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
...
</Virtualhost>
```

> Примечание:<br/>
   * После всех изменений vhost вы должны перезагрузить сервис Apache 2:<br/>
   `[root@localhost ~]$ service apache2 reload` <br/>
   * В последних версиях Apache файл по умолчанию можно назвать default.conf.<br/>
   * Если вы создаете корень документа, у вас есть возможность создать настраиваемый подпозиторий, в котором вы можете добавить свой логотип:<br/>
   `[root@localhost ~]$ mkdir -p linshare/custom`

<a name="ui-admin">

#### ui-admin

</a>

Разверните архив приложения __LinShare UI Admin__ в репозитории Apache 2:

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ mv linshare-ui-admin-{VERSION} /var/www/linshare-ui-admin
```

Чтобы развернуть интерфейс администрирования __LinShare__, необходимо активировать __mod_proxy__ на Apache 2. Также вы должны добавить конфигурацию, указанную ниже, в файл по умолчанию предоставленный debian:

```
[root@localhost ~]$ cd /etc/apache2/sites-available
[root@localhost ~]$ cp default linshare-admin.conf
[root@localhost ~]$ a2dissite default
[root@localhost ~]$ a2ensite linshare-admin.conf
[root@localhost ~]$ a2enmod ssl
[root@localhost ~]$ a2enmod headers
[root@localhost ~]$ a2enmod proxy proxy_http headers
[root@localhost ~]$ vim linshare-admin.conf
<VirtualHost *:80>
...
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

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
...
</Virtualhost>
```

> Примечание:<br/>
   * После всех изменений vhost, вы должны перезагрузить сервис Apache 2: <br/>
   `[root@localhost ~]$ service apache2 reload` <br/>
   * В последней версии Аpache файл по умолчанию может быть назван default.conf <br/>

<a name="linconf">

### Конфигурация и запуск LinShare

</a>

Настроить расположение __хранилища файлов__:

```
[root@localhost ~]$ mkdir -p /var/lib/linshare
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

Настройте __доступ сервера SMTP__, для отправки уведомлений:

```
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

В LinShare у вас есть два возможных режима аутентификации: первый - это номинальный режим, а второй - режим sso. Чтобы запустить LinShare, вы должны включить хотя бы один из следующих двух режимов:

* default: процесс аутентификации по умолчанию.
* sso : Активировать вставку заголовков для SSO. Этот профиль включает функции профиля по умолчанию.

Профиль по умолчанию jcloud является файловой системой для тестирования.

Вы можете отменить этот параметр, используя -Dspring.profiles.active=xxx
Или вы можете использовать переменную среды: SPRING_PROFILES_ACTIVE
Вы должны включить по крайней мере один профиль проверки подлинности среди профилей проверки и один профиль из профилей хранилища файлов данных, описанных ниже.

Доступные профили хранилища данных файла:

* jcloud: Using jcloud as file data store : Amazon S3, Swift, Ceph, filesystem (test only).

* gridfs: Using gridfs (mongodb) as file data store.

* jackrabbit2: Using jackrabbit as file data store.

* jackrabbit-to-jcloud: Using Jcloud as new file data store, jackrabbit as fallback file data store.

* jackrabbit-to-gridfs: Using GridFS as new file data store, jackrabbit as fallback file data store.

Рекомендуемый профиль для производства - jcloud with Swift.

Профиль по умолчанию - jcloud с файловой системой для тестирования.

> Примечание:<br/>
    - Мы используем JackRabbit только соединения хранилищ файлов. Мы категорически не рекомендуем использовать это хранилище как основное.

Для __запуска LinShare__ включите сервис tomcat:

`[root@localhost ~]$ service tomcat8 restart`

Чтобы проверить работоспособность __LinShare__, просмотрите файл __logs__:

`[root@localhost ~]$ tail -f /var/log/tomcat8/catalina.out`

Если сервис запустился правильно, у вас должны быть следующие сообщения:

```
[...]
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Затем перезапустите сервис Apache 2:

`[root@localhost ~]$ service apache2 restart`

> Примечание:<br/>
   У вас есть примеры vhost в следующем репозитории: [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)
   Для дополнительной конфигурации смотрите пример в следующем репозитории: [configuration](../configuration/)

<a name="firstAccess">

### Первый доступ

</a>

Теперь __LinShare сервис__ доступен по следующей ссылке:

Пользовательский интерфейс:

  * http://linshare-user.local/linshare

> Примечание:<br/>
   Этот URL-адрес также должен быть задан в параметрах вашего домена. Для этого перейдите к функциям __domain__ и
   введите его в поле параметров __notifcation url__

Для интерфейса администратора:

  *  http://linshare-admin.local/

#### Настройка LinShare

Подключитесь к в качестве системного администратора:

  * Логин: root@localhost.localdomain

  * Пароль: __adminlinshare__

Затем, чтобы связать __Linshare__ с вашим каталогом пользователя LDAP, создайте новый домен из раздела «ДОМЕНЫ». Дополнительную информацию см. в руководстве __Настройка и администрирование __LinShare__ [__LINSHARE: CONF__].
