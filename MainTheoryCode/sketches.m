clear

A = randi (100 , 16 , 16) ;
s=A>50;
a=[5 5;5 5];
b=[20 20;20 20 ];
R=num2cell(A);
R(s)={a};
R(not(s))={b};
R=cell2mat(R)

%%
X = magic(3)            % X_ij = loan from j to i
                        % X_12 = loan from 2 to 1
                        % X_13 = loan from 3 to 1
                        % ==> Row 1 = Liabilities of Bank 1
                        % ==> Col 1 = Receivables of Bank 1

row_sumx1 = sum(X(1,:))

%%

def_set = diag(ones(N_B,1));


%%
MM = 3* randi(3,3);
M = sum(MM,2);



%%

count = 1;
p_vec = zeros(N_B,1);
eql_set = zeros(N_B,1);
eq_set  = EQ;
def_set = diag(0);
IB_obl  = zeros(N_B,1);
for i = 1:N_B
    IB_obl(i,1) = sum(IB_tmp(i,:));
end
IB_claims = zeros(N_B,1);
for i = 1:N_B
    IB_claims(i,1) = sum(IB_tmp(:,i));
end


eq_start = eq_set - IB_obl + IB_claims - eps;     % Equity of all banks assuming everyone pays in full

def_idx = find(eq_start <0);
def_set(def_idx,def_idx) = 1



%%

eqq = rand(5,1);
eqq(1,1) = -0.5;
eqq(3,1) = -0.3;
eqq(5,1) = -0.8;

defaulters = eqq < 0

AAA = diag(defaulters)
AA = double(AAA)

abc = [1,2,5]
BB = diag(abc)
BB(BB>0) = 1

%%

qq = magic(3)
qqq = qq'

qq = eye(10)


%%

%{
1. Determine equity and IB payment liabilities
2. To initiate the algo: 
        a. Assume everyone fully serves IB liab., and calculate equity post payments
        b. Store the defaults 
3. Enter loop
        a. Plug payments into FIX of N/E. 
            a.1. Non-defaulting banks: pay in full
            a.2. Defaulting banks: pay according to relative liabilities and 






%}







%{
1. Assume all payments are served, p'
2. Under p', calculate for each bank if it would manage to pay or not
    2.a: Use IB exposures and equity status at beginning of period
    2.b: Store default/non-default in Lambda(p') matrix
    2.c: Store full/partial payments
3. Check if any new defaults happened under p'
    3.a: If no, terminate
    3.b: If yes, repeat (see 4)
4. Adjust payments of defaulting banks down to their capacities
    4.a: relative liabilities determine how much is paid to whom
    4.b: Non-defaulting banks (in previous iteration) will still pay in full
5. Adjusted payments facilitate new payments vector p''
6. Continue as shown in 2.-4. (default set, partial/full payments,..)



%}
