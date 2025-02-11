/**
 * The Show All Data Sources command simply outputs all the datasources which are configured in this context of your operating system.
 */
component accessors="true" {

	property name="common" inject="Common@cbdatasource";
	/**
	 * The entry point to the command
	 *
	 * @verbose Defaults to false which displays the name of the datasource alone. A True value displays the actual datasource itself.
	 */
	void function run( boolean verbose = false ){
		var allsources = common.appSettings();
		if ( allsources.keyExists( "Datasources" ) ) {
			common.printme( "There are #allsources.datasources.len()# datasources in the system" );
			allsources.datasources.map( function( key, item ){
				common.printme( key );
				if ( verbose ) {
					common.printme( item );
				}
			} );
		} else {
			common.printme( "There are no datasources defined" );
		}
	}

}
