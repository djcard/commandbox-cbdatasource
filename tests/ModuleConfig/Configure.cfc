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
		describe( "The configure function should", function(){
			beforeEach( function(){
				testobj = createObject( "ModuleConfig" );
				testme  = testobj.configure();
			} );
			it( "Not really do anything since there is no config", function(){
				expect( isNull( testme ) ).toBeTrue();
			} );
		} );
	}

}
