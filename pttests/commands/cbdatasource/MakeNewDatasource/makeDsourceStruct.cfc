/**
* My BDD Test
*/
component extends="testbox.system.BaseSpec"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
	
		describe( "MakeDsourceStruct should", function(){
			beforeEach(function(){
				testobj=createMock("commands.cbdatasource.makenewdatasource");
				testobj.$(method="command",returns=true);
				testobj.$(method="printme");
				MakePublic(testobj,"makeDsourceStruct","makeDsourceStructpublic");

				mockObj=createMock("models.common");

			});
			it( "return a struct and call printme 1x", function(){
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makeDsourceStructpublic(
					dbtype="",
					dbname="",
					username="",
					pwd="",
					serveraddress="",
					port="0",
					folder="",
					addlstring="",
					datasource=""
				);
					expect( testme ).toBeTypeOf("Struct");
			});
			it( "call common.coreData 1x", function(){
				mockObj.$(method="coreData",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makeDsourceStructpublic(
					dbtype="",
					dbname="",
					username="",
					pwd="",
					serveraddress="",
					port="0",
					folder="",
					addlstring="",
					datasource=""
						);
					expect( mockObj.$count("coreData") ).toBe(1);
			});
			it( "call printme 1x", function(){
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makeDsourceStructpublic(
					dbtype="",
					dbname="",
					username="",
					pwd="",
					serveraddress="",
					port="0",
					folder="",
					addlstring="",
					datasource=""
						);
					expect( testObj.$count("printme") ).toBe(1);
			});
			it( "If the dbtype is not supported, return a struct with 0 keys", function(){
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makeDsourceStructpublic(
					dbtype="",
					dbname="",
					username="",
					pwd="",
					serveraddress="",
					port="0",
					folder="",
					addlstring="",
					datasource=""
						);
					expect( testme.keylist().listlen() ).toBe(0);
			});
			it( "If the dbtype is supported, return a struct with 1 key", function(){
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makeDsourceStructpublic(
					dbtype="JTDS",
					dbname="",
					username="",
					pwd="",
					serveraddress="",
					port="0",
					folder="",
					addlstring="",
					datasource=""
						);
					expect( testme.keylist().listlen() ).toBe(1);
			});
		});
		
	}
	
}
