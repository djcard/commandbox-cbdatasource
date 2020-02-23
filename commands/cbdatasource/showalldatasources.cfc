/**
* The Show All Data Sources command simply outputs all the datasources which are configured in this context of your operating system.
*/
component extends="commandbox.system.BaseCommand"{
    function run(){
        allsource = getApplicationSettings();
        if(allsource.keyExists("Datasources")){
          allsource.datasources.structmap(function(source){

          })  ;
        }
        else{
            print.line("There are no datasources defined");
        }
    }
}
