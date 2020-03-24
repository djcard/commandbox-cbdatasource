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

		describe( "My test Suite", function(){
			beforeEach(function(){
				testobj=createMock("commands.cbdatasource.makenewdatasource");
				mockObj=createMock("models.common");
				testobj.$(method="getcwd",returns="hththt");
				testobj.$(method="makekey",returns=true);
				testobj.$(method="command",returns=true);
				testobj.$(method="printme");
				mockObj.$(method="sourceExists",returns=false);
				testobj.setCommon(mockObj);
				testme=testobj.run(datasource="dsource",dbname="dbn",dbtype="JDTS",username="uname",password="pwrrd");
			})	;
			it( "should do something", function(){
                expect( testobj.$count("makekey") ).toBe(5);
			});
			
			it( "should do something else", function(){
                expect( false ).toBeTrue();
			});
			
		});
		
	}
	
}
