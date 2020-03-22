/**
 * Used to make a new password for CommandBox, itself, to access datasources. To save the setting to either
 */
component {

    //property name="moduleSettings" inject="commandbox:moduleSettings:cbdatasource";
    property name="common" inject="Common@cbdatasource";
    /**
     * @datasource The name of the datasource you are creating
     * @dbname The name of the database on the server
     * @dbtype The type of DB (Press Tab for options)
     * @dbtype.options MSSQL,JTDS,MYSQL,H2
     * @username The username used to access the database
     * @password The password used to access the database
     * @serveraddress The IP or FQDN of the server
     * @port The port at the serveraddress. Defaults to 1433 for MSSQL
     * @folder For file based dbs like h2. The folder where the file (dbname) exists or should be created.
     * @force By default, if the datasource already exists, it will not overwrite it. Force will make it do so.
     **/
    void function run(
        required string datasource,
        required string dbname,
        required string dbtype,
        required string username,
        required string password,
        string serveraddress = '127.0.0.1',
        numeric port = 1433,
        string folder = getcwd(),
        boolean force = false
    ) {
        if (sourceExists(dsourceName = dataSource) and !force) {
            print.redLine('That datasource Already exists. Use force=true to overwrite.');
        } else {
            makekey(arguments);
            print.line('DataSource Made');
        }
    }

    /*
    * Creates and Adds the datasource to Command Box
    * @args A Structure that is the arguments passed in to run() (above)
    */

    private boolean function makeKey(required struct args) {
        var base = makeDsourceStruct(
            args.dbtype,
            args.dbname,
            args.username,
            args.password,
            args.serveraddress,
            args.port
        );
        var dsources = {};

        if (structKeyExists(getApplicationSettings(), 'datasources')) {
            dsources = getApplicationSettings().datasources;
        }
        dsources[args.datasource] = base[args.dbtype];
        try {
            print.line("60");
            application action="update" datasources="#dsources#";
            print.line("62");
            return true;
        } catch (any err) {
            print.line(err.message);
            return false;
        }
    }

    /*
    * Checks to see if the datasource already exists
    * @dsourceName The name of the datasource to check
    */

    private boolean function sourceExists(required string dsourceName) {
        var dsources = getApplicationSettings();
        if (not structKeyExists(dsources, 'datasources')) {
            return false;
        }
        if (not structKeyExists(dsources.datasources, dsourceName)) {
            return false;
        }
        return true;
    }


    /*
    * Creates the Datasource Structure
    * @dbtype The type of database submitted
    * @dbname The new Database Name
    * @username The username to log in
    * @pwd The db password
    * @serverAddress Defaults to 127.0.0.1
    * @port DEfaults to 1433 for MSSQL
    * @folder Defaults to ''. Used for file based dbs
    */

    private struct function makeDsourceStruct(
        required string dbtype,
        required string dbname,
        required string username,
        required string pwd,
        string serverAddress = '127.0.0.1',
        numeric port = 1433,
        string folder=''
    ) {
        var dsource = common
            .coreData(dbtype, dbname, username, pwd, serverAddress, port, folder)
            .filter(function(item) {
                return item == dbtype;
            });

        print.line(dsource);
        return dsource;
    }

}