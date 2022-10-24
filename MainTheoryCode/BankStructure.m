%% Monte Carlo Simulation of Bank Connections
%   
%   
%
%clc
%clear
%close all

%% 
%run('NetworkStructure.m');

%% Generate Probabilities
% Each Region and country needs a probability of connection
% Major regions: US,Europe, Asia, South-America, Oceania (Australia etc.)
% Also: Countries, within Europe

% Simple Case: Only major regions
% Possible connections:US-EU,US-AS,US-SA,US-Oc,EU-AS,EU-SA,EU-Oc,AS-SA,AS-Oc,SA-Oc
hand_shakes = 5*(5-1)/2;

conn = rand(hand_shakes,10000);
conn_sc = [0.8,0.6,0.4,0.2,0.5,0.4,0.2,0.4,0.3,0.6,0.5]; % First pair = domestic
% US-EU
conn(1,:)  = 0.6*conn(1,:);
% US-AS 
conn(2,:)  = 0.4*conn(2,:);
% US-SA
conn(3,:)  = 0.2*conn(3,:);
% US-Oc
conn(4,:)  = 0.5*conn(4,:);
% EU-AS
conn(5,:)  = 0.4*conn(5,:);
% EU-SA
conn(6,:)  = 0.2*conn(6,:);
% EU-Oc
conn(7,:)  = 0.4*conn(7,:);
% AS-SA
conn(8,:)  = 0.3*conn(8,:);
% AS-Oc
conn(9,:)  = 0.6*conn(9,:);
% SA-Oc
conn(10,:) = 0.5*conn(10,:);



%% Use MMF Data on Banks
%  Store regions for each bank
%reg = dta_nodes{:,5};
%reg(reg==1) = [];

% For test, use fake region file
% Region 1 = US, Region 2 = EU, Region 3 = Asia, Region 4 = South-America, Region 5 = Oceania
reg = randi(5,N_B,1);
% Possible connections:US-EU,US-AS,US-SA,US-Oc,EU-AS,EU-SA,EU-Oc,AS-SA,AS-Oc,SA-Oc
pairs = zeros(5,5);

for i = 1:5
    for j = 1:5 
        if i == 1 && j == 1 % US-US
            pairs(i,j) = 0;
        end
        if i == 1 && j == 2 % US-EU
            pairs(i,j) = 1;
            pairs(j,i) = 1;
        end
        if i == 1 && j == 3 % US-Asia
            pairs(i,j) = 2;   
            pairs(j,i) = 2;
        end
        if i == 1 && j == 4 % US-South America
            pairs(i,j) = 3;    
            pairs(j,i) = 3;
        end
        if i == 1 && j == 5 % US-Oceania
            pairs(i,j) = 4;
            pairs(j,i) = 4;
        end
        
        if i == 2 && j == 2 % EU-EU
            pairs(i,j) = 0;
        end
        if i == 2 && j == 3 % EU-Asia
            pairs(i,j) = 5;
            pairs(j,i) = 5;
        end
        if i == 2 && j == 4 % EU-SA
            pairs(i,j) = 6;    
            pairs(j,i) = 6;    
        end
        if i == 2 && j == 5 % EU-Oc
            pairs(i,j) = 7;    
            pairs(j,i) = 7;
        end
            
        if i == 3 && j == 3 % As-As
            pairs(i,j) = 0;
        end
        if i == 3 && j == 4 % As-SA
            pairs(i,j) = 8;
            pairs(j,i) = 8;
        end
        if i == 3 && j == 5 % As-Oc
            pairs(i,j) = 9;    
            pairs(j,i) = 9;    
        end
        
        if i == 4 && j == 4 % SA-SA
            pairs(i,j) = 0;
        end
        if i == 4 && j == 5 % SA-Oc
            pairs(i,j) = 10;
            pairs(j,i) = 10;
        end
            
        if i == 5 && j == 5 % Oc-Oc
            pairs(i,j) = 0;    
        end
    end
end


pairs = pairs + ones(5,5);      % Too lazy to adjust for index in loop later
                                % Main diagonal cannot be zero



%% Draw, Set-up
k = 10;
A_B = zeros(N_B,N_B,k);
draw_set = transpose(1:N_B);

IB_isum = zeros(100,1);
IB_osum = zeros(100,1);    
    
%% Draw
% Can have special cases where a single obs. remains large (e.g. in IB_in)
% This obs. combined with exclusively small IB_out will take extremely long to get cleared

for i = 1:k
    disp(i)
    IB_in = ones(N_B,1);        % Borrowing
    IB_out = ones(N_B,1);       % Lending
    %IB_in  = [IB_in ,draw_set];
    %IB_out = [IB_out,draw_set];
    tic
    while sum(IB_in(:,1))>0.9 & sum(IB_out(:,1))>0.9     % Soft threshold above 0, refine later        
        p_cond = 0;
        si_cond = 0;
        so_cond = 0;
        
        b1 = randi(N_B);        % Borrower
        b2 = randi(N_B);        % Lender
        if b1 == b2
            b2 = randi(N_B);    % Not 100% safe, replace with while later
        end
    
        
        % Determine linked regions
        reg1 = reg(b1,1);
        reg2 = reg(b2,1);
        
        % Link size and acceptance/rejection decision
        prob = rand;
        crit = conn_sc(1,pairs(reg1,reg2));
        str  = rand;
        if prob >= crit
            p_cond = 1;
        end
        if str <= IB_in(b1,1)
            si_cond = 1;
        end
        if str <= IB_out(b2,1)
            so_cond = 1;
        end
        
        %if A_B(b1,b2,i) == 0 && prob >= crit && str <= IB_in(b1,1) && str <= IB_out(b2,1)
        if A_B(b2,b1,i) == 0 && p_cond == 1 && si_cond == 1 && so_cond == 1
            A_B(b2,b1,i) = str;
            IB_in(b1,1)  = IB_in(b1,1) - str;
            IB_out(b2,1) = IB_out(b2,1) - str;
        end
    end
    toc
    IB_isum(i,1) = sum(IB_in);
    IB_osum(i,1) = sum(IB_out);
end


%% Take average network
%A = rand(N_B,N_B,10); <-- toy example

AB = zeros(N_B,N_B);


for i = 1:N_B
    for j = 1:N_B
        AB(i,j) = mean(A_B(i,j,:));
    end
end

%% Combine with Balance Sheet Data (AB = Fractions)

% Arbitrary structure
TA = randi([60,100],[N_B,1]);
EQ = randi(10,[N_B,1]);
TL = TA - EQ;



%% Wrong - IB mat arises from transaction needs, not from -exposures- !
%{


%% Relative liabilities matrix 
%  Banks only, probably delete later. AB is already relative liabilities

IB_mat = zeros(N_B,N_B);
for i = 1:N_B
    for j = 1:N_B
        row_sum = sum(AB(i,:));
        IB_mat(i,j) = AB(i,j)/row_sum;
    end
end



%}

%%

