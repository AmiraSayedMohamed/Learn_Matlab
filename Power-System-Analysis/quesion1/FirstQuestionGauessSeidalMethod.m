% Power System Parameters
clear
clc

% Impedance values between buses (in per-unit)
Z12 = 0 + 1i * 0.08; % Impedance between Bus 1 and Bus 2
Z13 = 0 + 1i * 0.05; % Impedance between Bus 1 and Bus 3
Z23 = 0 + 1i * 0.06; % Impedance between Bus 2 and Bus 3

% Calculate admittance values
y12 = 1 / Z12;
y13 = 1 / Z13;
y23 = 1 / Z23;

% Form the admittance matrix (Y-bus matrix)
Y = [
    y12 + y13, -y12,       -y13;
    -y12,      y12 + y23, -y23;
    -y13,     -y23,        y13 + y23
];

% Power data (in per-unit)
P = [0; (150 - 60) / 100; -100 / 100];    % Real power for each bus
Q = [0; 0; -90 / 100];                    % Reactive power

% Initial voltage magnitudes (in per-unit)
V = [1.025; 1.01; 1.0]; % Initial guess with Bus 1 as slack bus

% Maximum iterations for Gauss-Seidel
max_iter = 10;

% Gauss-Seidel Iteration
fprintf('Iteration Results:\n');
for iter = 1:max_iter
    V_prev = V; % Store previous iteration voltages

    % Update each bus voltage except for the slack bus (Bus 1)
    for i = 2:length(V)
        sum_YV = 0;
        for j = 1:length(V)
            if j ~= i
                sum_YV = sum_YV + Y(i,j) * V(j);
            end
        end
        V(i) = (1 / Y(i,i)) * ((P(i) - 1i * Q(i)) / conj(V(i)) - sum_YV);
    end
    
    % Calculate Q2 based on updated V2
    Q(2) = -abs(V(2))^2 * (imag(Y(2,1)) * abs(V(1)) * sin(angle(V(1) - V(2))) ...
                           + imag(Y(2,3)) * abs(V(3)) * sin(angle(V(3) - V(2))));

    % Calculate error in V2 (V2c) for this iteration
    V2c = abs(V(2)) - abs(V_prev(2));  % Error in voltage magnitude at Bus 2

    % Display results for this iteration
    fprintf('Iteration %d:\n', iter);
    fprintf('  V2 = %.4f + j%.4f (|V2| = %.4f, Angle = %.4f degrees)\n', real(V(2)), imag(V(2)), abs(V(2)), angle(V(2)) * (180/pi));
    fprintf('  V3 = %.4f + j%.4f (|V3| = %.4f, Angle = %.4f degrees)\n', real(V(3)), imag(V(3)), abs(V(3)), angle(V(3)) * (180/pi));
    fprintf('  Q2 = %.4f pu\n', Q(2));
    fprintf('  V2c (Error in V2) = %.4f pu\n\n', V2c);
end

% Final Results
disp('Final Voltage Magnitudes and Angles at each bus:');
for i = 1:length(V)
    fprintf('Bus %d: |V| = %.4f, Angle = %.4f degrees\n', i, abs(V(i)), angle(V(i)) * (180/pi));
end
disp('Final Q values:');
fprintf('Q2 = %.4f pu\n', Q(2));

% Calculate Line Currents and Power Flows
fprintf('\nLine Currents and Power Flows:\n');
line_losses = 0; % Initialize total line losses

% Initialize values
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

% Display line current results
fprintf('I12 = %.4f + j%.4f pu\n', real(I12), imag(I12));
fprintf('I21 = %.4f + j%.4f pu\n', real(I21), imag(I21));
fprintf('I13 = %.4f + j%.4f pu\n', real(I13), imag(I13));
fprintf('I31 = %.4f + j%.4f pu\n', real(I31), imag(I31));
fprintf('I23 = %.4f + j%.4f pu\n', real(I23), imag(I23));
fprintf('I32 = %.4f + j%.4f pu\n', real(I32), imag(I32));

% Display power flow results
fprintf('\nPower Flows:\n');
fprintf('S12 = %.4f + j%.4f pu\n', real(S12), imag(S12));
fprintf('S21 = %.4f + j%.4f pu\n', real(S21), imag(S21));
fprintf('S13 = %.4f + j%.4f pu\n', real(S13), imag(S13));
fprintf('S31 = %.4f + j%.4f pu\n', real(S31), imag(S31));
fprintf('S23 = %.4f + j%.4f pu\n', real(S23), imag(S23));
fprintf('S32 = %.4f + j%.4f pu\n', real(S32), imag(S32));

% Display line losses
fprintf('\nLine Losses:\n');
fprintf('SL12 = %.4f + j%.4f pu\n', real(SL12), imag(SL12));
fprintf('SL13 = %.4f + j%.4f pu\n', real(SL13), imag(SL13));
fprintf('SL23 = %.4f + j%.4f pu\n', real(SL23), imag(SL23));

% Calculate P1 and Q1
P1 = real(S12 + S13);
Q1 = imag(S12 + S13);

% Display P1 and Q1
fprintf('\nP1 = %.4f pu\n', P1);
fprintf('Q1 = %.4f pu\n', Q1);
