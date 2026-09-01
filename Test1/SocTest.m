classdef SocTest < matlab.unittest.TestCase
    % Unit test framework for SOC estimation using Excel test cases
    
    properties
        FileName = 'SOC_TestCase.xlsx';
    end
    
    methods (Access = private)
        function runSocTest(testCase, sheetName)
            % Read the sheet
            tbl = readtable(testCase.FileName, 'Sheet', sheetName);
            
            % Extract signals
            current     = tbl.Current_A;
            delta       = tbl.Delta;
            prevSOC     = tbl.PreviousSOC;
            capacity    = tbl.capacityAh;
            expectedSOC = tbl.ExpectedSOC;
            
            % Run SOC estimator for each row
            for i = 1:length(prevSOC)
                actualSOC = soc_estimator(prevSOC(i), current(i), capacity(i), delta(i));
                tolerance = 0.01; % adjust as needed
                testCase.verifyEqual(actualSOC, expectedSOC(i), 'AbsTol', tolerance, ...
                    sprintf('SOC mismatch in %s at row %d', sheetName, i));
            end
        end
    end
    
    methods (Test)
        function TC_0001(testCase)
            testCase.runSocTest('TC_0001');
        end
        
        function TC_0002(testCase)
            testCase.runSocTest('TC_002');
        end
        
        function TC_0003(testCase)
            testCase.runSocTest('TC_003');
        end
    end
end
