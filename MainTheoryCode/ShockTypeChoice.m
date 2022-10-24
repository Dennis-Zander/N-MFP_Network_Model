function shock_answer = ShockTypeChoice
answer = questdlg('Enter Shock Type. Choose from below:', ...
                  'Shock Type', ...
                  'Banks only', 'Funds only', 'Both', 'Cancel');
switch answer
    case 'Banks only'
        disp([answer ': Shock only banks'])
        shock_answer = 1;
    case 'Funds only'
        disp([answer ': Shock only funds'])
        shock_answer = 2;
    case 'Both'
        disp([answer ': Shock both types'])
        shock_answer = 3;
end