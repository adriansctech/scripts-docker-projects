#!/bin/bash
echo "----------------------------------------------------------------------------------------|"
echo "|                  This script install next repositories                                |"
echo "|                  Docker (CarlosReigDockerLAMP)+ other project                         |"
echo "|---------------------------------------------------------------------------------------|"
echo "|During the cloning of repositories you will be asked for the access credentials of git |"
echo "|-----------------------      Important      -------------------------------------------|"
echo "|       At the end of installation, remember to configure settings.local.php            |"
echo "|---------------------------------------------------------------------------------------|"
read -p "Press enter to continue"
clear
absolutepath=$(pwd)
echo "|------------------------------------|"
echo "|   1.-Insert the project name       |"
echo "|------------------------------------|"
read project
#clone base docker project
git clone https://github.com/carlosreig/docker-lamp.git $project
cd $project
#checkout to branch 
git checkout php5.6
git pull 
rm -r www 
#in this case use this DockerFile, in one future not necessary
rm $PWD/apache/Dockerfile
parentdir="$(dirname "$PWD")"
cp $parentdir/Dockerfile $PWD"/apache"
#check if image of 5.6-apache exist or not
dockerimagescomand="docker images"
dockerimageslist=$($dockerimagescomand)
apacheimage="5.6-apache" &&
if [[ $apacheimage == *"$apacheimage"* ]]
then
	echo "|-------------------------------------------------------------|"			
	echo "|            2.-Insert the url of git project                 |"
	echo "|-------------------------------------------------------------|"
	read gitproject
	git clone $gitproject www
	cd www
	git checkout staging
	git pull		
	cd ..			
	cp $parentdir/clone-libs.sh www
	clear
	echo "|----------------------------------------------------------------"			
	echo "|        Remember create database with next input comand        |"
	echo "|       1.- First acces to mysql console                        |" 
	echo "|           |->mysql -u root -p123 -h db;                       |"
	echo "|       2.- Create database                                     |"
	echo "|           |->create database [name];                          |"
	echo "|       3.- Exit of mysql console                               |"
	echo "|           |->exit                                             |"
	echo "|----------------------------------------------------------------"
	./start.sh					
else
	docker-compose up --build		
fi