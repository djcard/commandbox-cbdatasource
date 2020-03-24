component accessors="true" {
    property name="common" inject="Common@cbdatasource";
    classMapping={
        "org.gjt.mm.mysql.Driver":"MYSQL",
        "com.microsoft.sqlserver.jdbc.SQLServerDriver":"MSSQL",
        "net.sourceforge.jtds.jdbc.Driver":"JTDS",
        "com.mysql.cj.jdbc.Driver":"MYSQL",
        "com.mysql.jdbc.Driver":"MYSQL"
    };

    function run(required string name,string type){
            if(!common.sourceExists(name)){
                printme("The datasource #name# does not exist");
                return;
            }

            var appsettings = common.appSettings();

            var currentDatasource = appsettings.keyExists("datasources")
                ? appSettings.datasources.keyExists(name)
                    ? appsettings.datasources[name]
                    : {}
                : {};

            if(!currentDatasource.keyExists("class") or !currentDatasource.keyExists("connectionString")){
                printme("The datasource returned from the system is incomplete");
                return;
            }

            type = isNull(type)
                    ? determineType(currentDatasource.class)
                    : type;

            if(isnull(type) or issimplevalue(type) and type.len() eq 0){
                printme("we could not determine the type of db this is");
                return;
            }

            var dbname=parseConnectionString(currentDatasource.connectionString,type);
            printme("This is a #type# Database");
            command("cbenvvar set DB_DATABASE #dbname#").run();
            command("cbenvvar set DB_PASSWORD #currentDatasource.keyexists('password') ? currentDatasource.password : ''#").run();
            command("cbenvvar set DB_USER #currentDatasource.keyExists('username') ? currentDatasource.username : ''#").run();
            command("cbenvvar set").params(name="DB_CONNECTIONSTRING",value="#currentDatasource.keyExists('connectionString') ? currentDatasource.connectionString : ''#").run();
            command("cbenvvar set DB_CLASS #currentDatasource.keyExists('class') ? currentDatasource.class : ''#").run();
        }

    function parseConnectionString(required string connString,type){
        switch(type){
            case "MSSQL":
                return parseMSSQLString(connString);
            case "MYSQL":
                return parseMYSQLString(connString);
            case "JTDS":
                return parseJTDSString(connString);
            default:
                return '';
        }
    }

    function determineType(class){
        return classMapping.keyExists(class) ? classMapping[class] : "";
    }

    function parseMSSQLString(connString){
        var mystruct={};
        connString.listtoarray(";").map(function(item,index){
            if(findNoCase("=",item) gt 0 and item.listlen('=') gt 1){
                mystruct[listfirst(item,'=')] = listlast(item,'=');
            }
        });

        return mystruct.KeyExists("DATABASENAME") ? mystruct.databasename : "";
    }

    function parseMYSQLString(connString){
        var dbname=connstring.listfirst("?").listlast("/");
        return isCleanDBName(dbname) ? dbname : '';
    }

    function parseJTDSString(connString){
        var dbname=connString.listLast("/");
        return isCleanDBName(dbname) ? dbname : '';
    }

    function isCleanDBName(dbname){
        var badChars=[".",",",":"];
        var charsfound = badchars.filter(function(item){
            return find(item,dbname) gt 0;
        });

        return charsfound.len() eq 0;
    }

    private void function printme(text,funcName="line"){
        print[funcName](text);
    }
}
