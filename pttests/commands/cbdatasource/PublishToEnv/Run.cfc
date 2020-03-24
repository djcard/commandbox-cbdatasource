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
	
		describe( "The command should", function(){
			beforeEach(function(){
				testobj=createMock("commands.cbdatasource.publishtoenv");
				mockObj=createMock("models.common");
			});
			it( "If the datasource does not exist, run printme 1x and return", function(){
				mockObj.$(method="sourceExists",returns=false);
				testobj.$(method="command");
				testobj.$(method="printme");
				testobj.setCommon(mockObj);
				mockobj.$(method="appsettings",returns={});
				var testme=testobj.run("blah");
					expect( testObj.$count("printme") ).toBe(1);
					expect( mockObj.$count("appsettings") ).toBe(0);
			});

			it( "If the datasource does exist but doesn't receive the class or connectionstring keys, run common.appsettings 1x, annouce the problem and and exit", function(){
				testobj.$(method="sourceExists",returns=true);
				testobj.$(method="command");
				testobj.$(method="printme");
				testobj.$(method="determinetype",returns='');
				testobj.$(method="parseConnectionString",returns='');
				mockobj.$(method="appsettings",returns={});

				testobj.setCommon(mockObj);
				var testme=testobj.run("blah");
				expect( mockObj.$count("appsettings") ).toBe(1);
				expect( testobj.$count("printme") ).toBe(1);
				expect( testobj.$count("determineType") ).toBe(0);
				expect( testobj.$count("parseConnectionString") ).toBe(0);
			});

			it( "If the datasource does exist try to determine the type from the class", function(){
				mockObj.$(method="sourceExists",returns=true);
				testobj.$(method="command");
				testobj.$(method="printme");
				testobj.$(method="determinetype",returns='');
				testobj.$(method="parseConnectionString",returns='');
				mockobj.$(method="appsettings",returns={datasources:{blah:{class:"classer",connectionstring:"my string"}}});

				testobj.setCommon(mockObj);
				var testme=testobj.run("blah");
				expect( mockObj.$count("appsettings") ).toBe(1);
				expect( testObj.$count("printme") ).toBe(1);
				expect( testObj.$count("determinetype") ).toBe(1);
				expect( testObj.$count("parseconnectionstring") ).toBe(0);
			});

			it( "If the datasource does exist and the structure returned from the system is complete, and type is determined", function(){
				mockObj.$(method="sourceExists",returns=true);
				testobj.$(method="command", returns={run:function(){},params:function(){return {run:function(){}};}});
				testobj.$(method="printme");
				testobj.$(method="determinetype",returns='MSSQL');
				testobj.$(method="parseConnectionString",returns='MYDB');
				mockobj.$(method="appsettings",returns={datasources:{"blah":{class:"classer",connectionString:""}}});

				testobj.setCommon(mockObj);

				var testme=testobj.run("blah");
				expect( testObj.$count("printme") ).toBe(1);
				expect( testObj.$count("determinetype") ).toBe(1);
				expect( mockObj.$count("appSettings") ).toBe(1);
			});
		});
		
	}
	
}
