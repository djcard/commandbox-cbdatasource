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
        describe('DetermineType should', function() {
            beforeEach(function() {
                testobj = createObject('commands.cbdatasource.publishtoenv');
            });
            it('Return a type is the class submitted is in the struct', function() {
                var testme = testObj.determinetype('org.gjt.mm.mysql.Driver');
                expect(testme).toBe('MYSQL');
            });

            it('Return '''' if the class is NOT part of the reference struct', function() {
                var testme = testObj.determinetype('blah');
                expect(testme).toBe('');
            });
        });
    }

}
