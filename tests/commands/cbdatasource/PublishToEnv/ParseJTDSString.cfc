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
        describe('ParseJTDS should', function() {
            beforeEach(function() {
                testobj = createMock('commands.cbdatasource.publishtoenv');
            });
            it('If the item has not badchars, return the database name (Last item in the ''list'' with / as delimiter', function() {
                testobj.$(method = 'isCleanDBName', returns = true);
                testme = testobj.parseJTDSString('jdbc:jtds:sqlserver://127.0.0.1:1433/bridgeplugin');
                expect(testme).toBe('bridgeplugin');
            });

            it('If the last item is not a clean dbname, return blank', function() {
                testobj.$(method = 'isCleanDBName', returns = false);
                testme = testobj.parseJTDSString('jdbc:jtds:sqlserver://127.0.0.1:1433/');
                expect(testme).toBe('');
            });
        });
    }

}
