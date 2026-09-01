function diagnostic_client(soc,...
                           temperature,...
                           healthStatus)

if soc < 20
    fprintf('Diagnostic: LOW SOC detected\n');
end

if temperature > 50
    fprintf('Diagnostic: HIGH TEMPERATURE detected\n');
end

if healthStatus == 1
    fprintf('Diagnostic: WARNING condition\n');
end

if healthStatus == 2
    fprintf('Diagnostic: FAULT condition\n');
end

end