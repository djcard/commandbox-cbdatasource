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

    void function run() {
        describe('My test Suite', function() {
            beforeEach(function() {
                testobj = createMock('commands.cbdatasource.publishtoenv');
            });
            it('If the type is MSSQL, run parseMSSQLString 1x', function() {
                testobj.$(method = 'parseMSSQLString', returns = 'YESSIR');
                var testme = testobj.parseConnectionString('mysting', 'MSSQL');
                expect(testobj.$count('parseMSSQLString')).toBe(1);
            });

            it('If the type is MYSQL, run parseMYSQLString 1x', function() {
                testobj.$(method = 'parseMYSQLString', returns = 'YESSIR');
                var testme = testobj.parseConnectionString('mysting', 'MYSQL');
                expect(testobj.$count('parseMYSQLString')).toBe(1);
            });
            it('If the type is MSSQL, run parseJTDSString 1x', function() {
                testobj.$(method = 'parseJTDSString', returns = 'YESSIR');
                var testme = testobj.parseConnectionString('mysting', 'JTDS');
                expect(testobj.$count('parseJTDSString')).toBe(1);
            });
        });
    }

}
