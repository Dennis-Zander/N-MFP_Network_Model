%% Generating the MMF portfolios
%  Full-sized adjacency matrix with MMF --> Bank connections only


%%
%run('NetworkStructure.m');

%% Adjacency Matrix (no Bank-Connections)
%  Basic version of adj matrix based entirely on MMF portfolio data
%  Convention: A_ij = Connection from j to i.

A = zeros(N,N);
k = 1;
while k <= N_edg
    j = dta_edges{k,1};     % Source
    i = dta_edges{k,2};     % Target
    A(i,j) = dta_edges{k,3};
    k = k + 1;
end



%%

%  Export to excel 
%exp_data = table(A);
%filename     = 'example_adjacency.xlsx';
%writetable(exp_data, filename, 'Sheet',1);