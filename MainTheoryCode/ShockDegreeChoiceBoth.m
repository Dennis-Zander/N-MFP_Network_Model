function shock_answer_degBt = ShockDegreeChoiceBoth
answer_bt = questdlg('Enter Shock Severity. Choose from below:', ...
                  'Shock Size', ...
                  'Small, all', 'Medium, all', 'Severe, all', '');
switch answer_bt
    case 'Small, all'
        disp([answer_bt ': Only a minor shock to the whole system'])
        shock_answer_degBt = 1;
    case 'Medium, all'
        disp([answer_bt ': Medium shock to the whole system'])
        shock_answer_degBt = 2;
    case 'Severe, all'
        disp([answer_bt ': Significant shock to the whole system'])
        shock_answer_degBt = 3;
end