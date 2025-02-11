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
		describe( "makeDsourceInfo should", function(){
			beforeEach( function(){
				testobj = createMock( "commands.cbdatasource.makenewdatasource" );
				testobj.$( method = "command", returns = true );
				testobj.$( method = "printme" );
				makePublic(
					testobj,
					"makeDsourceInfo",
					"makeDsourceInfopublic"
				);

				mockCommon = createMock( "models.common" );
				mockCommon.$( method = "printme", returns = mockCommon );

				mockPrint = createEmptyMock( "models.common" );
				mockPrint.$( method = "line", returns = mockPrint );
				mockPrint.$( method = "redLine", returns = mockPrint );
				mockPrint.$( method = "toConsole", returns = mockPrint );
			} );
			it( "return a struct and call printme 1x", function(){
				mockCommon.$( method = "appSettings", returns = {} );
				mockCommon.setPrint( mockPrint );
				testobj.setCommon( mockCommon );
				testme = testObj.makeDsourceInfopublic(
					dbtype        = "",
					dbname        = "",
					username      = "",
					pwd           = "",
					serveraddress = "",
					port          = "0",
					folder        = "",
					addlstring    = "",
					datasource    = ""
				);
				expect( testme ).toBeTypeOf( "Struct" );
			} );
			it( "call common.coreData 1x", function(){
				mockCommon.$( method = "coreData", returns = {} );
				mockCommon.setPrint( mockPrint );
				testobj.setCommon( mockCommon );
				testme = testObj.makeDsourceInfopublic(
					dbtype        = "",
					dbname        = "",
					username      = "",
					pwd           = "",
					serveraddress = "",
					port          = "0",
					folder        = "",
					addlstring    = "",
					datasource    = ""
				);
				expect( mockCommon.$count( "coreData" ) ).toBe( 1 );
			} );
			it( "call printme 1x", function(){
				mockCommon.$( method = "appSettings", returns = {} );
				mockCommon.setPrint( mockPrint );
				testobj.setCommon( mockCommon );
				testme = testObj.makeDsourceInfopublic(
					dbtype        = "",
					dbname        = "",
					username      = "",
					pwd           = "",
					serveraddress = "",
					port          = "0",
					folder        = "",
					addlstring    = "",
					datasource    = ""
				);
				expect( mockCommon.$count( "printme" ) ).toBe( 1 );
			} );
			it( "If the dbtype is not supported, return a struct with 0 keys", function(){
				mockCommon.$( method = "appSettings", returns = {} );
				mockCommon.setPrint( mockPrint );
				testobj.setCommon( mockCommon );
				testme = testObj.makeDsourceInfopublic(
					dbtype        = "",
					dbname        = "",
					username      = "",
					pwd           = "",
					serveraddress = "",
					port          = "0",
					folder        = "",
					addlstring    = "",
					datasource    = ""
				);
				expect( testme.keylist().listlen() ).toBe( 0 );
			} );
			it( "If the dbtype is supported, return a struct with 1 key", function(){
				mockCommon.$( method = "appSettings", returns = {} );
				mockCommon.setPrint( mockPrint );
				testobj.setCommon( mockCommon );
				testme = testObj.makeDsourceInfopublic(
					dbtype        = "JTDS",
					dbname        = "",
					username      = "",
					pwd           = "",
					serveraddress = "",
					port          = "0",
					folder        = "",
					addlstring    = "",
					datasource    = ""
				);
				expect( testme.keylist().listlen() ).toBe( 1 );
			} );
		} );
	}

}
