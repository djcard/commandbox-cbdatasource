/**
 * The Show All Data Sources command simply outputs all the datasources which are configured in this context of your operating system.
 */
component extends="commandbox.system.BaseCommand" {

    /**
     * The entry point to the command
     */
    void function run(boolean verbose = false ) {
        var allsources = getApplicationSettings();
        // print.line(allsource);
        if (allsources.keyExists('Datasources')) {
            print.line('There are #allsources.datasources.len()# datasources in the system');
            allsources.datasources.map(function(key,item) {
                if(verbose){
                    print.line(item);
                }
                else{
                    print.line(key);
                }

            });
        } else {
            print.line('There are no datasources defined');
        }
    }

}
