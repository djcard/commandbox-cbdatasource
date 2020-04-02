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
        describe('ParseMySQLString should', function() {
            beforeEach(function() {
                testobj = createMock('commands.cbdatasource.publishtoenv');
            });
            it('If it is clean, return the dbname', function() {
                testobj.$(method = 'isCleanDBName', returns = true);
                var testme = testobj.parseMySQLString(
                    'jdbc:mysql://localhost:3306/testinstall9?useUnicode=true&characterEncoding=UTF-8&serverTimezone=America/New_York&useLegacyDatetimeCode=true'
                );

                expect(testme).toBe('testinstall9');
            });

            it('If it is not clean, return ''''', function() {
                testobj.$(method = 'isCleanDBName', returns = false);
                var testme = testobj.parseMySQLString(
                    'jdbc:mysql://localhost:3306/testinstall9?useUnicode=true&characterEncoding=UTF-8&serverTimezone=America/New_York&useLegacyDatetimeCode=true'
                );

                expect(testme).toBe('');
            });
        });
    }

}
