/**
 * Used to make a new password for CommandBox, itself, to access datasources. To save the setting to either
 */
component {
    dbports = {
        "JTDS":1433,
        "MSSQL": 1433,
        "MySQL":3389
    };
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
     * @port The port at the serveraddress. Defaults to 0 but tries to determine port from dbtype
     * @folder For file based dbs like h2. The folder where the file (dbname) exists or should be created.
     * @addlstring Additional parameters for the connection string (see database documentation)
     * @force By default, if the datasource already exists, it will not overwrite it. Force will make it do so.
     **/
    void function run(
        required string datasource,
        required string dbname,
        required string dbtype,
        required string username,
        required string password,
        string serveraddress = '127.0.0.1',
        numeric port = 0,
        string folder = getcwd(),
        string addlstring = '',
        boolean force = false,
        boolean saveToEnvFile=false
    ) {

        port = port neq 0 ? port : dbports.keyExists(dbtype) ? dbports[dbtype] : 0;


        if (common.sourceExists(dsourceName = dataSource) and !force) {
            print.redLine('That datasource Already exists. Use force=true to overwrite.');
        } else {
            makekey(arguments);
            print.line('DataSource Made');
        }

        if(saveToEnvFile){
            command("cbdatasource PublishToEnv #datasource#").run();
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
            args.port,
            args.folder,
            args.addlstring
        );
        var dsources = {};

        if (structKeyExists(getApplicationSettings(), 'datasources')) {
            dsources = getApplicationSettings().datasources;
        }
        dsources[args.datasource] = base[args.dbtype];
        try {
            application action="update" datasources="#dsources#";
            return true;
        } catch (any err) {
            print.line(err.message);
            return false;
        }
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
        string folder='',
        string addlstring=''
    ) {
        var dsource = common
            .coreData(dbname, username, pwd, serverAddress, port, folder, addlstring)
            .filter(function(item) {
                return item == dbtype;
            });

        print.line(dsource);
        return dsource;
    }



}