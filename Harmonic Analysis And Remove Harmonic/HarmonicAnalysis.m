% Harmonic Analysis in Power Systems using FFT
% This code generates a power supply waveform and applies FFT to detect harmonics.

% Sampling parameters
fs = 1000;               % Sampling frequency in Hz
T = 1;                   % Duration of the signal in seconds
t = 0:1/fs:T-1/fs;       % Time vector

% Generate the power system waveform (fundamental + harmonics)
f1 = 50;                 % Fundamental frequency (50 Hz)
f2 = 150;                % Second harmonic (3x the fundamental frequency)
f3 = 250;                % Third harmonic (5x the fundamental frequency)

% Create the signal
signal = 1*sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 0.3*sin(2*pi*f3*t);

% Plot the original waveform
figure;
subplot(2,1,1);
plot(t, signal);
title('Power System Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

% Apply FFT to the signal
n = length(signal);      % Length of the signal
f = fs*(0:(n/2))/n;      % Frequency vector for plotting
Y = fft(signal);         % Perform the FFT
P2 = abs(Y/n);           % Two-sided spectrum
P1 = P2(1:n/2+1);        % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1); % Adjust amplitude for single-sided spectrum

% Plot the FFT result
subplot(2,1,2);
plot(f, P1);
title('FFT of Power System Waveform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;

% Highlight the harmonics
hold on;
[~, idx1] = min(abs(f - f1));  % Find index for f1
[~, idx2] = min(abs(f - f2));  % Find index for f2
[~, idx3] = min(abs(f - f3));  % Find index for f3

plot(f(idx1), P1(idx1), 'ro');  % Plot harmonic f1
plot(f(idx2), P1(idx2), 'ro');  % Plot harmonic f2
plot(f(idx3), P1(idx3), 'ro');  % Plot harmonic f3
legend('FFT Spectrum', 'Harmonics');
hold off;

% Filtering techniques to mitigate harmonics (example: low-pass filter)
fc = 100;                % Cutoff frequency for low-pass filter
[b, a] = butter(6, fc/(fs/2), 'low'); % 6th order Butterworth filter
filtered_signal = filter(b, a, signal);

% Plot the filtered signal
figure;
plot(t, filtered_signal);
title('Filtered Power System Waveform (Low-pass Filter)');
xlabel('Time (s)');
ylabel('Amplitude');
