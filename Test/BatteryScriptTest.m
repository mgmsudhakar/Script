classdef BatteryScriptTest < matlab.unittest.TestCase

    methods (Test)

        %% Test SOC Estimator
        function testSocEstimator(testCase)

            % Test Inputs
            initialSOC = 80;      % %
            current    = 10;      % A (discharge)
            capacityAh = 100;     % Ah
            dt         = 3600;    % 1 hour

            % Execute
            SOC = soc_estimator(initialSOC,...
                                current,...
                                capacityAh,...
                                dt);

            % Verify SOC range
            testCase.verifyGreaterThanOrEqual( ...
                SOC, 0);

            testCase.verifyLessThanOrEqual( ...
                SOC, 100);

            % Verify final SOC value
            expectedSOC = 70;

            testCase.verifyEqual( ...
                SOC, ...
                expectedSOC, ...
                'AbsTol',1e-3);

        end


        %% Test Voltage Model
        function testVoltageModel(testCase)

            % Test Inputs
            SOC     = 80;
            current = 10;

            % Execute
            predictedVoltage = voltage_model(SOC,...
                                             current);

            % Verify voltage range
            testCase.verifyGreaterThan( ...
                predictedVoltage, 0);

            testCase.verifyLessThan( ...
                predictedVoltage, 5.0);

            % Verify final voltage
            expectedVoltage = 3.72;

            testCase.verifyEqual( ...
                predictedVoltage, ...
                expectedVoltage, ...
                'AbsTol',0.1);
        end


        %% Test Health Monitor
        function testHealthMonitor(testCase)

            % Test Inputs
            measuredVoltage  = 3.70;
            temperature      = 25;
            predictedVoltage = 3.72;

            % Execute
            healthStatus = health_monitor( ...
                                measuredVoltage,...
                                temperature,...
                                predictedVoltage);

            % Example Expectation
            expectedStatus = 0;  % "Healthy";

            % Verify
            testCase.verifyEqual(healthStatus,...
                                 expectedStatus);

        end


       

    end

end