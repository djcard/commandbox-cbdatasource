/**
 * The Show All Data Sources command simply outputs all the datasources which are configured in this context of your operating system.
 */
component accessors="true"{
    property name="common" inject="Common@cbdatasource";
    /**
     * The entry point to the command
     */
    void function run(boolean verbose = false ) {
        var allsources = common.appSettings();
        if (allsources.keyExists('Datasources')) {
            printme('There are #allsources.datasources.len()# datasources in the system');
            allsources.datasources.map(function(key,item) {
                printme(key);
                if(verbose){
                    printme(item);
                }

            });
        } else {
            printme('There are no datasources defined');
        }
    }

    private void function printme(text,funcName="line"){
        print[funcName](text);
    }

}
