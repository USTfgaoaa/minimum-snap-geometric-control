function J = costFunc_appA(tau_vec, PATH, gamma)

A = A_const_appA(tau_vec);
K = length(tau_vec);
C = permut_mat(K);
bF = const_bf(PATH);
Q = augmentQ(tau_vec,4);
R = comp_R_appA(A,C,Q);
b_sorted = comp_b_sorted(R, bF);

A_yaw = augmentA_yaw(tau_vec);
% Permutation matrix to rearrange b
C_yaw = permutMat_yaw(tau_vec);
% Cost matrix
Q_yaw = augmentQ(tau_vec,2);
% C*A^(-T)*Q*A^(-1)*C^(T) = R
R_yaw = comp_R_appA(A_yaw,C_yaw,Q_yaw);
% Known derivatives including position. 
bFyaw = bF_yaw(0, tau_vec);
b_srtdYaw = b_srtd_yaw(R_yaw, bFyaw);
% P_yaw = (C_yaw*A_yaw)\b_srtdYaw;
J_yaw = b_srtdYaw'*R_yaw*b_srtdYaw;

% Compute cost
J = trace(b_sorted'*R*b_sorted) + J_yaw + gamma*sum(tau_vec);

end

