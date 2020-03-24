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
	
		describe( "The MakeKey Function should", function(){
			beforeEach(function(){
				testobj=createMock("commands.cbdatasource.makenewdatasource");
				testobj.$(method="command",returns=true);
				testobj.$(method="printme");
				MakePublic(testobj,"makekey","makekeypublic");

				mockObj=createMock("models.common");

			});
			it( "Return false if the datasource is blank and call printme 1x", function(){
				testobj.$(method="makeDsourceStruct",returns={});
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makekeypublic({dbtype:"",
					dbname:"",
					username:"",
					password:"",
					serveraddress:"",
					port:"",
					folder:"",
					addlstring:"",
					datasource:""
				});
				expect( testme ).toBeFalse();
				expect( testObj.$count("printme") ).toBe(1);
			});

			it( "If the datasource is not blank but it is not supported, return false", function(){
				testobj.$(method="makeDsourceStruct",returns={});
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makekeypublic({dbtype:"",
					dbname:"",
					username:"",
					password:"",
					serveraddress:"",
					port:"",
					folder:"",
					addlstring:"",
					datasource:"OtherThings"
				});
					expect( testme ).toBeFalse();
					expect( mockObj.$count("appsettings") ).toBe(0);
			});

			it( "If the datatype is not blank but the dbtype is not supported, return false", function(){
				testobj.$(method="makeDsourceStruct",returns={});
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makekeypublic({
					dbtype:"JDTS",
					dbname:"",
					username:"",
					password:"",
					serveraddress:"",
					port:"",
					folder:"",
					addlstring:"",
					datasource:"otherthing"
				});
					expect( testme ).toBeFalse();
					expect( mockObj.$count("appsettings") ).toBe(0);
			});

			it( "If the datatype is not blank and the dbtype is supported, call makeDsourceStruct 1x, call appsettings 1x and return true", function(){
				testobj.$(method="makeDsourceStruct",returns={jtds:{}});
				mockObj.$(method="appSettings",returns={});
				testobj.setCommon(mockObj);
				testme=testObj.makekeypublic({
					dbtype:"JTDS",
					dbname:"",
					username:"",
					password:"",
					serveraddress:"",
					port:"",
					folder:"",
					addlstring:"",
					datasource:"otherthing"
				});
				expect(testObj.$count("makeDsourceStruct")).tobe(1);
				//expect( mockObj.$count("appSettings") ).toBe(1);
				expect( testme ).toBeTrue();

			});
		});
		
	}
	
}
