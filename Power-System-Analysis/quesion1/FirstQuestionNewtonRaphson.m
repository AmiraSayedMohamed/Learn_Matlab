clear;
clc;

% Impedance values between buses (in per-unit)
Z12 = 0 + 1i * 0.08; % Impedance between Bus 1 and Bus 2
Z13 = 0 + 1i * 0.05; % Impedance between Bus 1 and Bus 3
Z23 = 0 + 1i * 0.06; % Impedance between Bus 2 and Bus 3

% Calculate admittance values
y12 = 1 / Z12;
y13 = 1 / Z13;
y23 = 1 / Z23;

% Admittance matrix (Y-bus)
Y = [
    y12 + y13, -y12,       -y13;
    -y12,      y12 + y23, -y23;
    -y13,     -y23,       y13 + y23
];

% Power data (in per-unit)
P = [0; (150 - 60) / 100; -100 / 100]; % Real power for each bus
Q = [0; 0; -90 / 100]; % Reactive power

% Initial voltage magnitudes and angles
V_mag = [1.025; 1.01; 1.0];
V_angle = [0; 0; 0]; % Slack bus at 0 degrees

% Maximum iterations and tolerance
max_iter = 5;
tolerance = 1e-6;

for iter = 1:max_iter
    P_calc = zeros(3, 1);
    Q_calc = zeros(3, 1);
    
    % Calculate real and reactive power
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
    
    dp2 = P(2) - P_calc(2);
    dp3 = P(3) - P_calc(3);
    dq3 = Q(3) - Q_calc(3);
    
    dP2_dTheta2 = -Q_calc(2) - V_mag(2)^2 * imag(Y(2, 2));
    dP2_dTheta3 = V_mag(2) * V_mag(3) * abs(Y(2, 3)) * sin(V_angle(2) - V_angle(3) - angle(Y(2, 3)));
    dP3_dTheta2 = V_mag(3) * V_mag(2) * abs(Y(3, 2)) * sin(V_angle(3) - V_angle(2) - angle(Y(3, 2)));
    dP3_dTheta3 = -Q_calc(3) - V_mag(3)^2 * imag(Y(3, 3));
    dQ3_dV3 = -2 * V_mag(3) * imag(Y(3, 3)) - sum(V_mag(2) * abs(Y(3, 2)) * cos(V_angle(3) - V_angle(2) - angle(Y(3, 2))));
    
    J = [
        dP2_dTheta2, dP2_dTheta3;
        dP3_dTheta2, dP3_dTheta3
    ];
    
    mismatch = [dp2; dp3];
    correction = -J \ mismatch;
    dTheta2 = correction(1);
    dTheta3 = correction(2);
    dV3 = dq3 / dQ3_dV3;
    
    V_angle(2) = V_angle(2) + dTheta2;
    V_angle(3) = V_angle(3) + dTheta3;
    V_mag(3) = V_mag(3) + dV3;
    
    % Print values for the current iteration
    fprintf('\nIteration %d:\n', iter);
    fprintf('  Delta P2 = %.6f\n', dp2);
    fprintf('  Delta P3 = %.6f\n', dp3);
    fprintf('  Delta Q3 = %.6f\n', dq3);
    fprintf('  P2 calc = %.6f\n', P_calc(2));
    fprintf('  P3 calc = %.6f\n', P_calc(3));
    fprintf('  Q3 calc = %.6f\n', Q_calc(3));
    fprintf('  Partial P2/Theta2 = %.6f\n', dP2_dTheta2);
    fprintf('  Partial P2/Theta3 = %.6f\n', dP2_dTheta3);
    fprintf('  Partial Q3/V3 = %.6f\n', dQ3_dV3);
    fprintf('  Partial P3/Theta2 = %.6f\n', dP3_dTheta2);
    fprintf('  Partial P3/Theta3 = %.6f\n', dP3_dTheta3);
    fprintf('  Delta V3 = %.6f\n', dV3);
    fprintf('  Theta2 = %.6f radians\n', V_angle(2));
    fprintf('  Theta3 = %.6f radians\n', V_angle(3));
    
    if max(abs([dp2, dp3, dq3])) < tolerance
        break;
    end
end

% Calculate voltage in rectangular form
V = V_mag .* exp(1i * V_angle);

% Calculate line currents
I12 = y12 * (V(1) - V(2));
I21 = -I12;
I13 = y13 * (V(1) - V(3));
I31 = -I13;
I23 = y23 * (V(2) - V(3));
I32 = -I23;

% Calculate power flows
S12 = V(1) * conj(I12);
S21 = V(2) * conj(I21);
S13 = V(1) * conj(I13);
S31 = V(3) * conj(I31);
S23 = V(2) * conj(I23);
S32 = V(3) * conj(I32);

% Calculate line losses
SL12 = S12 + S21;
SL13 = S13 + S31;
SL23 = S23 + S32;

% Display results
fprintf('\nLine Currents:\n');
fprintf('  I12 = %.4f + %.4fj\n', real(I12), imag(I12));
fprintf('  I21 = %.4f + %.4fj\n', real(I21), imag(I21));
fprintf('  I13 = %.4f + %.4fj\n', real(I13), imag(I13));
fprintf('  I31 = %.4f + %.4fj\n', real(I31), imag(I31));
fprintf('  I23 = %.4f + %.4fj\n', real(I23), imag(I23));
fprintf('  I32 = %.4f + %.4fj\n', real(I32), imag(I32));

fprintf('\nPower Flows:\n');
fprintf('  S12 = %.4f + %.4fj\n', real(S12), imag(S12));
fprintf('  S21 = %.4f + %.4fj\n', real(S21), imag(S21));
fprintf('  S13 = %.4f + %.4fj\n', real(S13), imag(S13));
fprintf('  S31 = %.4f + %.4fj\n', real(S31), imag(S31));
fprintf('  S23 = %.4f + %.4fj\n', real(S23), imag(S23));
fprintf('  S32 = %.4f + %.4fj\n', real(S32), imag(S32));

fprintf('\nLine Losses:\n');
fprintf('  SL12 = %.4f + %.4fj\n', real(SL12), imag(SL12));
fprintf('  SL13 = %.4f + %.4fj\n', real(SL13), imag(SL13));
fprintf('  SL23 = %.4f + %.4fj\n', real(SL23), imag(SL23));
