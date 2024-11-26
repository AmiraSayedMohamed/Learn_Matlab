% Newton-Raphson Power Flow Analysis
clear;
clc;

% Impedance values between buses (in per-unit)
Z12 = 0.02 + 1i * 0.04; % Impedance between Bus 1 and Bus 2
Z13 = 0.01 + 1i * 0.03; % Impedance between Bus 1 and Bus 3
Z23 = 0.0125 + 1i * 0.25; % Impedance between Bus 2 and Bus 3

% Calculate admittance values
y12 = 1 / Z12;
y13 = 1 / Z13;
y23 = 1 / Z23;

% Form the admittance matrix (Y-bus matrix)
Y = [
    y12 + y13,   -y12,       -y13;
    -y12,      y12 + y23,     -y23;
    -y13,         -y23,       y13 + y23
];

% Power data (in per-unit)
P = [0; (0 - 256.6) / 100; -138.6 / 100]; % Real power for each bus
Q = [0; (0 - 110.2) / 100; -45.2 / 100];  % Reactive power for each bus

% Initial voltage magnitudes and angles (in per-unit and radians)
V_mag = [1.05; 1.0; 1.0]; % Initial voltage magnitudes
V_angle = [0; 0; 0];      % Initial angles

% Maximum iterations
max_iter = 5;

% Tolerance for convergence
tolerance = 1e-6;

% Iterative Newton-Raphson method
for iter = 1:max_iter
    % Calculate real and reactive power at each bus
    P_calc = zeros(3, 1);
    Q_calc = zeros(3, 1);
    for i = 1:3
        for j = 1:3
            P_calc(i) = P_calc(i) + V_mag(i) * V_mag(j) * ...
                        (real(Y(i, j)) * cos(V_angle(i) - V_angle(j)) + ...
                         imag(Y(i, j)) * sin(V_angle(i) - V_angle(j)));
                         
            Q_calc(i) = Q_calc(i) + V_mag(i) * V_mag(j) * ...
                        (real(Y(i, j)) * sin(V_angle(i) - V_angle(j)) - ...
                         imag(Y(i, j)) * cos(V_angle(i) - V_angle(j)));
        end
    end
    
    % Calculate power mismatches
    dp2 = P(2) - P_calc(2);
    dp3 = P(3) - P_calc(3);
    dq2 = Q(2) - Q_calc(2);
    dq3 = Q(3) - Q_calc(3);
    
    % Calculate partial derivatives for Jacobian matrix
    dP2_dTheta2 = -Q_calc(2) - V_mag(2)^2 * imag(Y(2, 2));
    dP2_dTheta3 = V_mag(2) * V_mag(3) * abs(Y(2, 3)) * sin(V_angle(2) - V_angle(3) - angle(Y(2, 3)));
    dP3_dTheta2 = V_mag(3) * V_mag(2) * abs(Y(3, 2)) * sin(V_angle(3) - V_angle(2) - angle(Y(3, 2)));
    dP3_dTheta3 = -Q_calc(3) - V_mag(3)^2 * imag(Y(3, 3));
    dQ2_dV2 = -2 * V_mag(2) * imag(Y(2, 2)) - sum(V_mag(3) * abs(Y(2, 3)) * cos(V_angle(2) - V_angle(3) - angle(Y(2, 3))));
    dQ3_dV3 = -2 * V_mag(3) * imag(Y(3, 3)) - sum(V_mag(2) * abs(Y(3, 2)) * cos(V_angle(3) - V_angle(2) - angle(Y(3, 2))));
    
    % Construct the Jacobian matrix
    J = [
        dP2_dTheta2, dP2_dTheta3;
        dP3_dTheta2, dP3_dTheta3
    ];
    
    % Construct the mismatch vector
    mismatch = [dp2; dp3];
    
    % Solve for angle corrections (Delta Theta2, Delta Theta3)
    correction = -J \ mismatch;
    dTheta2 = correction(1);
    dTheta3 = correction(2);
    
    % Solve for voltage magnitude corrections (Delta V2, Delta V3)
    dV2 = dq2 / dQ2_dV2;
    dV3 = dq3 / dQ3_dV3;
    
    % Update voltage magnitudes and angles
    V_angle(2) = V_angle(2) + dTheta2;
    V_angle(3) = V_angle(3) + dTheta3;
    V_mag(2) = V_mag(2) + dV2;
    V_mag(3) = V_mag(3) + dV3;
    
    % Display results for the iteration
    fprintf('Iteration %d:\n', iter);
    fprintf('  dp2 = %.6f, dp3 = %.6f, dq2 = %.6f, dq3 = %.6f\n', dp2, dp3, dq2, dq3);
    fprintf('  Partial Derivatives:\n');
    fprintf('    dP2/dTheta2 = %.6f, dP2/dTheta3 = %.6f\n', dP2_dTheta2, dP2_dTheta3);
    fprintf('    dP3/dTheta2 = %.6f, dP3/dTheta3 = %.6f\n', dP3_dTheta2, dP3_dTheta3);
    fprintf('    dQ2/dV2 = %.6f, dQ3/dV3 = %.6f\n', dQ2_dV2, dQ3_dV3);
    fprintf('  Delta Values:\n');
    fprintf('    dTheta2 = %.6f, dTheta3 = %.6f, dV2 = %.6f, dV3 = %.6f\n\n', dTheta2, dTheta3, dV2, dV3);
    
    % Check for convergence
    if max(abs([dp2, dp3, dq2, dq3])) < tolerance
        fprintf('Converged in %d iterations.\n', iter);
        break;
    end
end
