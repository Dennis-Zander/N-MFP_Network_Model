%% Classifying Issuer Identities
%   This file uses the Jaccard similarity matrix and generates 
%   a vector of identities meeting certain criteria
%
clc
clear
close all

%% Import Data
imp_opt = detectImportOptions('BvD_and_BankList.xlsx')
%var_type = cell(1,139);     % 29733
%var_type(:) = {'double'};
%imp_opt.VariableTypes = var_type;
InputData = readtable('BvD_and_BankList.xlsx',imp_opt);

%%
