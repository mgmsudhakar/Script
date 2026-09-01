classdef ModelTest < matlab.unittest.TestCase

    properties (TestParameter)
        ModelName = {"Model_Harness"};
    end

    methods (Test)

        %% Test Case 1 - SOC Validation
        function testSOCOutput1(testCase, ModelName)
            evalin('base', 'run(''TC_SOC_001.m'')');
            out = sim(ModelName);

            socSig = out.logsout.get('SOC');

            socData = socSig.Values.Data;

            % Verify SOC range
            testCase.verifyGreaterThanOrEqual( ...
                min(socData), 0);

            testCase.verifyLessThanOrEqual( ...
                max(socData), 100);

            % Verify final SOC value
            expectedSOC = 50;

            testCase.verifyEqual( ...
                socData(end), ...
                expectedSOC, ...
                'AbsTol',1e-3);

        end


        %% Test Case 2 -
        function testSOCOutput2(testCase, ModelName)
            evalin('base', 'run(''TC_SOC_002.m'')');
            out = sim(ModelName);

            socSig = out.logsout.get('SOC');

            socData = socSig.Values.Data;

            % Verify SOC range
            testCase.verifyGreaterThanOrEqual( ...
                min(socData), 0);

            testCase.verifyLessThanOrEqual( ...
                max(socData), 100);

            % Verify final SOC value
            expectedSOC = 99.99;

            testCase.verifyEqual( ...
                socData(end), ...
                expectedSOC, ...
                'AbsTol',1e-3);

        end


        %% Test Case 3 -
        function testSOCOutput3(testCase, ModelName)
           evalin('base', 'run(''TC_SOC_003.m'')');
            out = sim(ModelName);

            socSig = out.logsout.get('SOC');

            socData = socSig.Values.Data;

            % Verify SOC range
            testCase.verifyGreaterThanOrEqual( ...
                min(socData), 0);

            testCase.verifyLessThanOrEqual( ...
                max(socData), 100);

            % Verify final SOC value
            expectedSOC = 10;

            testCase.verifyEqual( ...
                socData(end), ...
                expectedSOC, ...
                'AbsTol',1e-3);

        end

    end

end