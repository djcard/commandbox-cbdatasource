/**
 * My BDD Test
 */
component extends="testbox.system.BaseSpec" {

    /*********************************** LIFE CYCLE Methods ***********************************/

    /*
     * executes before all suites+specs in the run() method
     */
    void function beforeAll() {
    }

    /*
     * executes after all suites+specs in the run() method
     */
    void function afterAll() {
    }

    /*********************************** BDD SUITES ***********************************/

    void function run() {
        describe('Printme should', function() {
            it('work based on testing in place', function() {
                // testme=createObject("models.common").printme("hi","redLine");
                expect(true).toBeTrue();
            });
        });
    }

}
