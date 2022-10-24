function [epsilon] = Shock(shock_answer, shock_ans_deg, N_B, N_M, N)

if shock_answer == 1
    if shock_ans_deg == 1
        epsilon = 0.05 * ones(N_B,1);
    elseif shock_ans_deg == 2
        epsilon = 0.10 * ones(N_B,1);
    elseif shock_ans_deg == 3
        epsilon = 0.15 * ones(N_B,1);
    end
elseif shock_answer == 2
    if shock_ans_deg == 1
        epsilon = 0.95 * ones(N_M,1);
    elseif shock_ans_deg == 2
        epsilon = 0.90 * ones(N_M,1);
    elseif shock_ans_deg == 3
        epsilon = 0.85 * ones(N_M,1);
    end
elseif shock_answer == 3
    if shock_ans_deg == 1
        epsilon = [0.05 * ones(N,1) , 0.95 * ones(N,1)];
    elseif shock_ans_deg == 2
        epsilon = [0.10 * ones(N,1) , 0.90 * ones(N,1)];
    elseif shock_ans_deg == 3
        epsilon = [0.15 * ones(N,1) , 0.85 * ones(N,1)];
    end
    epsilon(1:N_M,2) = 1;
    epsilon((N_M+1):N,1) = 0;
end




end