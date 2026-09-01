classdef SocTest_Model < matlab.unittest.TestCase
    % Unit test framework for SOC estimation using Simulink harness model
    
    properties
        ModelName  = 'SocModel_Harness';   % replace with your harness model name
    end
    
    methods (TestMethodSetup)
        function loadModel(testCase)
            % Load the Simulink model (without opening GUI)
            load_system(testCase.ModelName);
        end
    end

    methods (Access = private)
        function runSocHarnessTest(testCase, scenarioName)
            % Load the Signal Editor scenario scenarios named 'TC_0001', 'TC_002', 'TC_003'
            set_param([testCase.ModelName '/Signal Editor'], ...
                      'ActiveScenario', scenarioName);
            % Run the harness model
            simOut = sim(testCase.ModelName, ...
                'SaveOutput','on', ...
                'SaveFormat','StructureWithTime');
            
            % Extract logged signals (assuming logsout logging)
            logs = simOut.logsout;
            actualSOC  = logs.getElement('actualSOC').Values.Data;
            expectedSOC= logs.getElement('ExpectedSOC').Values.Data;
            
            % Verify SOC results
            tolerance = 0.01;
            for i = 1:length(expectedSOC)
                testCase.verifyEqual(actualSOC(i), expectedSOC(i), 'AbsTol', tolerance, ...
                    sprintf('SOC mismatch in %s at row %d', scenarioName, i));
            end
        end
    end
    
    methods (Test)
        function TC_0001(testCase)
            evalin('base', 'run(''TC_SOC_001.m'')');
            testCase.runSocHarnessTest('TC_0001');
        end
        
        function TC_0002(testCase)
            evalin('base', 'run(''TC_SOC_002.m'')');
            testCase.runSocHarnessTest('TC_002');
        end
        
        function TC_0003(testCase)
            evalin('base', 'run(''TC_SOC_003.m'')');
            testCase.runSocHarnessTest('TC_003');
        end
    end
end
