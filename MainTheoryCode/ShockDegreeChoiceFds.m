function shock_answer_degF = ShockDegreeChoiceFds
answer = questdlg('Enter Shock Severity. Choose from below:', ...
                  'Shock Type', ...
                  'Small, all', 'Medium, all', 'Severe, all', '');
switch answer
    case 'Small, all'
        disp([answer ': Only a minor shock to the whole system of funds'])
        shock_answer_degF = 1;
    case 'Medium, all'
        disp([answer ': Medium shock to the whole system of funds'])
        shock_answer_degF = 2;
    case 'Severe, all'
        disp([answer ': Significant shock to the whole system of funds'])
        shock_answer_degF = 3;
end