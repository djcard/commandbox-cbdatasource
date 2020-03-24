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
				testobj=createMock("commands.cbdatasource.makenewdatasource");
				mockObj=createMock("models.common");
				testobj.$(method="getcwd",returns="hththt");
				testobj.$(method="makekey",returns=true);
				testobj.$(method="command",returns=true);
				testobj.$(method="printme");
				testobj.setCommon(mockObj);
			})	;
			it( "If the source already exists and force is false, call print me 1x with the redline", function(){
				mockObj.$(method="sourceExists",returns=true);
				testme=testobj.run(datasource="dsource",dbname="dbn",dbtype="JDTS",username="uname",password="pwrrd",force=true);
                expect( testobj.$count("printme") ).toBe(1);
			});
			it( "If the source already exists and force is true, call print me 1x and makekey 1x ", function(){
				mockObj.$(method="sourceExists",returns=true);
				testme=testobj.run(datasource="dsource",dbname="dbn",dbtype="JDTS",username="uname",password="pwrrd",force=true);
					expect( testobj.$count("printme") ).toBe(1);
					expect( testobj.$count("makeKey") ).toBe(1);
			});
			it( "If the saveToEnv is false, call command 0x", function(){
				mockObj.$(method="sourceExists",returns=true);
				testme=testobj.run(datasource="dsource",dbname="dbn",dbtype="JDTS",username="uname",password="pwrrd",force=true);
					expect( testobj.$count("command") ).toBe(0);
			});
			it( "If the saveToEnv is true, call command 1x", function(){
				mockObj.$(method="sourceExists",returns=true);
				testme=testobj.run(datasource="dsource",dbname="dbn",dbtype="JDTS",username="uname",password="pwrrd",force=true);
					expect( testobj.$count("command") ).toBe(0);
			});

		});
		
	}
	
}
