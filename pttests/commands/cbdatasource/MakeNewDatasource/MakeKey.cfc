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
        describe('The MakeKey Function should', function() {
            beforeEach(function() {
                testobj = createMock('commands.cbdatasource.makenewdatasource');
                testobj.$(method = 'command', returns = true);
                testobj.$(method = 'printme');
                MakePublic(testobj, 'makekey', 'makekeypublic');

                MockCommon = createMock('models.common');
                mockCommon.$(method = 'printme', returns = mockCommon);

                mockPrint = createEmptyMock('models.common');
                mockPrint.$(method = 'line', returns = mockPrint);
                mockPrint.$(method = 'redLine', returns = mockPrint);
                mockPrint.$(method = 'toConsole', returns = mockPrint);
            });
            it('Return false if the datasource is blank and call printme 1x', function() {
                testobj.$(method = 'makeDsourceInfo', returns = {});
                MockCommon.$(method = 'appSettings', returns = {});
                mockCommon.setPrint(mockPrint);
                testobj.setCommon(MockCommon);
                testme = testObj.makekeypublic({
                    dbtype: '',
                    dbname: '',
                    username: '',
                    password: '',
                    serveraddress: '',
                    port: '0',
                    folder: '',
                    addlstring: '',
                    datasource: ''
                });
                expect(testme).toBeFalse();
                expect(mockCommon.$count('printme')).toBe(1);
            });

            it('If the datasource is not blank but it is not supported, return false', function() {
                testobj.$(method = 'makeDsourceInfo', returns = {});
                MockCommon.$(method = 'appSettings', returns = {});
                mockCommon.setPrint(mockPrint);
                testobj.setCommon(MockCommon);
                testme = testObj.makekeypublic({
                    dbtype: '',
                    dbname: '',
                    username: '',
                    password: '',
                    serveraddress: '',
                    port: '0',
                    folder: '',
                    addlstring: '',
                    datasource: 'OtherThings'
                });
                expect(testme).toBeFalse();
                expect(MockCommon.$count('appsettings')).toBe(0);
            });

            it('If the datatype is not blank but the dbtype is not supported, return false', function() {
                testobj.$(method = 'makeDsourceInfo', returns = {});
                MockCommon.$(method = 'appSettings', returns = {});
                mockCommon.setPrint(mockPrint);
                testobj.setCommon(MockCommon);
                testme = testObj.makekeypublic({
                    dbtype: 'JDTS',
                    dbname: '',
                    username: '',
                    password: '',
                    serveraddress: '',
                    port: '0',
                    folder: '',
                    addlstring: '',
                    datasource: 'otherthing'
                });
                expect(testme).toBeFalse();
                expect(MockCommon.$count('appsettings')).toBe(0);
            });

            it('If the datatype is not blank and the dbtype is supported, call makeDsourceInfo 1x, call appsettings 1x and return true', function() {
                testobj.$(method = 'makeDsourceInfo', returns = {jtds: {type: 'MSSQL', host: '', database: ''}});
                MockCommon.$(method = 'appSettings', returns = {});
                mockCommon.setPrint(mockPrint);
                testobj.setCommon(MockCommon);
                testme = testObj.makekeypublic({
                    dbtype: 'JTDS',
                    dbname: '',
                    username: '',
                    password: '',
                    serveraddress: '',
                    port: '0',
                    folder: '',
                    addlstring: '',
                    datasource: 'otherthing'
                });
                expect(testObj.$count('makeDsourceInfo')).tobe(1);
                expect(MockCommon.$count('appSettings')).toBe(1);
                expect(testme).toBeTrue();
            });
        });
    }

}
