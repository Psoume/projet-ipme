# projet-ipme
Steamish
Project is a part of AdminSys-DevOps learning, fallowing [this instructions.](https://lenaic.notion.site/valuation-de-fin-d-ann-e-de-test-63c31988c34c4ef4ae166945f8d25313)

## Server Install
[See here the command for install](https://github.com/Psoume/projet-ipme/blob/main/Scripts/command.md)

## Server Configuration
@todo ansible

## Application
@todo CI: Build+Test+Docker


## Deployement
@todo CD: Deploy to registry

@todo CD: Server pull from registry


## Server Monitoring
@todo zabbix


## Server Backup
@todo backups (3-2-1)

## CI/CD Workflow
@todo complete this part with some visual...

### Prerequisite (manual actions and manual task)
Terraform action => allocate the virtual machine

Installing the operating system on the VM manually (through ESXI)

Install basic and enabled ssh

Ansible action => configure the VM server itself

Ansible action => install components to run the app.

### App (auto and manual job)
CI action => clone the app src repos, build the app and launch tests. 

CD action => if the tests passed, build the docker image of the app and deploy to registry

CD action => from the server, pull the app docker image (and components) from repository and launch the app

### Monitoring (not auto, manual job only)
Ansible action => Install Zabbix on the server and configure it

Ansible action => Configure the back up on the VM server


Bien penser à éditer DATABASE_URL dans le .env pour la bdd
