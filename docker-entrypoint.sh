#!/bin/bash
mkdir /src/
cd /src/
git clone https://github.com/ez-design/RTFree.git
git clone https://github.com/ez-design/RTFreeWeb.git
cd /src/RTFree/
dotnet restore
dotnet publish -o /RTFree/
cd /src/RTFreeWeb/src/RTFreeWeb/
dotnet restore
dotnet publish -o /RTFreeWeb/
mkdir /RTFreeWeb/wwwroot/records
mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -e 'create database rtfreeweb'
mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD rtfreeweb < /src/RTFreeWeb/create.sql
dotnet /RTFreeWeb/RTFreeWeb.dll
