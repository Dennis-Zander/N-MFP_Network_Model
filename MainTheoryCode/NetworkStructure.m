%% Network Spanned by MMFs and Banks
%   
%   
%
clc
clear
close all

%% Import Data
%imp_opt = detectImportOptions('BvD_and_BankList.xlsx')
%var_type = cell(1,139);     % 29733
%var_type(:) = {'double'};
%imp_opt.VariableTypes = var_type;
%InputData = readtable('2014m1_Nodes_Edges_Regions.xlsx',imp_opt);
dta_nodes = readtable('2014m1_Nodes_Edges_Regions.xlsx', 'Sheet', "Nodes");
dta_edges = readtable('2014m1_Nodes_Edges_Regions.xlsx', 'Sheet', "Edges");
dta_nodes = renamevars(dta_nodes, "Order", "Region");

N = length(dta_nodes{:,1});
N_M = sum(dta_nodes{:,4} == "Fund");
N_B = sum(dta_nodes{:,4} == "Bank");
N_edg = length(dta_edges{:,1});


%% Generate Fund Network Structure

run('FundStructure.m');

%% Generate Bank Network Structure

run('BankStructure.m');

%% Merge Network Structures


for i = (N_M+1):N
    for j = (N_M+1):N
        k = i - N_M;
        m = j - N_M;
        
        A(i,j) = AB(k,m);
    end
end
        
%% Plotting

[idx1 idx2] = find(A>1);
weights = A(sub2ind(size(A),idx1,idx2));
weights(weights < 1 ) = rand * 100000;      % Replace with real sizes later


%%
%G = graph(idx1, idx2, weights);
%h = plot(G, 'Layout', 'force', 'Iterations', 100, 'WeightEffect', 'direct')


