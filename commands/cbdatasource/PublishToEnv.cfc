/*
 * Takes a datasource in the current system and writes the values to a local .env file
 */
component accessors="true" {

    property name="common" inject="Common@cbdatasource";

    classMapping = {
        'org.gjt.mm.mysql.Driver': 'MYSQL',
        'com.microsoft.sqlserver.jdbc.SQLServerDriver': 'MSSQL',
        'net.sourceforge.jtds.jdbc.Driver': 'JTDS',
        'com.mysql.cj.jdbc.Driver': 'MYSQL',
        'com.mysql.jdbc.Driver': 'MYSQL'
    };

    /*
     * The entry point for the command
     * @name The name of the datasource to write
     * @type The type of database in the named datasource. If not included, will try to determine the type from the class used
     */
    void function run(required string name, string type = '') {
        if (!common.sourceExists(name)) {
            common.printme('The datasource #name# does not exist');
            return;
        }

        var appsettings = common.appSettings();

        var currentDatasource = appsettings.keyExists('datasources')
         ? appSettings.datasources.keyExists(name)
         ? appsettings.datasources[name]
         : {}
         : {};

        if (!currentDatasource.keyExists('class') or !currentDatasource.keyExists('connectionString')) {
            common.printme('The datasource returned from the system is incomplete');
            return;
        }

        type = type.len() eq 0
         ? determineType(currentDatasource.class)
         : type;

        if (type.len() eq 0) {
            common.printme('we could not determine the type of db this is');
            return;
        }

        var dbname = parseConnectionString(currentDatasource.connectionString, type);
        common.printme('This is a #type# Database');
        command('cbenvvar set DB_DATABASE #dbname#').run();
        command(
                'cbenvvar set DB_PASSWORD #currentDatasource.keyexists('password') ? currentDatasource.password : ''#'
            )
            .run();
        command(
                'cbenvvar set DB_USER #currentDatasource.keyExists('username') ? currentDatasource.username : ''#'
            )
            .run();
        command('cbenvvar set')
            .params(
                name = 'DB_CONNECTIONSTRING',
                value = '#currentDatasource.keyExists('connectionString') ? currentDatasource.connectionString : ''#'
            )
            .run();
        command('cbenvvar set DB_CLASS #currentDatasource.keyExists('class') ? currentDatasource.class : ''#').run();
    }


    /*
     * Takes the submitted connectionstring and parses it to determine the database type
     * @connString The submitted connection string
     */
    string function parseConnectionString(required string connString, required string type) {
        switch (type) {
            case 'MSSQL':
                return parseMSSQLString(connString);
            case 'MYSQL':
                return parseMYSQLString(connString);
            case 'JTDS':
                return parseJTDSString(connString);
            default:
                return '';
        }
    }

    /*
     * Determines if the submitted driver classname maps to a type
     * @class The name of the driver connection class
     */
    string function determineType(required string class) {
        return classMapping.keyExists(class) ? classMapping[class] : '';
    }

    /*
     * Parses a submitted MSSQL connectionString to get the database name
     * @connString The connection string to parse
     */
    string function parseMSSQLString(required string connString) {
        var mystruct = {};
        connString
            .listtoarray(';')
            .map(function(item, index) {
                if (findNoCase('=', item) gt 0 and item.listlen('=') gt 1) {
                    mystruct[listFirst(item, '=')] = listLast(item, '=');
                }
            });

        return mystruct.KeyExists('DATABASENAME') ? mystruct.databasename : '';
    }


    /*
     * Parses a submitted MYSQL connectionString to get the database name
     * @connString The connection string to parse
     */
    string function parseMYSQLString(required string connString) {
        var dbname = connstring.listfirst('?').listlast('/');
        return isCleanDBName(dbname) ? dbname : '';
    }

    /*
     * Parses a submitted JTDS connectionString to get the database name
     * @connString The connection string to parse
     */
    string function parseJTDSString(required string connString) {
        var dbname = connString.listLast('/');
        return isCleanDBName(dbname) ? dbname : '';
    }

    /*
     * Determines if the dbname is "clean" without any special characters such as .,:.
     * @dbname The dbname to parse
     */
    string function isCleanDBName(required string dbname) {
        var badChars = ['.', ',', ':'];
        var charsfound = badchars.filter(function(item) {
            return find(item, dbname) gt 0;
        });

        return charsfound.len() eq 0;
    }

}
