component {
    classMapping={
        "org.gjt.mm.mysql.Driver":"MYSQL",
        "com.microsoft.sqlserver.jdbc.SQLServerDriver":"MSSQL",
        "net.sourceforge.jtds.jdbc.Driver":"MSSQL",
        "com.mysql.cj.jdbc.Driver":"MYSQL",
        "com.mysql.jdbc.Driver":"MYSQL"
    };

    function run(name,type){
            var dsources = {};
            if (structKeyExists(getApplicationSettings(), 'datasources')) {
                dsources = getApplicationSettings().datasources;
            }
            var currentDatasource = dsources.keyExists(name) ? dsources[name] : {};
            type = isNull(type) ? determineType(currentDatasource.class) : type;
            print.line("This is a #type# Database");
            command("cbenvvar set DB_PASSWORD #currentDatasource.password#").run();
            command("cbenvvar set DB_USER #currentDatasource.username#").run();
            command("cbenvvar set DB_CONNECTIONSTRING #currentDatasource.connectionString#").run();
            command("cbenvvar set DB_CLASS #currentDatasource.class#").run();
        print.line(currentDatasource);

        }

    function parseConnectionString(required string connString,type){

    }

    function determineType(class){
        return classMapping.keyExists(class) ? classMapping[class] : "";
    }
}
