function soc = soc_estimator(previousSoc,...
                             current,...
                             capacityAh,...
                             dt)

capacityAs = capacityAh * 3600;

deltaSoc = (current * dt / capacityAs) * 100;

soc = previousSoc - deltaSoc;

soc = max(0,min(100,soc));

end