import matlab.unittest.TestRunner
import matlab.unittest.plugins.TestReportPlugin

suite = testsuite("BatteryScriptTest");

runner = TestRunner.withTextOutput;
runner.addPlugin(...
    TestReportPlugin.producingHTML(...
    'Reports\TestReport_mscripts.html'));

results = runner.run(suite);

disp(table(results));
