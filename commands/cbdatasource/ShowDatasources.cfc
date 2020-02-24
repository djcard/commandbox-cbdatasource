/**
* The Show All Data Sources command simply outputs all the datasources which are configured in this context of your operating system.
*/
component extends="commandbox.system.BaseCommand"{
    /**
* The entry point to the command
*/
    void function run(){
        var allsources = getApplicationSettings();
        //print.line(allsource);
        if(allsources.keyExists("Datasources")){
            print.line("There are #allsources.datasources.len()# datasources in the system");
          allsources.datasources.map(function(source){
            print.line(source);
          })  ;
        }
        else{
            print.line("There are no datasources defined");
        }
    }
}
