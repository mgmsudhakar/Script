clc;
clear;

% Initial battery state
SOC = 80;       % %
capacityAh = 50;
dt = 1;         % sec

fprintf('Starting BMS Application...\n\n');

for k = 1:5

    % Simulated measurements
    current = 5 + randn()*0.2;        % A
    voltage = 3.7 + randn()*0.01;     % V
    temperature = 25 + randn()*1;     % DegC

    % Service: SOC Estimation
    SOC = soc_estimator(SOC,current,capacityAh,dt);

    % Service: Voltage Prediction
    predictedVoltage = voltage_model(SOC,current);

    % Service: Health Monitoring
    healthStatus = health_monitor(voltage,...
                                  temperature,...
                                  predictedVoltage);

    % Service Publication
    % service_publish(SOC,...
    %                 predictedVoltage,...
    %                 temperature,...
    %                 healthStatus);

    % Client Consumption
    diagnostic_client(SOC,...
                      temperature,...
                      healthStatus);

    pause(0.5)

end

fprintf('\n--- BatteryState ---\n');

fprintf('SOC                : %.2f %%\n',SOC);
fprintf('Predicted Voltage  : %.2f V\n',predictedVoltage);
fprintf('Temperature        : %.2f C\n',temperature);
fprintf('Health Status      : %d\n',healthStatus);