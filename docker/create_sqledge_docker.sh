#!/bin/bash

#pull the container image to my computer
docker pull mcr.microsoft.com/azure-sql-edge

# create and install a sql edge docker 
docker run --cap-add SYS_PTRACE -e 'ACCEPT_EULA=1' -e 'MSSQL_SA_PASSWORD=skYhgS@83#aQ' -p 1433:1434 --name sqledgecontainer1 -d mcr.microsoft.com/azure-sql-edge