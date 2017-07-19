#!/bin/sh
until nc -z -v -w120 $MYSQL_DB_HOST $MYSQL_DB_PORT
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done

sh -c "/usr/local/tomcat/bin/catalina.sh run"