function predictedVoltage = voltage_model(soc,current)

R0 = 0.02;

ocv = 3.0 + 1.2*(soc/100);

predictedVoltage = ocv - current*R0;

end