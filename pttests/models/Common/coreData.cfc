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
				username="un";
				pwd="passw";
				dbname="dn";
				serverAddress="ServA";
				testObj=createObject("models.Common");
			});
			it( "If the key exists, it should return a structure", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
                expect( testme ).toBetypeof("struct");
			});
			
			it( "Each Type except h2 returned should have the key username which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
				testme.filter(function(item){
					return item neq 'h2';
				}).map(function(item,value){
						expect( value ).tohaveKey("username");
					expect(value.username).tobe(username);
				});
			});
			it( "Each Type except h2 returned should have the key password which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
					testme.filter(function(item){
						return item neq 'h2';
					}).map(function(item,value){
						expect( value ).tohaveKey("password");
						expect(value.password).tobe(pwd);
				});
			});
			it( "Each Type except h2 returned should have the key bundlename which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
					testme.filter(function(item){
						return item neq 'h2';
					}).map(function(item,value){
						expect( value ).tohaveKey("bundlename");
				});
			});
			it( "Each Type except h2 returned should have the key bundleVersion which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
					testme.filter(function(item){
						return item neq 'h2';
					}).map(function(item,value){
						expect( value ).tohaveKey("bundleVersion");
				});
			});
			it( "Each Type except h2 returned should have the key class which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
					testme.filter(function(item){
						return item neq 'h2';
					}).map(function(item,value){
						expect( value ).tohaveKey("class");
				});
			});
			it( "Each Type except h2 returned should have the key connectionString which matches the input", function(){
				testme=testObj.coreData(dbname=dbname,username=username,pwd=pwd,serverAddress=serverAddress,port=1,folder='fold',addlstring='AddMe');
					testme.filter(function(item){
						return item neq 'h2';
					}).map(function(item,value){
						expect( value ).tohaveKey("connectionString");
				});
			});
		});
		
	}
	
}
