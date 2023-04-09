#!/bin/bash

#Open a terminal in the directory of the .bak files

#Create the backup directory in the sql2022container
docker exec -it sql2022container mkdir /var/opt/mssql/backups

#copy the .bak file to the docker based data directory
docker cp AdventureWorks2019.bak sql2022container:/var/opt/mssql/backups/
docker cp WideWorldImporters-Full.bak sql2022container:/var/opt/mssql/backups/
