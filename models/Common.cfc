/**
 * Common functions and data for cbdatasource
 */
component accessors="true"{
    property name="base" inject="BaseCommand";
    property name="print" inject="PrintBuffer";
    /**
     *   Centralized Data for sources
     * @dbname The name of the database on the server
     * @username The username used to access the database
     * @pwd The password used to access the database
     * @serveraddress The IP or FQDN of the server
     * @port The port at the serveraddress. Defaults to 1433 for MSSQL
     * @folder For file based dbs like h2. The folder where the file (dbname) exists or should be created.
     * @addlstring For extra paramters for the connection string
     */
    struct function coreData(
        required string dbname,
        required string username,
        required string pwd,
        string serverAddress = '127.0.0.1',
        numeric port = 0,
        string folder = '',
        string addlstring=''
    ) {
        return {
            'jtds': {
                'class': 'net.sourceforge.jtds.jdbc.Driver',
                'bundleName': 'jtds',
                'bundleVersion': '1.3.1',
                'connectionString': 'jdbc:jtds:sqlserver://#serverAddress#:#port#/#dbname#',
                'username': '#username#',
                'password': '#pwd#',
                'connectionLimit': 100, // default:-1
                'validate': false // default: false
            },
            'mssql': {
                'class': 'com.microsoft.sqlserver.jdbc.SQLServerDriver',
                'connectionString': 'jdbc:sqlserver://#serveraddress#:#port#;DATABASENAME=#dbname#;sendStringParametersAsUnicode=true;SelectMethod=direct',
                'bundlename': 'mssqljdbc4',
                'bundleVersion': '4.0.2206.100',
                'username': '#username#',
                'password': '#pwd#',
                'connectionLimit': 100 // default:-1
            },
            'mysql': {
                'class': 'com.mysql.cj.jdbc.Driver',
                'bundleName': 'com.mysql.cj',
                'bundleVersion': '8.0.15',
                'connectionString': 'jdbc:mysql://#serveraddress#:#port#/#dbname#?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true&#addlstring#',
                'username': '#username#',
                'password': '#pwd#',
                'connectionLimit': 100 // default:-1
            },
            'h2': {
                'class': 'org.h2.Driver',
                'bundleName': 'org.h2',
                'bundleVersion': '1.3.172',
                'connectionString': 'jdbc:h2:#folder#\#dbname#;MODE=MSSQL',
                'connectionLimit': 100 // default:-1
            }
        };
    }

/*
* Checks to see if the datasource already exists
* @dsourceName The name of the datasource to check
*/

    boolean function sourceExists(required string dsourceName) {
        var dsources = appSettings();
        if (not structKeyExists(dsources, 'datasources')) {
            return false;
        }
        if (not structKeyExists(dsources.datasources, dsourceName)) {
            return false;
        }
        return true;
    }

    struct function appSettings(){
        return getApplicationSettings();
    }

/*
*   Seperated out commandline printing for testing purposes
* @text What text to display
* @styleName The formatting for the output in the format of redLine
*/
    void function printme(any text = '', string styleName = 'line') {
            print[styleName](text).toConsole();
    }
}
