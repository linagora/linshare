#!/usr/bin/env bash
#
# Unattended Linshare installation on Debian 10/11 and Ubuntu 20.04
#
# Variables
export LS_VERSION="4.2.2"
export MDB_VERSION="4.2"
export TNS_VERSION="2.1.1"
export PGPASSWORD="ThisIsNotAPassword"
export ADMIN_HOST="linshare-admin.local"
export USER_HOST="linshare-user.local"
export UPLOAD_HOST="linshare-upload.local"
export WWW_ROOT="/var/www"
export LS_TMPDIR="/tmp/linshare_data"
# Start a Python web server in the directory where you have downloaded the Linshare files from http://download.linshare.org/versions/
# 192.168.1.1 is the IP address of the host with the downloaded files.
# (If you want to download the files directly from the repository, you need to install maven and rewrite the getFile() function.)
## python3 -m http.server 9000
export DL_SRC="http://192.168.1.1:9000"

# Constants (do not change)
export CFG_FILE="/etc/linshare/linshare.properties"
export PGHOST="localhost"
export PGDATABASE="linshare"
export PGUSER="linshare"

mkdir -p ${LS_TMPDIR}

OS=$(lsb_release -s -c)
case ${OS} in
  focal)
    echo "Detected operating system: Ubuntu 20.04 (Focal Fossa)"
    export PG_VERSION="12"
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${MDB_VERSION} multiverse" > ${LS_TMPDIR}/mongodb-org-${MDB_VERSION}.list
    ;;
  buster)
    echo "Detected operating system: Debian 10 (Buster)"
    export PG_VERSION="11"
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/debian buster/mongodb-org/${MDB_VERSION} main" > ${LS_TMPDIR}/mongodb-org-${MDB_VERSION}.list
    ;;
  bullseye)
    echo "Detected operating system: Debian 11 (Bullseye)"
    export PG_VERSION="13"
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/debian buster/mongodb-org/${MDB_VERSION} main" > ${LS_TMPDIR}/mongodb-org-${MDB_VERSION}.list
    ;;
  *)
    echo "ERROR : Unsupported distribution ${OS}. Supported versions are Ubuntu 20.04 (Focal Fossa), Debian 10 (Buster) and Debian 11 (Bullseye)."
    exit 1
esac

function installDependencies() {
  echo "Install dependencies"

  apt update
  apt install -y gnupg gnupg2

  mkdir -p /etc/apt/sources.list.d/
  mv ${LS_TMPDIR}/mongodb-org-${MDB_VERSION}.list /etc/apt/sources.list.d/
  wget -qO - https://www.mongodb.org/static/pgp/server-${MDB_VERSION}.asc | apt-key add -
  apt update
  apt install -y openjdk-11-jdk unzip bzip2 postgresql tomcat9 apache2 mongodb-org
}

function getFile() {
  local _MYFILE=$1

  cd ${LS_TMPDIR}
  if [ ! -f "${_MYFILE}" ]; then
    wget --quiet ${DL_SRC}/${_MYFILE}
    if [ "$?" -ne 0 ]; then
      echo "ERROR 404: The file ${DL_SRC}/${_MYFILE} was not found. Terminating script."
      exit 1
    fi
  fi
  if [ ! -f "${_MYFILE}.sha1" ]; then
    wget --quiet ${DL_SRC}/${_MYFILE}.sha1
    if [ "$?" -ne 0 ]; then
      echo "ERROR 404: The file ${DL_SRC}/${_MYFILE}.sha1 was not found. Terminating script."
      exit 1
    fi
  fi
  # The checksum verification is an ugly hack because the sha1 files are missing the file name.
  SHA1_FILE=$(sha1sum ${_MYFILE} | cut -d' ' -f1)
  SHA1_VERIFY=$(cat ${_MYFILE}.sha1)
  if [ "${SHA1_FILE}" == "${SHA1_VERIFY}" ]; then
    echo "File: ${_MYFILE} is downloaded and checksums match."
  else
    echo "File: ${_MYFILE} could not be downloaded correctly or checksums don't match."
    echo "ERROR: Terminating script."
    exit 1
  fi
}

function downloadFiles() {
  echo "Download linshare archives"
  cd ${LS_TMPDIR}
  getFile "linshare-core-${LS_VERSION}-documentation-webservices.tar.bz2"
  getFile "linshare-ui-admin-${LS_VERSION}.tar.bz2"
  getFile "linshare-ui-upload-request-${LS_VERSION}.tar.bz2"
  getFile "linshare-ui-user-${LS_VERSION}.tar.bz2"
  getFile "linshare-core-${LS_VERSION}-sql.tar.bz2"
  getFile "linshare-core-${LS_VERSION}.war"
}

function unpackLinshareCore() {
  echo "Unpack Linshare Core"
  mkdir -p /etc/linshare
  unzip -o -j -d /etc/linshare/ ${LS_TMPDIR}/linshare-core-${LS_VERSION}.war WEB-INF/classes/{linshare,log4j}.*
  mv ${CFG_FILE}.sample ${CFG_FILE}
}

function configurePostgres() {
  echo "Configure Postgres ${PG_VERSION}"
  cat <<EOF >> /etc/postgresql/${PG_VERSION}/main/pg_hba.conf
# TYPE  DATABASE                  USER          CIDR-ADDRESS         METHOD
local   ${PGDATABASE}             ${PGUSER}                          md5
host    ${PGDATABASE}             ${PGUSER}     127.0.0.1/32         md5
host    ${PGDATABASE}             ${PGUSER}     ::1/128              md5
EOF

  systemctl restart postgresql

  tar xjvf ${LS_TMPDIR}/linshare-core-${LS_VERSION}-sql.tar.bz2 -C ${LS_TMPDIR}

  cat <<EOF > ${LS_TMPDIR}/postgres-initial.sql
CREATE ROLE linshare
  ENCRYPTED PASSWORD '${PGPASSWORD}'
  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;

CREATE DATABASE ${PGDATABASE}
  WITH OWNER = ${PGUSER}
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;
GRANT ALL ON DATABASE ${PGDATABASE} TO ${PGUSER};
\q
EOF

  runuser -l postgres -c "psql -f ${LS_TMPDIR}/postgres-initial.sql"
  psql -f ${LS_TMPDIR}/linshare-core-sql/postgresql/createSchema.sql
  psql -f ${LS_TMPDIR}/linshare-core-sql/postgresql/import-postgresql.sql

  sed -i "s/linshare.db.username=.*/linshare.db.username=${PGUSER}/g"     ${CFG_FILE}
  sed -i "s/linshare.db.password=.*/linshare.db.password=${PGPASSWORD}/g" ${CFG_FILE}
}

function configureMongoDB() {
  echo "Configure MongoDB ${MDB_VERSION}"
  chown -R mongodb:mongodb /var/lib/mongodb
  systemctl start mongod
  systemctl enable mongod
  echo "Starting mongodb ..."
  sleep 5
  mongo <<EOF
use admin;
db.createUser({user: "${PGUSER}", pwd: "${PGPASSWORD}", roles: [{role: "readWrite", db: "${PGDATABASE}"},{role: "readWrite", db: "${PGDATABASE}-files"}]})
EOF

  sed -i "s/linshare.mongo.data.credentials=.*/linshare.mongo.data.credentials=${PGUSER}:${PGPASSWORD}@admin/g"             ${CFG_FILE}
  sed -i "s/linshare.mongo.smallfiles.credentials=.*/linshare.mongo.smallfiles.credentials=${PGUSER}:${PGPASSWORD}@admin/g" ${CFG_FILE}
  sed -i "s/linshare.mongo.bigfiles.credentials=.*/linshare.mongo.bigfiles.credentials=${PGUSER}:${PGPASSWORD}@admin/g"     ${CFG_FILE}
}

function configureTomcat() {
  echo "Configure Tomcat"
  cat <<'EOF' > /etc/default/tomcat9
JAVA_OPTS="${JAVA_OPTS} -Xms512m -Xmx2048m"
JAVA_OPTS="${JAVA_OPTS} -Dlinshare.config.path=file:/etc/linshare/"
JAVA_OPTS="${JAVA_OPTS} -Dlog4j.configuration=file:/etc/linshare/log4j.properties"
JAVA_OPTS="${JAVA_OPTS} -Dspring.profiles.active=default,jcloud,batches"
EOF

  mkdir -p /etc/systemd/system/tomcat9.service.d
  mkdir -p /var/lib/linshare/tmp
  mkdir -p /var/lib/linshare/filesystemstorage
  chown -R tomcat:tomcat /var/lib/linshare

  cat <<EOF >> /etc/systemd/system/tomcat9.service.d/override.conf
[Service]
ReadWritePaths=/var/lib/linshare
EOF

  mv ${LS_TMPDIR}/linshare-core-${LS_VERSION}.war /var/lib/tomcat9/webapps/linshare.war

  MATCH="jarsToSkip"
  NEWLINE="jclouds-bouncycastle-1.9.2.jar,bcprov-*.jar,\\\\"
  sed -i "/${MATCH}/a ${NEWLINE}" /var/lib/tomcat9/conf/catalina.properties

  systemctl daemon-reload
  systemctl restart tomcat9
}

function configureApache() {
  echo "Configure Apache"

  mkdir -p ${WWW_ROOT}

  tar xjf ${LS_TMPDIR}/linshare-ui-user-${LS_VERSION}.tar.bz2 -C ${WWW_ROOT}/
  chown -R www-data: ${WWW_ROOT}/linshare-ui-user

  echo "Enable modules"
  a2enmod ssl
  a2enmod headers
  a2enmod proxy proxy_http
  a2dissite 000-default

  echo "Create User UI virtualhost"
  cat <<EOF > /etc/apache2/sites-available/linshare-ui-user.conf
<VirtualHost *:80>
ServerName ${USER_HOST}
DocumentRoot ${WWW_ROOT}/linshare-ui-user
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-user-error.log
CustomLog /var/log/apache2/linshare-user-access.log combined
</Virtualhost>
EOF

  a2ensite linshare-ui-user

  echo "Create Admin UI virtualhost"
  tar xjf ${LS_TMPDIR}/linshare-ui-admin-${LS_VERSION}.tar.bz2 -C ${WWW_ROOT}/
  chown -R www-data: ${WWW_ROOT}/linshare-ui-admin

  cat <<EOF > /etc/apache2/sites-available/linshare-ui-admin.conf
<VirtualHost *:80>
ServerName ${ADMIN_HOST}
DocumentRoot ${WWW_ROOT}/linshare-ui-admin
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-admin-error.log
CustomLog /var/log/apache2/linshare-admin-access.log combined
</Virtualhost>
EOF

  a2ensite linshare-ui-admin

  echo "Create upload request component virtualhost"
  tar xjf ${LS_TMPDIR}/linshare-ui-upload-request-${LS_VERSION}.tar.bz2 -C ${WWW_ROOT}/
  chown -R www-data: ${WWW_ROOT}/linshare-ui-upload-request

  cat <<EOF > /etc/apache2/sites-available/linshare-ui-upload-request.conf
<VirtualHost *:80>
ServerName ${UPLOAD_HOST}
DocumentRoot ${WWW_ROOT}/linshare-ui-upload-request
<Location /linshare>
    ProxyPass http://127.0.0.1:8080/linshare
    ProxyPassReverse http://127.0.0.1:8080/linshare
    ProxyPassReverseCookiePath /linshare /

    # Workaround to remove httpOnly flag (could also be done with tomcat)
    Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/"
    # For https, you should add Secure flag.
    # Header edit Set-Cookie "(JSESSIONID=.*); Path.*" "\$1; Path=/; Secure"

    #This header is added to avoid the  JSON cache issue on IE.
    Header set Cache-Control "max-age=0,no-cache,no-store"
</Location>

ErrorLog /var/log/apache2/linshare-ui-upload-request-error.log
CustomLog /var/log/apache2/linshare-ui-upload-request-access.log combined
</Virtualhost>
EOF

  a2ensite linshare-ui-upload-request

  systemctl restart apache2
}

function installThumbnailServer() {
  apt install -y libreoffice

  getFile "thumbnail-server-${TNS_VERSION}-config.yml"
  getFile "thumbnail-server-${TNS_VERSION}.jar"

  mv ${LS_TMPDIR}/thumbnail-server-${TNS_VERSION}-config.yml /etc/linshare/linshare-thumbnail-server.yml
  mv ${LS_TMPDIR}/thumbnail-server-${TNS_VERSION}.jar /usr/local/sbin/linshare-thumbnail-server.jar

    cat <<EOF >/lib/systemd/system/linshare-thumbnail-server.service
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
EOF

  systemctl daemon-reload
  systemctl enable linshare-thumbnail-server.service
  systemctl start linshare-thumbnail-server.service
}

# Run installation tasks!
installDependencies
downloadFiles
unpackLinshareCore
configurePostgres
configureMongoDB
configureTomcat
configureApache
## Optional
installThumbnailServer
