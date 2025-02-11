# CB Datasource

A CommandBox module which can add a datasource to the CommandBox Engine which
allows Commands and Modules to interact with a database.

Currently supports JTDS, MSSQL, MYSQL and H2

Tested on CommandBox 5.0.1+00137

Installation: `box install commandbox-cbdatasource`

## Usage

### Command: cbdatasource ShowDatasources

output: There are 2 datasources in the system  
--datasource1  
--datasource2  

## Command: cbdatasource MakeNewDatasource

### Parameters

    **dbtype**: The type of database / driver (JTDS,MSSQL, MYSQL)  
    **datasource**: name of the datasource  
    **serveraddress**: The address of the database (IP or FQDN, defaults to 127.0.0.1)  
    **port**: Port to access the DB (If not submitted, tries to determine from DBtype 3306 for MySQL, 1433 for MSSQL)  
    **username**: Login Username  
    **password**: Login password. Does not store password anywhere. Simply passes on to the CommandBox engine.
    **folder**: Used with H2 to indicate where the db should be made. 
       
### Drivers and Bundles

JTDS: net.sourceforge.jtds.jdbc.Driver and Bundle 1.3.1  
MSSQL: com.microsoft.sqlserver.jdbc.SQLServerDriver and Bundle 4.0.2206.100  
MySQL: com.mysql.cj.jdbc.Driver (Compatabile with MySQL 8)  

Notes: If a datasource of the same name already exists, it will not be overwritten without the --force flag.  
Datasources do not persist after CB has been closed.

## Command: cbdatasource PublishToEnv

Publishes a datasource to the .env file in the folder in which the command is run.

### Keys

DB_NAME - Name of the database
DB_USER - The user name to use to login
DB_PASSWORD - The password to the DB login
DB_CONNECTIONSTRING - The connection string for the datasource
DB_CLASS - The class used for the datasource. This is whatever is in the system, not what may or may not be listed above under Drivers and Bundles.

### Parameters

@name - the name of the datasource in the system to publish
@type - the type of the database (MSSQL, MYSQL etc). If this is not provided, it will guess based on the connection string which at the moment would be limited to MYSQL, MSSQL, or JTDS. If a type is provided, that will be used and the db can be to anything.

## Command: cbdatasource removeatasource

Removes a datasource from the CommandBox installation.

### Parameters

@datasourceName - the name of the existing datasource to delete.

## Release Notes

0.0.2 - Improve documentation accuracy

0.0.1 - Initial Release
