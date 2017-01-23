#!/bin/sh
#
# This Script create iot server 3.0.0 pack point to Mysql 
MYSQL_DB_USERNAME="$1"
MYSQL_DB_PASSWORD="$2"

if [ ! -z "$MYSQL_DB_USERNAME" ] && [ ! -z "$MYSQL_DB_PASSWORD" ]; then
	echo "Start Creating IOT Distribution point to Mysql..."
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop cdmdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop androiddb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop carbondb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop amdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop appmdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop mbdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop socialdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop vfadb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop android_sensedb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop windowsdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD -f drop raspberrpidb

	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create cdmdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create androiddb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create carbondb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create amdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create appmdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create mbdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create socialdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create vfadb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create android_sensedb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create windowsdb
	mysqladmin -u $MYSQL_DB_USERNAME -p$MYSQL_DB_PASSWORD create raspberrpidb

	rm -rf wso2iot-3.0.0-SNAPSHOT
	unzip wso2iot-3.0.0-SNAPSHOT.zip
	mvn clean install -f wso2iot-3.0.0-SNAPSHOT/plugins/plugins-deployer.xml

	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "cdmdb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "androiddb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/plugins/android/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "carbondb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "amdb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/apimgt/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "appmdb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/appmgt/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "mbdb" < "wso2iot-3.0.0-SNAPSHOT/broker/dbscripts/mb-store/mysql-mb.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "socialdb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/social/mysql/resource.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "vfadb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/plugins/virtual_firealarm/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "android_sensedb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/plugins/android_sense/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "windowsdb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/plugins/windows/mysql.sql"
	mysql -u "$MYSQL_DB_USERNAME" "-p$MYSQL_DB_PASSWORD" "raspberrpidb" < "wso2iot-3.0.0-SNAPSHOT/core/dbscripts/cdm/plugins/raspberrypi/mysql.sql"

	cp mysql-connector-java-5.1.33-bin.jar wso2iot-3.0.0-SNAPSHOT/core/repository/components/lib
	cp mysql-connector-java-5.1.33-bin.jar wso2iot-3.0.0-SNAPSHOT/broker/repository/components/lib
	cp mysql-connector-java-5.1.33-bin.jar wso2iot-3.0.0-SNAPSHOT/analytics/repository/components/lib
	rm -rf wso2iot-3.0.0-SNAPSHOT/core/repository/database/*
	rsync -r conf/core/ wso2iot-3.0.0-SNAPSHOT/core/repository/conf/
	rsync -r conf/analytics/ wso2iot-3.0.0-SNAPSHOT/analytics/repository/conf/
	rsync -r conf/broker/ wso2iot-3.0.0-SNAPSHOT/broker/repository/conf/
	echo "End Creating IOT Distribution point to Mysql..."
	sh wso2iot-3.0.0-SNAPSHOT/core/bin/wso2server.sh start -Dsetup
else
	echo "ERROR:Mysql username and password could not be found."
fi
exit 0
