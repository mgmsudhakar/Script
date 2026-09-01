import matlab.unittest.TestRunner
import matlab.unittest.plugins.TestReportPlugin

suite = testsuite("BatteryModelTest")

runner = TestRunner.withTextOutput;
runner.addPlugin(...
    TestReportPlugin.producingHTML(...
    'Reports\TestReport_Model.html'));

results = runner.run(suite);

disp(table(results))
