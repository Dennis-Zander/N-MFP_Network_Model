function shock_answer_degB = ShockDegreeChoiceBks
answer = questdlg('Enter Shock Severity. Choose from below:', ...
                  'Shock Type', ...
                  'Small, all', 'Medium, all', 'Severe, all', '');
switch answer
    case 'Small, all'
        disp([answer ': Only a minor shock to the whole system of banks'])
        shock_answer_degB = 1;
    case 'Medium, all'
        disp([answer ': Medium shock to the whole system of banks'])
        shock_answer_degB = 2;
    case 'Severe, all'
        disp([answer ': Significant shock to the whole system of banks'])
        shock_answer_degB = 3;
end