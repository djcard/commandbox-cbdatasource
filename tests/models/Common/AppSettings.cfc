/**
 * My BDD Test
 */
component extends="testbox.system.BaseSpec" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	/*
	// executes before all suites+specs in the run() method
	function beforeAll(){
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}
*/

	/*********************************** BDD SUITES ***********************************/

	void function run(){
		describe( "appSettings should return a structure", function(){
			it( "should do something", function(){
				testObj = createObject( "models.Common" );
				testme  = testObj.appSettings();
				expect( testme ).toBeTypeof( "struct" );
			} );
		} );
	}

}
