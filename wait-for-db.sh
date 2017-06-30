#!/bin/bash
until nc -z -v -w120 db 3306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done