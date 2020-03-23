component {
    function run(name){
            var dsources = {};
            if (structKeyExists(getApplicationSettings(), 'datasources')) {
                dsources = getApplicationSettings().datasources;
            }
            var currentDatasource = dsources.keyExists(name) ? dsources[name] : {};
        print.line(currentDatasource);

        }
}
