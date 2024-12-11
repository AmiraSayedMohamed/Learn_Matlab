% Combined Code for Harmonic Analysis and Removal in Power Systems using FFT and Filtering
clc;
clear;
close all;
% Sampling parameters
Fs = 1000; % Sampling frequency (Hz)
T = 1;     % Duration of the signal in seconds
t = 0:1/Fs:T-1/Fs; % Time vector

% Generate the power system waveform (fundamental + harmonics)
f1 = 50;   % Fundamental frequency (50 Hz)
f2 = 150;  % 2nd Harmonic (3x the fundamental frequency)
f3 = 250;  % 3rd Harmonic (5x the fundamental frequency)
waveform = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 0.3*sin(2*pi*f3*t); % Power system waveform

% Plot the original waveform
figure;
subplot(3,1,1);
plot(t, waveform);
title('Power System Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

% Apply FFT to the signal
n = length(waveform);      % Length of the signal
f = Fs*(0:(n/2))/n;        % Frequency vector for plotting
Y = fft(waveform);         % Perform the FFT
P2 = abs(Y/n);             % Two-sided spectrum
P1 = P2(1:n/2+1);          % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1); % Adjust amplitude for single-sided spectrum

% Plot the FFT of the original signal
subplot(3,1,2);
plot(f, P1);
title('FFT of Power System Waveform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;

% Find the closest index for harmonics in the frequency vector
[~, idx1] = min(abs(f - f1)); % Closest index to fundamental frequency
[~, idx2] = min(abs(f - f2)); % Closest index to second harmonic
[~, idx3] = min(abs(f - f3)); % Closest index to third harmonic

% Highlight the harmonics
hold on;
plot(f(idx1), P1(idx1), 'ro'); % Plot the fundamental harmonic
plot(f(idx2), P1(idx2), 'ro'); % Plot the second harmonic
plot(f(idx3), P1(idx3), 'ro'); % Plot the third harmonic
legend('FFT Spectrum', 'Harmonics');
hold off;

% Design a low-pass Butterworth filter to remove harmonics above 60 Hz
cutoff = 60; % Cutoff frequency for low-pass filter (Hz)
[b, a] = butter(6, cutoff / (Fs / 2), 'low');  % 6th-order filter

% Apply the filter to remove harmonics
filtered_waveform = filter(b, a, waveform);

% Plot the filtered signal
subplot(3,1,3);
plot(t, filtered_waveform);
title('Filtered Power System Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

% FFT of filtered signal
figure;
subplot(2,1,1);
fft_filtered = fft(filtered_waveform);
plot(f, abs(fft_filtered(1:length(f))));
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Highlight the harmonics in the filtered signal
hold on;
plot(f(idx1), abs(fft_filtered(idx1)), 'ro'); % Plot the fundamental harmonic
plot(f(idx2), abs(fft_filtered(idx2)), 'ro'); % Plot the second harmonic
plot(f(idx3), abs(fft_filtered(idx3)), 'ro'); % Plot the third harmonic
legend('FFT Spectrum', 'Harmonics');
hold off;

subplot(2,1,2);
plot(f, abs(fft_filtered(1:length(f))));
title('Filtered Signal - FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
