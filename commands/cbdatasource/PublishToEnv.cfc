component {
    function run(name){
            var dsources = {};
            if (structKeyExists(getApplicationSettings(), 'datasources')) {
                dsources = getApplicationSettings().datasources;
            }
            var currentDatasource = dsources.keyExists(name) ? dsources[name] : {};
            command("cbenvvar set DB_PASSWORD #currentDatasource.password#").run();
            command("cbenvvar set DB_USER #currentDatasource.username#").run();
            command("cbenvvar set DB_CONNECTIONSTRING #currentDatasource.connectionString#").run();
            command("cbenvvar set DB_CLASS #currentDatasource.class#").run();
        print.line(currentDatasource);

        }

    function parseConnectionString(required string connString){
        
    }
}
