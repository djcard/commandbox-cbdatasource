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
        describe('The parseMSSQLString function should', function() {
            beforeEach(function() {
                testobj = createObject('commands.cbdatasource.publishtoenv');
            });
            it('If there is a DATABASENAME property in the string it should extract that value and return', function() {
                testme = testobj.parseConnectionString(
                    'jdbc:sqlserver://127.0.0.1:1433;DATABASENAME=bridgeplugin;sendStringParametersAsUnicode=true;SelectMethod=direct',
                    'MSSQL'
                );
                expect(testme).toBe('bridgeplugin');
            });

            it('IF the databasename is blank', function() {
                testme = testobj.parseConnectionString(
                    'jdbc:sqlserver://127.0.0.1:1433;DATABASENAME=;sendStringParametersAsUnicode=true;SelectMethod=direct',
                    'MSSQL'
                );
                expect(testme).toBe('');
            });
            it('IF the databasename property is missing', function() {
                testme = testobj.parseConnectionString(
                    'jdbc:sqlserver://127.0.0.1:1433;sendStringParametersAsUnicode=true;SelectMethod=direct',
                    'MSSQL'
                );
                expect(testme).toBe('');
            });
        });
    }

}
