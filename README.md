# cbdatasource
A CommandBox module which can add a datasource to the CommandBox Engine which 
allows Commands and Modules to interact with a database. 

Currently supports JTDS, MSSQL, MYSQL and H2

Tested on CommandBox 5.0.1+00137

Installation: `box install cbdatasource`

**Usage**

Command: cbdatasource MakeNewDatasource

**Parameters**

    **dbtype**: The type of database / driver (JTDS,MSSQL, MYSQL)  
    **datasource**: name of the datasource  
    **serveraddress**: The address of the database (IP or FQDN, defaults to 127.0.0.1)  
    **port**: Port to access the DB (If not submitted, tries to determine from DBtype 3389 for MySQL)  
    **username**: Login Username  
    **password**: Login password. Does not store password anywhere. Simply passes on to the CommandBox engine.   
    **folder**: Used with H2 to indicate where the db should be made.   
       
**Drivers and Bundles**  
JTDS: net.sourceforge.jtds.jdbc.Driver and Bundle 1.3.1  
MSSQL: com.microsoft.sqlserver.jdbc.SQLServerDriver and Bundle 4.0.2206.100  
MySQL: com.mysql.cj.jdbc.Driver (Compatabile with MySQL 8)  
H2: org.h2.Driver and defaults to MSSQL mode.   

Notes: If a datasource of the same name already exists, it will not be overwritten without the --force flag.  
Datasources do not persist after CB has been closed.
