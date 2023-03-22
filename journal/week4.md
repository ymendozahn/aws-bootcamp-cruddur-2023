# Week 4 — Postgres and RDS

## Creating a local postgres database
First we are going to create a local postgres database using psql commands. We need to have te client install.

Here is the code

```
postgres=# create database cruddur;
```

Now we going to create a schema that will have the structure of the tables were we will store the data.

Here is the psql script file [schema.sql](). And here is the code

```

```

Also, if you don't want to type in the *password* every time you run the sql script, then we can configure an enviroment variable with the connection string for the dev and prod databases.

Here is the code:

```bash
export CONNECTION_URL="postgresql://postgres:password@localhost:5432/cruddur"

export PROD_CONNECTION_URL="postgresql://cruddurroot:password@cruddur-db-instance.cnowliwjrgce.us-east-1.rds.amazonaws.com:5432/cruddur"
```

### Creating database scripts for common commands

So, in order to save us some time while we run basic sql commands for connect, create, drop, setup etc, We can create different scripts for these common commands. 

We will place the scripts on a `bin` folder inside the backend-flask files.

Here is a list of the bash scripts we are going to use with our postgres databases.

* [db_connect]() , for stablishing a connection with the databases.

usage: `$ db_connect [prod]`

* [db-create]() , use for creating the local cruddur database.

usage: `$ db_create`
* [db-drop]() , use for dropping (delete) the local cruddur database

usage: `$ db-drop`
* [db-schema-load]() , This will load the [schema.sql]() file we created earlier

usage: `$ db-schema-load [prod]`
* [db-seed]() , use for loading mock data from the [seed.sql]() file into the tables

usage: `$ db-seed [prod]`
* [db-sessions]() , Display the pg processes that show us active sessions

usage: `$ db-sessions [prod]`
* [db-setup]() , Use for preparing the cruddur database from scratch. It will drop current local db and re-create it with schema and seed info.

usage: `$ db-setup`
*  [db-kill-sessions]() , Will query the database sessions and kill them.

usage: `$ db-kill-sessions [prod]` , It will kill 

**Some tips for creating the above bash scripts**

1. You need to specify what type of file is, because we are not going to give it an extension. 

For the bash file type, the first line of the file should indicade the type. 

We use this:

```bash
#! /usr/bin/bash
```

2. By default, when you create a file, it will not have permissions for execution, just read and write for the owner `-rw-r--r-- ` . So we need to change the file permissions. We are going to add the e**x**ecution permission for the owner/user

```bash
$ chmod u+x bin/file
```
3. You can use `sed` command/tool to do some stream manipulation so we can make have the correct information to pass on a variable or command. Here are some examples from the 
[linuxhint.com](https://linuxhint.com/50_sed_command_examples/) site.

4. To make the prints or outputs of the scripts color friendly, we can use the following code:

```bash
CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="db-create"
printf "${CYAN}== ${LABEL}${NO_COLOR}\n"
```

### Setting the backend-flask for postgres

#### Install the postgres driver

We need to install the postgres driver for the backend flask, so we add the follwing lines to the [requirements.txt]()

```
psycopg[binary]
psycopg[pool]
```

This will let us do the connection pulling
#### docker-compose settings

We are going to add some environment variables to the backend-flask section on the [docker-compose]() file.

```dockerfile

```

#### additional setting on backend services

1. import the libraries

    We need to import the library for the postgres db connection to the following files.
    
    * [home_activities.py]()
    * 

Here is the code

```python
from lib.db import db  
```
2. Now we delete the mock data from the backend-services and use the db() function to connect and return the data.

    All the functions are define on the [db.py]() file under the lib directory.

    We are going to make the changes to the following python backend files:
    
    * [home_activities.py]()


## Setting up Postgres database on Amazon RDS

We are going to create a postgres database on the amazon RDS service.

here is the code.

```
aws rds create-db-instance \
  --db-instance-identifier cruddur-db-instance \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --engine-version  14.6 \
  --master-username root \
  --master-user-password your-password \
  --allocated-storage 20 \
  --availability-zone us-east-1a \
  --backup-retention-period 0 \
  --port 5432 \
  --no-multi-az \
  --db-name cruddur \
  --storage-type gp2 \
  --publicly-accessible \
  --storage-encrypted \
  --enable-performance-insights \
  --performance-insights-retention-period 7 \
  --no-deletion-protection
```
### connecting to the postgres RDS instance

We need to store the GITPOD IP on a environment variable so we can add it to the security group inbound rules.

```bash
export GITPOD_IP=$(curl ifconfig.me)
gp env GITPOD_IP=$(curl ifconfig.me)
```
Also we need to store the Security Group ID and Security Group Rule ID for the inbound rule that let us connect to the RDS instance.

```bash
export DB_SG_ID="sg-041992f00974aac46"
gp env DB_SG_ID="sg-041992f00974aac46"

export DB_SG_RULE_ID="sgr-091b37c463f1a4388"
gp env DB_SG_RULE_ID="sgr-091b37c463f1a4388"
```

So we are going to setup the inbound rule with the GITPOD IP Address every time we run the gitpod workspace. For that we create a bash script name [rds-update-sg-rule]() with the modify rule aws command

Here is the code:

```bash
aws ec2 modify-security-group-rules \
    --group-id $DB_SG_ID \
    --security-group-rules "SecurityGroupRuleId=$DB_SG_RULE_ID,SecurityGroupRule={IpProtocol=tcp,FromPort=5432,ToPort=5432,CidrIpv4=$GITPOD_IP/32,Description=GITPOD}"
```
