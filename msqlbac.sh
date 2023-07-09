#!/bin/bash

ERR_mysql_disabled=71

DB_USER=backup
#US_PASS=QwerTy#123 Using ~/.mylogin.cnf

DATE=$(date "+%Y_%m_%d")
DEST_FOLD=my_sql_backups
PathW=$HOME/$DEST_FOLD/"$DEST_FOLD"-"$DATE"


#Check mysql is active
systemctl is-active --quiet mysqld || (echo "ERROR: mysql is disabled or not install" && exit $ERR_mysql_disabled)
cd $HOME
mkdir -p $DEST_FOLD
cd $HOME/$DEST_FOLD
mkdir -p "$DEST_FOLD"-"$DATE"

for base in $(mysql --login-path=$DB_USER --skip-column-names -e 'show databases;')
do
	cd "$PathW"
	mkdir -p $base
	cd $base
		for table in $(mysql --login-path=$DB_USER --skip-column-names -e "show tables from $base;")
		do
			mkdir -p $table
			/usr/bin/mysqldump --login-path=$DB_USER --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers --master-data=2 $base $table 2>/dev/null | gzip -1 > $table/"$base"_"$table"-"$DATE".gz
		done
done

