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
		describe( "The Command Should", function(){
			beforeEach( function(){
				testobj = createMock( "commands.cbdatasource.ShowDataSources" );
				testobj.$( method = "command", returns = true );
				mockCommon = createMock( "models.common" );
				mockCommon.$( method = "printme", returns = mockCommon );

				mockPrint = createEmptyMock( "models.common" );
				mockPrint.$( method = "line", returns = mockPrint );
				mockPrint.$( method = "redLine", returns = mockPrint );
				mockPrint.$( method = "toConsole", returns = mockPrint );
			} );
			it( "If there are is no datasources key, call appSettings 1x and printme 1x", function(){
				mockCommon.$( method = "appSettings", returns = {} );
				testobj.setCommon( mockCommon );
				testme = testObj.run();
				expect( mockCommon.$count( "appSettings" ) ).tobe( 1 );
				expect( mockCommon.$count( "printme" ) ).tobe( 1 );
			} );

			it( "If there is a datasources key but no datasources, call appSettings 1x and printme 1x", function(){
				mockCommon.$( method = "appSettings", returns = { datasources : {} } );
				testobj.setCommon( mockCommon );
				testme = testObj.run();
				expect( mockCommon.$count( "appSettings" ) ).tobe( 1 );
				expect( mockCommon.$count( "printme" ) ).tobe( 1 );
			} );
			it( "If there is a datasources key and datasources and if verbose is false, call appSettings 1x and printme 1x + 1x for each datasource", function(){
				mockCommon.$(
					method  = "appSettings",
					returns = { datasources : { first : {}, second : {}, third : {} } }
				);
				testobj.setCommon( mockCommon );
				testme = testObj.run();
				expect( mockCommon.$count( "appSettings" ) ).tobe( 1 );
				expect( mockCommon.$count( "printme" ) ).tobe( 4 );
			} );
			it( "If there is a datasources key and datasources and if verbose is true, call appSettings 1x and printme 1x +  2x for each datasource", function(){
				mockCommon.$(
					method  = "appSettings",
					returns = { datasources : { first : {}, second : {}, third : {} } }
				);
				testobj.setCommon( mockCommon );
				testme = testObj.run( verbose = true );
				expect( mockCommon.$count( "appSettings" ) ).tobe( 1 );
				expect( mockCommon.$count( "printme" ) ).tobe( 7 );
			} );
		} );
	}

}
