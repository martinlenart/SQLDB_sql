#!/bin/bash

#ensure rosetta2 is installed on your M1 or M2 machine to emulate x86
softwareupdate --install-rosetta

#pull the container image to my computer
docker pull mcr.microsoft.com/mssql/server:2022-latest

#install and run the container 
#docker run --cap-add SYS_PTRACE -e 'ACCEPT_EULA=1' -e 'MSSQL_SA_PASSWORD=skYhgS@83#aQ' -p 1433:1433 --name sqledgecontainer -d mcr.microsoft.com/azure-sql-edge

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=skYhgS@83#aQ" -p 1433:1433 --name sql2022container --hostname sql2022 -d mcr.microsoft.com/mssql/server:2022-latest