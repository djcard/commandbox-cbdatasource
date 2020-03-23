component {
    property name="common" inject="Common@cbdatasource";
    classMapping={
        "org.gjt.mm.mysql.Driver":"MYSQL",
        "com.microsoft.sqlserver.jdbc.SQLServerDriver":"MSSQL",
        "net.sourceforge.jtds.jdbc.Driver":"MSSQL",
        "com.mysql.cj.jdbc.Driver":"MYSQL",
        "com.mysql.jdbc.Driver":"MYSQL"
    };

    function run(name,type){
            if(!common.sourceExists(name)){
                print.line("The datasource #name# does not exist");
                return;
            }

            var dsources = {};
            if (structKeyExists(getApplicationSettings(), 'datasources')) {
                dsources = getApplicationSettings().datasources;
            }
            var currentDatasource = dsources.keyExists(name) ? dsources[name] : {};
            type = isNull(type) ? determineType(currentDatasource.class) : type;
            var dbname=parseConnectionString(currentDatasource.connectionString,type);
            print.line("This is a #type# Database");
            command("cbenvvar set DB_DATABASE #dbname#").run();
            command("cbenvvar set DB_PASSWORD #currentDatasource.password#").run();
            command("cbenvvar set DB_USER #currentDatasource.username#").run();
            command("cbenvvar set").params(name="DB_CONNECTIONSTRING",value="#currentDatasource.connectionString#").run();
            command("cbenvvar set DB_CLASS #currentDatasource.class#").run();


        }

    function parseConnectionString(required string connString,type){
        switch(type){
            case "MSSQL":
                return parseMSSQLString(connString);
            break;
        }
    }

    function determineType(class){
        return classMapping.keyExists(class) ? classMapping[class] : "";
    }

    function parseMSSQLString(connString){
        var mystruct={};
        connString.listtoarray(";").map(function(item,index){
            if(findNoCase("=",item) gt 0){
                mystruct[listfirst(item,'=')] = listlast(item,'=');
            }
        });

        return mystruct.KeyExists("DATABASENAME") ? mystruct.databasename : "";
    }
}
