% Example MATLAB Code to Remove Harmonics

% Sample Rate and Time
Fs = 1000; % Sampling frequency (Hz)
t = 0:1/Fs:1; % Time vector (1 second)

% Power System Waveform with Harmonics (50 Hz, 150 Hz, 250 Hz)
f1 = 50;   % Fundamental frequency
f2 = 150;  % 2nd Harmonic
f3 = 250;  % 3rd Harmonic
waveform = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 0.3*sin(2*pi*f3*t); 

% Plot the original waveform
subplot(2, 1, 1);
plot(t, waveform);
title('Original Power System Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

% Design a low-pass Butterworth filter to remove harmonics above 60 Hz
cutoff = 60; % Cutoff frequency for low-pass filter (Hz)
[b, a] = butter(6, cutoff / (Fs / 2), 'low');  % 6th-order filter

% Apply the filter
filtered_waveform = filter(b, a, waveform);

% Plot the filtered waveform
subplot(2, 1, 2);
plot(t, filtered_waveform);
title('Filtered Power System Waveform');
xlabel('Time (s)');
ylabel('Amplitude');

% FFT of original and filtered waveforms
figure;
subplot(2, 1, 1);
fft_original = fft(waveform);
f = Fs * (0:(length(waveform)/2)) / length(waveform); % Frequency vector
plot(f, abs(fft_original(1:length(f))));
title('FFT of Original Signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(2, 1, 2);
fft_filtered = fft(filtered_waveform);
plot(f, abs(fft_filtered(1:length(f))));
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
