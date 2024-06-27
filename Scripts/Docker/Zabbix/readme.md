# Zabbix
Zabbix compose to create and run zabbix in docker.

## Prerequisites
You may have a zabbix user on the server.

IP must be configured as describe on the server.

## Docker
Zabbix is create with it's postgresql database and components through a docker compose.

## UI
First, as zabbix docker run, the first connection through the server at 666 port to connect zabbix ui.

The first connect is done with default username/password and you have to create new users and deactivated the default one.

Set IP address of the docker-agent of the host to the docker network agent container ip.


Add the host for the server.

Import the templated dashboard.

## @TODO

change the .env to set it in secrets.

.env must not be commited (see .gitignore).

