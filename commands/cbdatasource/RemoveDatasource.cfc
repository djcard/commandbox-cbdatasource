/*
 * Accepts the name of a datasource and removes it from the CommandBox CLI
 */
component {

	property name="common" inject="Common@cbdatasource";

	/*
	 * The entry point for the command
	 * @datasourceName The name of the datasource needing removal. Use cbdatasource showDatasources --verbose to get a detailed list if needed
	 */
	public boolean function run( required string datasourceName ){
		if ( !common.sourceExists( datasourceName ) ) {
			print.line( "That datasource doesn't seem to exist" );
			return;
		}

		var allsettings = common.appsettings();
		print.line( allsettings );
		var dsources = allsettings.keyExists( "datasources" ) ? allsettings.datasources : {};
		dsources.delete( datasourceName );
		try {
			application action="update" datasources="#dsources#";
			return true;
		} catch ( any err ) {
			printme( err.message );
			return false;
		}
	}

}
