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
		describe( "The sourceExists function should", function(){
			beforeEach(function(){
				testObj=createMock("models.Common");
			});
			it( "return false if there are no datasources in the system", function(){
				testObj.$(method="appSettings",returns={});
				testme=testObj.sourceExists("yo");
                expect( testme ).toBeFalse();
			});
			
			it( "There are datasources but the one submitted doesn't exist in the system", function(){
				testObj.$(method="appSettings",returns={datasources:{myd:{}}});
				testme=testObj.sourceExists("yo");
					expect( testme ).toBeFalse();
			});
			it( "There are datasources and the one submitted exists", function(){
				testObj.$(method="appSettings",returns={datasources:{yo:{}}});
				testme=testObj.sourceExists("yo");
					expect( testme ).tobetrue();
			});

		});
		
	}
	
}
