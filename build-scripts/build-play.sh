#!/bin/bash

PROJECT_PATH="$1"
PROJECT_NAME="$2"
SYSTEMD_NAME="$3"

sudo systemctl stop $SYSTEMD_NAME

echo Go to the project
cd $PROJECT_PATH

echo Getting the latest version
git pull origin master

echo Build the project
activator stage
activator dist

echo Go to the built project
cd target/universal

echo Delete old version
rm -rf $(echo $PROJECT_NAME)/

echo Unzip the new version
unzip $(echo $PROJECT_NAME).zip

sudo systemctl start $SYSTEMD_NAME

