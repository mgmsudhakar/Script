function status = health_monitor(measuredVoltage,...
                                 temperature,...
                                 predictedVoltage)

voltageError = abs(measuredVoltage - predictedVoltage);

if temperature > 55
    status = 2;      % Fault

elseif voltageError > 0.30
    status = 1;      % Warning

else
    status = 0;      % Healthy
end

end