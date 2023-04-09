#!/bin/bash

#pull the container image to my computer
docker pull mariadb

# create a database container and run the docker 
docker run --name mariadbcontainer -e MYSQL_ROOT_PASSWORD=skYhgS@83#aQ -p 3306:3306 -d mariadb

#to access inside docker terminal:
#mysql -h localhost -P 3306 --protocol=TCP -u root -p
docker exec -it mariadbcontainer mysql -h localhost -P 3306 --protocol=TCP -u root -p