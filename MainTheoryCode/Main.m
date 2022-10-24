%% Main File
% 
%
%
clc
clear
close
%% Network Generation
run('NetworkStructure.m');




%% Shock
%  Choose between shock type
%  Bank shock = epsb
%  Fund shock = epsf
%prompt = {'Enter Shock Type. Choose from {Banks, Funds, Both}'};
%dlgtitle = 'Shock Type';
%dims = [1 60];
%definput = {'Banks'};
%answer = inputdlg(prompt, dlgtitle, dims, definput)

%% Shock
% for more than 3 buttons: listdlg
shock_answer = ShockTypeChoice;
if shock_answer == 1
    shock_answer_degB = ShockDegreeChoiceBks;
    shock_ans_deg = shock_answer_degB;
elseif shock_answer == 2
    shock_answer_degF = ShockDegreeChoiceFds;
    shock_ans_deg = shock_answer_degF;
elseif shock_answer == 3
    shock_answer_degBt = ShockDegreeChoiceBoth;
    shock_ans_deg = shock_answer_degBt;
end

[epsilon] = Shock(shock_answer, shock_ans_deg, N_B, N_M, N);




%% Relative Liabilities

% Some IB_mat that will cause defaults

IB_liabilities = zeros(N_B,N_B);
for i = 1:N_B
    for j = 1:N_B
        IB_liabilities(i,j) = AB(i,j) * 21 * rand;      % IB liabilities matrix
    end
end

IB_mat = zeros(N_B,N_B);
for i = 1:N_B
    for j = 1:N_B
        row_sum = sum(IB_liabilities(i,:));
        IB_mat(i,j) = IB_liabilities(i,j)/row_sum;      % Relative liabilities mat
    end
end

%% Eisenberg-Noe Algorithm to solve for equilibrium
%

[def_set, eql_set, eq_set, p_vec] = ENAlgo(IB_mat, IB_liabilities, EQ, N_B, epsilon, shock_answer);




