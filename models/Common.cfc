/**
    * Common functions and data for cbdatasource
    */
component {
    /**
*   Centralized Data for sources
*/
    struct function coreData(dbtype, dbname, username, pwd, serverAddress, port, folder){
        return {
            "jtds":{
                    "class": 'net.sourceforge.jtds.jdbc.Driver',
                    "bundleName": "jtds",
                    "bundleVersion": "1.3.1",
                    "connectionString": "jdbc:jtds:sqlserver://#serverAddress#:#port#/#dbname#",
                    "username": "#username#",
                    "password": "#pwd#",
                    "connectionLimit":100, // default:-1
                    "validate":false // default: false
            },
            "mssql":{
                "class": 'com.microsoft.sqlserver.jdbc.SQLServerDriver',
                "connectionString": 'jdbc:sqlserver://#serveraddress#:#port#;DATABASENAME=#dbname#;sendStringParametersAsUnicode=true;SelectMethod=direct',
                "bundlename":"mssqljdbc4",
                "bundleVersion":"4.0.2206.100",
                "username":"#username#",
                "password":"#pwd#",
                "type":"MSSQL"
            },
            "mysql":{
                "class": 'com.mysql.cj.jdbc.Driver',
                "bundleName": 'com.mysql.cj',
                "bundleVersion": '8.0.15',
                "connectionString": 'jdbc:mysql://#serveraddress#:#port#/#dbname#?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true&allowMultiQueries=true',
                "username": "#username#",
                "password": "#pwd#",
                "connectionLimit":100 // default:-1
            },
            "h2":{
                "class": 'org.h2.Driver',
                "bundleName": 'org.h2',
                "bundleVersion": '1.3.172',
                "connectionString": 'jdbc:h2:#folder#\#dbname#;MODE=MSSQL',
                "connectionLimit":100 // default:-1
            }
        };
    }
}