## Оглавление

### УСТАНОВКА LINSHARE

#### 1. [LinShare минимальная установка](#installmin)
   * [Скачать LinShare](#dlLinshare)
   * [Разархивировать и настроить конфигурацию файлов](#instalFile)
   * [Установка OpenJDK Java JRE](#instalOpenJDK)
   * [Базы данных (установка PostgreSQL & mongoDB)](#bdd)
   * [Активируйте новый движок для показа превью (не обязательно)](#thumbnail)
   * [Контейнер сервлетов (Установка Tomcat 7)](#tomcat)
   * [Веб-сервер (Установка Apache 2)](#apache)
     1. [Ui-user vhost конфигурация](#ui-user)
     2. [Ui-admin vhost конфигурация](#ui-admin)
   * [Конфигурация и запуск LinShare](#linconf)
   * [Первый доступ](#firstAccess)


### УСТАНОВКА LINSHARE

> Примечание:<br/>
Это руководство по установке предназначено для 2.x LinShare версий на Centos 7 (мы не поддерживаем другие версии Centos).
Установка предыдущей версии LinShare доступна на
ветке github: [LinShare 1.12.x](../../../../maintenance-1.12.x/documentation/EN/installation/linshare-install-centos.md)

<a name="installmin">

### __Linshare__ минимальная установка

</a>

<a name="dlLinshare">

### Загрузка __LinShare__

</a>

__LinShare__ являеется открытым, бесплатным приложением, доступным по ссылке:

  * [http://download.linshare.org/versions/](http://download.linshare.org/versions/)

> Примечание:<br/>
Вы можете найти все версии по этой [ссылке](http://download.linshare.org/versions/).
Выберите версию LinShare, которая подойдет вам больше всего.
Каждая версия LinShare содержит все необходимые компоненты, относящиеся к конкретной версии LinShare.
Не устанавливайте и не используйте другую версию компонента, отличную от той, которую вы найдете в самой папке.
В противном случае вы рискуете столкнуться с проблемами зависимостей, и LinShare может работать неправильно.


Для этой установки загрузите следующие файлы:

  * __linshare-core-{VERSION}.war__

  * __linshare-ui-admin-{VERSION}.tar.bz2__

  * __linshare-ui-user-{VERSION}.tar.bz2__

<a name="instalFile">

### Разархивировать и настроить кофигурацию файлов.

</a>

Для управления архивами необходимо использовать инструменты Unzip и Bzip:

`[root@localhost ~]$ yum install unzip bzip2`

Создайте репозиторий конфигурации __LinShare__ и вставьте файлы конфигурации:

```
[root@localhost ~]$ mv linshare-core-{VERSION}.war linshare.war
[root@localhost ~]$ mkdir -p /etc/linshare
[root@localhost ~]$ unzip -j -d /etc/linshare/ linshare.war WEB-INF/classes/{linshare,log4j}.*
```

### Исполнительная среда JAVA (JVM)

__LinShare__ работает с OpenJDK и Sun/Oracle Java 8. Этот раздел посвящен OpenJDK Java 8.

<a name="instalOpenJDK">

#### Установка OpenDK

</a>

Установите Java Runtime Environment (JRE) OpenJDK из репозиториев:

```
[root@localhost ~]$ yum -y install java-1.8.0-openjdk.x86_64
[root@localhost ~]$ update-alternatives --config java
```

> Примечание:<br/>
    * Вы можете игнорировать возможные ошибки в плагине Java.

<a name="bdd">

### Базы данных

</a>

LinShare нуждается в использовании базы данных (PostgreSQL) для его файлов и их конфигурации.

MySQL не поддерживается в LinShare v2

В этом разделе представлена установка с PostgreSQL.

Установите PostgreSQL из репозиториев:

`[root@localhost ~]$ yum install -y postgresql postgresql-server`


Запустите сервис PostgreSQL:

`[root@localhost ~]$ postgresql-setup initdb`

`[root@localhost ~]$ systemctl enable postgresql`

`[root@localhost ~]$ systemctl start postgresql`

#### Создание безопасного доступа

Настройте файл управления доступом PostgreSQL:

```
[root@localhost ~]$ vim /var/lib/pgsql/data/pg_hba.conf
 # TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
 local   all               postgres               peer
 local   linshare                  linshare                           md5
 host    linshare                  linshare      127.0.0.1/32         md5
 host    linshare                  linshare      ::1/128              md5
```

> Примечание:<br/>
    * Эти строки обычно находятся в конце файла.<br/>
    * В целях безопасности postgreSQL работает только локально.<br/>
    * Перезапустите / перезагрузите сервер postgreSQL, чтобы применить изменения:<br/>
    `[root@localhost ~]$ service postgresql restart/reload`

Вы можете сделать это правило первым. PostgreSQL использует первое допустимое правило, которое соответствует запросу проверки подлинности.

Создайте пользователя "linshare" (пароль {PASSWORD}) :

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

СОЗДАЙТЕ РОЛЬ linshare
  ЗАШИФРОВАННЫЙ ПАРОЛЬ '{PASSWORD}'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

\q
```
Команды: чтобы выйти, напишите "\q" ; чтобы получить помощь по PSQL, напишите "\?".

Создайте и импортируйте схему базы данных:

```
[root@localhost ~]$ su - postgres
[postgres@localhost ~]$ psql

СОЗДАЙТЕ БАЗУ ДАННЫХ linshare
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

Перенесите файлы SQL "createSchema.sql" и "import-postgresql.sql":

```
[root@localhost ~]$ tar xjvf linshare-core-*-sql.tar.bz2
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/createSchema.sql
Password for user linshare: {PASSWORD}
[root@localhost ~]$ psql -U linshare -W -d linshare linshare-core-sql/postgresql/import-postgresql.sql
Password for user linshare: {PASSWORD}
```

Измените файл конфигурации LinShare:

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

Для установки LinShare V2 требуется также наличие mongoDB. Вы можете установить её, выполнив следующие шаги:

Пакет mongodb-org не существует в репозиториях по умолчанию для CentOS.
Однако MongoDB поддерживает выделенный репозиторий. Добавьте его на наш сервер.
С помощью редактора vi создайте файл .repo для yum, утилиту управления пакетами для CentOS:

```
[root@localhost ~]$ vi /etc/yum.repos.d/mongodb-org.repo
```

Затем добавьте информацию о репозитории для последней стабильной версии в файл:

```
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
```

Вы можете установить пакет mongodb-org из репозитория с помощью утилиты yum:

```
[root@localhost ~]$ yum install mongodb-org
```

Перед запуском MongoDB убедитесь, что файл /etc/mongod.conf имеет ip-адрес привязки: 127.0.0.1

Затем активируйте startup и запустите сервис MongoDB с помощью утилиты chkconfig и systemctl:

```
[root@localhost ~]$ chkconfig mongod on
[root@localhost ~]$ systemctl start mongod
```

<a name="thumbnail">
#### Включить новый движок для показа превью (thumbnail) (опционально)
</a>

LinShare имеет механизм генерации предварительного просмотра для широкого спектра файлов:

 - Формат OpenDocument (ODT, ODP, ODS, ODG)
 - Формат документов Microsoft (DOCX, DOC, PPTX, PPT, XLSX, XLS)
 - PDF документы
 - Изображения (PNG, JPEG, JPG, GIF)
 - Текстовые файлы (TXT, XML, LOG, HTML ...)

> Примечание:<br/>
    *  Перед использованием этого движка на вашем компьютере должен быть установлен LibreOffice или OpenOffice, минимальная версия libreOffice: 4.2.8.

Чтобы установить libreOffice:

     yum -y install libreOffice

По умолчанию для движка thumbnail установлено значение FALSE. Чтобы включить его, вы должны отредактировать файл конфигурации LinShare:

```java
#******** LinThumbnail конфигурация
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
#******** Конфигурация LinThumbnail
# key to enable or disable thumbnail generation
linshare.documents.thumbnail.enable=true
# key to enable remote thumbnail generation
linshare.linthumbnail.remote.mode=true
linshare.linthumbnail.dropwizard.server=http://0.0.0.0:8090/linthumbnail?mimeType=%1$s
linshare.documents.thumbnail.pdf.enable=true
```
Теперь перейдите по ссылке `http: // download.linshare.org / versions /` и загрузите следующие файлы:

* linshare-thumbnail-server-{VERSION}.jar
* linshare-thumbnail-server-{VERSION}.yml

> Примичание:<br>
По умолчанию сервер имеет порт 80. Его можно изменить, если необходимо.

Скопируйте файл конфигурации `linshare-thumbnail-server-{VERSION}.yml` в `/etc/linshare/linshare-thumbnail-server.yml` и скопируйте архив java `linshare-thumbnail-server-{VERSION}.jar` в директорию `/usr/local/sbin/linshare-thumbnail-server.jar`, для этого вы можете использовать следующую команду:

```java
cp linshare-thumbnail-server-*.yml /etc/linshare/linshare-thumbnail-server.yml
```
```java
cp linshare-thumbnail-server-*.jar /usr/local/sbin/linshare-thumbnail-server.jar
```

* Вы можете автоматизировать запуск сервера thumbnail, создав сервис `systemd` в директории `/etc/systemd/system`, со следующим названием: `linshare-thumbnail-server.service`.

Измените файл `linshare-thumbnail-server.service` и скопируйте следующий код:

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

LinShare является Java приложением, скомпилированным и построенным под формат «WAR» (**W**eb **A**pplication a**R**chive), поэтому оно нуждается в __servlet container Java__ (Tomcat or Jetty) для запуска.

В этом разделе обьясняется установка Tomcat сервера.

#### Установка Tomcat 7


Установка Tomcat с репозиториев:

`[root@localhost ~]$ yum install -y tomcat`

Активируйте сервис при запуске:

`[root@localhost ~]$ systemctl enable tomcat`



> Примечание:<br/>
     * Проверьте Tomcat статус, чтобы убедиться, что сервис активирован с помощью systemctl status tomcat

#### Конфигурация Tomcat 7


Чтобы указать местоположение LinShare __configuration__ (файл _linshare.properties_), а также начальные параметры, предусмотренные по умолчанию, найдите отмеченные параметры в первых строках файла __linshare.properties__ и скопируйте их в файл Tomcat (/etc/sysconfig/tomcat):


Все начальные необходимые параметры по умолчанию для Linshare указаны в заголовке следующих файлов конфигурации:

  * __/etc/linshare/linshare.properties__
  * __/etc/linshare/log4j.properties__


Обратите внимание, что вам нужно объединить строки для настройки `JAVA_OPTS` в конфигурации Tomcat, скопируйте в *__/etc/sysconfig/tomcat__*:

`JAVA_OPTS="-Djava.awt.headless=true -Xms512m -Xmx2048m -Dlinshare.config.path=file:/etc/linshare/ -Dlog4j.configuration=file:/etc/linshare/log4j.properties -Dspring.profiles.active=default,jcloud,mongo`

#### Дополнительные параметры

У вас есть ключ конфигурации «tomcat.util.scan.StandardJarScanFilter.jarsToSkip» в файле /usr/share/tomcat/conf/catalina.properties, добавьте в него среднюю строку:

```
jetty-*.jar,oro-*.jar,servlet-api-*.jar,tagsoup-*.jar,xmlParserAPIs-*.jar,\
jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\
xom-*.jar
```
#### Разархивировация

Разархивируйте архив приложения Linshare на сервере Tomcat:

```
[root@localhost ~]$ cp linshare.war /usr/share/tomcat/webapps/
[root@localhost ~]$ mkdir -p /var/lib/linshare
[root@localhost ~]$ chown -R tomcat:tomcat /var/lib/linshare
```

<a name="apache">

#### Веб-сервер

</a>

Интерфейс администратора __LinShare__ является приложением основанным на HTML/CSS и JavaScript.
Для этого нужен простой веб-сервер, например Apache или Nginx.

В этом разделе представлена установка HTTP-сервера Apache.

#### Установка Apache 2

Установите Apache 2 с репозиториев:

```
[root@localhost ~]$ yum install -y httpd
[root@localhost ~]$ systemctl enable httpd
[root@localhost ~]$ systemctl start httpd
```

Это активирует Apache/2.4.6 (CentOS)

##### Конфигурация Vhost

<a name="ui-user">

#### ui-user

</a>

Чтобы развернуть приложение LinShare, необходимо активировать __mod_proxy__ на Apache 2.
Вам нужно создать свои каталоги в каталоге / var / www /. Обратите внимание, что имя вашего каталога будет вашим доменным именем для приложения.
Вы также должны предоставить своим пользователям права доступа к каталогам.

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-user-<VERSION>.tar.bz2
```

Чтобы разархивировать приложение LinShare, необходимо создать virtualhost - файл конфигурации:

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-user.conf
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

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-user-error.log
CustomLog /var/log/httpd/linshare-user-access.log объединен
...
</Virtualhost>
```

> Примечание:<br/>
   * После любых изменений vhost, вы должны перезапускать Apache 2 сервер:<br/>
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="ui-admin">

#### ui-admin

</a>

Разархивируйте архив приложения __LinShare UI Admin__ в Apache 2 репозиторий:

```
[root@localhost ~]$ cd /var/www/
[root@localhost ~]$ tar xjf /tmp/linshare_data/linshare-ui-admin-{VERSION}.tar.bz2
[root@localhost ~]$ chown -R apache: /var/www/linshare-ui-admin
```

Для разархивирования интерфейса администратора __LinShare__, необходимо активировать __mod_proxy__ в Apache 2.

```
[root@localhost ~]$ cd /etc/httpd/conf.d
[root@localhost ~]$ vim linshare-ui-admin.conf
<VirtualHost *:80>
...
ServerName linshare-admin.local
DocumentRoot /var/www/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with Tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/httpd/linshare-admin-error.log
CustomLog /var/log/httpd/linshare-user-access.log объединен
...
</Virtualhost>
```

> Note:<br/>
   * После любых изменений vhost, вы должны перезапускать Apache 2 сервер:<br/>
   `[root@localhost ~]$ apachectl restart` <br/>

<a name="linconf">

### Конфигурация и запуск LinShare

</a>

Настройте __storage location of the files__:

```
[root@localhost ~]$ mkdir -p /var/lib/linshare
linshare.documents.storage.filesystem.directory=/var/lib/linshare/filesystemstorage
linshare.encipherment.tmp.dir=/var/lib/linshare/tmp
```

Настройте __access of a SMTP server__, для отправки уведомлений:

```
mail.smtp.host=<smtp.yourdomain.com>
mail.smtp.port=25
mail.smtp.user=linshare
mail.smtp.password=<SMTP-PASSWORD>
mail.smtp.auth.needed=false
mail.smtp.charset=UTF-8
```

В LinShare, у вас есть два возможных режима аутентификации, первый - это номинальный режим, а второй - режим sso. Чтобы запустить LinShare, вы должны включить хотя бы один из следующих двух режимов:

* default: процесс аутентификации по умолчанию.
* sso: Активировать вставку заголовков для SSO. Этот профиль включает функции профиля по умолчанию

Профиль по умолчанию jcloud является файловой системой для тестирования.

Вы можете отменить этот параметр, используя -Dspring.profiles.active=xxx
Или вы можете использовать переменную среды: SPRING_PROFILES_ACTIVE
Вы должны включить по крайней мере один профиль проверки подлинности среди профилей проверки и один профиль из профилей хранилища файлов данных, описанных ниже.

Доступные профили хранилища данных файла:

* jcloud: Используемые jcloud в качестве хранилища файлов данных: Amazon S3, Swift, Ceph, файловая система (только для тестов).

* gridfs: Использование gridfs (mongodb) в качестве хранилища файлов.

* jackrabbit2 : Использование jackrabbit в качестве хранилища данных файла.

* jackrabbit-to-jcloud : Использование Jcloud в качестве нового хранилища данных файла, jackrabbit в качестве резервного хранилища файлов.

* jackrabbit-to-gridfs : Использование GridFS в качестве нового хранилища данных файла, jackrabbit в качестве резервного хранилища файлов данных.

Рекомендуемый профиль для производства - jcloud with Swift.

Профиль по умолчанию - jcloud с файловой системой для тестирования.

> Примечание:<br/>
   * Мы используем JackRabbit только соединения хранилищ файлов. Мы категорически не рекомендуем использовать это хранилище как основное.<br/>

Для __start LinShare__, необходимо запустить сервис Tomcat:

`[root@localhost ~]$ systemctl restart Tomcat`

Чтобы проверить работоспособность __LinShare__, просмотрите файл __logs__:

`[root@localhost ~]$ tail -f /var/tomcat/logs/catalina.out`

Если сервис запустился правильно, у вас должны быть следующие сообщения:

```
[...]
org.apache.coyote.http11.Http11Protocol start
INFO: Démarrage de Coyote HTTP/1.1 sur http-8080
org.apache.catalina.startup.Catalina start
INFO: Server startup in 23151 ms
```

Затем перезагрузите сервис Apache 2:

`[root@localhost ~]$ apachectl restart`

> Примечание:<br/>
    У вас есть примеры vhost в следующем репозитории: [utils/apache2/vhosts-sample/](../../../utils/apache2/vhosts-sample/)

<a name="firstAccess">

### Первый доступ

</a>

__LinShare service__ теперь доступен по следующим адресам:

Для пользовательского интерфейса:

  * http://linshare-user.local/linshare

> Примечание:<br/>
   Этот URL-адрес также должен быть задан в параметрах вашего домена. Для этого перейдите к функциям __domain__ и
   введите его в поле параметров __notifcation url__

Для интерфейса администрирования:

  * http://linshare-admin.local/

#### Настройки LinShare

Подключитесь к LinShare в качестве _системного администратора_ Linshare:

  * Login: root@localhost.localdomain

  * Password: __adminlinshare__

Затем, чтобы связать __Linshare__ с вашим каталогом пользователя LDAP, создайте новый домен из раздела «ДОМЕНЫ». Дополнительную информацию см. в руководстве __Настройка и администрирование __LinShare__ [__LINSHARE: CONF__].
