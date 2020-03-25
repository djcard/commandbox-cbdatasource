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
        describe('IsCleanDBName should', function() {
            beforeEach(function() {
                testobj = createObject('commands.cbdatasource.publishtoenv');
            });
            it('Return false if the dbname has a :', function() {
                var testme = testobj.isCleanDBName('first:second');
                expect(testme).toBeFalse();
            });

            it('Return false if the dbname has a .', function() {
                var testme = testobj.isCleanDBName('127.0.0.1');
                expect(testme).toBeFalse();
            });
            it('Return false if the dbname has a ,', function() {
                var testme = testobj.isCleanDBName('first,second');
                expect(testme).toBeFalse();
            });
            it('Return true if the dbname isclean', function() {
                var testme = testobj.isCleanDBName('bridgeplugin');
                expect(testme).toBeTrue();
            });
        });
    }

}
