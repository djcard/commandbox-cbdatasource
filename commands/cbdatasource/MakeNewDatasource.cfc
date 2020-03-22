/**
 * Used to make a new password for CommandBox, itself, to access datasources. To save the setting to either
 */
component {

    property name="moduleSettings" inject="commandbox:moduleSettings:KIMModel";
    property name="Common" inject="Common@cbdatasource";
    /**
     * @datasource.hint The name of the datasource you are creating
     * @dbname.hint The name of the database on the server
     * @dbtype.hint The type of DB (Press Tab for options)
     * @dbtype.options MSSQL
     * @username.hint The username used to access the database
     * @password.hint The password used to access the database
     * @scriptname.hint The name or path and name of the desired script. Use this\scriptname for this folder
     **/
    function run(
        required string datasource,
        required string dbname,
        required string dbtype,
        required string username,
        required string password,
        string serveraddress = '127.0.0.1',
        numeric port = 1433,
        boolean force = false
    ) {
        if (sourceExists(dsourceName = dataSource) and force eq false) {
            print.redLine('That datasource Already exists. Use force=true to overwrite.');
        } else {
            makekey(arguments);
            print.line('DataSource Made');
        }
    }

    function makeKey(struct args) {
        base = makeDsourceStruct(
            args.dbtype,
            args.dbname,
            args.username,
            args.password,
            args.serveraddress,
            args.port
        );
        dsources = {};

        if (structKeyExists(getApplicationSettings(), 'datasources')) {
            dsources = getApplicationSettings().datasources;
        }
        variables.dsources[args.datasource] = base;
        try {
            application action="update" datasources="#variables.dsources#";
        } catch (any err) {
            print.line(err.message);
        }
    }


    private function sourceExists(required string dsourceName) {
        dsources = getApplicationSettings();
        if (not structKeyExists(dsources, 'datasources')) {
            return false;
        }
        if (not structKeyExists(dsources.datasources, dsourceName)) {
            return false;
        }
        return true;
    }

    private function makeDsourceStruct(
        required string dbtype,
        required string dbname,
        required string username,
        required string pwd,
        string serverAddress = '127.0.0.1',
        numeric port = 1433
    ) {
        var baseObject = Common
            .coreData()
            .structFilter(function(item) {
                return item = dbtype;
            });

        print.line(baseObject);



        /*
        if(structkeyexists(retme, dbtype)) {
            return retme[dbtype];
        }
        else {
            return false;
        }
        */
    }

}

/*
retme = {
            mssql:{
                class: 'com.microsoft.jdbc.sqlserver.SQLServerDriver',
                connectionString: 'jdbc:sqlserver://#serveraddress#:#port#;DATABASENAME=#dbname#;sendStringParametersAsUnicode=true;SelectMethod=direct',
                type:"system",
                username:username,
                password:pwd
            },
            mysql:{
                class: 'com.mysql.cj.jdbc.Driver'
                , bundleName: 'com.mysql.cj'
                , bundleVersion: '8.0.15'
                , connectionString: 'jdbc:mysql://#serveraddress#:#port#/#dbname#?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true&allowMultiQueries=true'
                , username: username
                , password: pwd
                // optional settings
                , connectionLimit:100 // default:-1
            },
            h2:{
                    class: 'org.h2.Driver'
                    , bundleName: 'org.h2'
                    , bundleVersion: '1.3.172'
                    , connectionString: 'jdbc:h2:#getCWD()#\#dbname#;MODE=MSSQL'
                    , connectionLimit:100 // default:-1
                }
        };
*/