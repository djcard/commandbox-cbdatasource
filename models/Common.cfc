/**
    * Common functions and data for cbdatasource
    */
component {
    /**
*   Centralized Data for sources
*/
    struct function coreData(){
        return {
            "mssql":{
                "class": 'com.microsoft.jdbc.sqlserver.SQLServerDriver',
                "connectionString": 'jdbc:sqlserver://#serveraddress#:#port#;DATABASENAME=#dbname#;sendStringParametersAsUnicode=true;SelectMethod=direct',
                "type":"system",
                "username":"",
                "password":""
            },
            "mysql8":{
                "class": 'com.mysql.cj.jdbc.Driver',
                "bundleName": 'com.mysql.cj',
                "bundleVersion": '8.0.15',
                "connectionString": 'jdbc:mysql://#serveraddress#:#port#/#dbname#?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true&allowMultiQueries=true',
                "username": "",
                "password": "",
                "connectionLimit":100 // default:-1
            },
            "mysql":{
                "class": 'com.mysql.jdbc.Driver',
                "bundleName": 'com.mysql.cj',
                "bundleVersion": '8.0.15',
                "connectionString": 'jdbc:mysql://#serveraddress#:#port#/#dbname#?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true&allowMultiQueries=true',
                "username": "",
                "password": "",
    // optional settings
                "connectionLimit":100 // default:-1
            },
            "h2":{
                "class": 'org.h2.Driver',
                "bundleName": 'org.h2',
                "bundleVersion": '1.3.172',
                "connectionString": 'jdbc:h2:#getCWD()#\#dbname#;MODE=MSSQL',
                "connectionLimit":100 // default:-1
            }
        };
    }
}
