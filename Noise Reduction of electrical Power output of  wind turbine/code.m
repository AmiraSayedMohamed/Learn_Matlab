fs=8000;         % Sampling rate
T=1/fs;          % Sampling period
x=test;          % Noisy signal
n=length(x);
x_fft=(1/n)*abs(fft(x));         % Calculate the amplitude spectrum

% Calculate the single-sided spectrum
f_axis=[0:1:n/2]*fs/n;
x_fft(2:n)=2*x_fft(2:n);      
o=37;WnL=0.225;WnH=0;fs=8000;
b=fir1(o,WnL,'low');
[h w]=freqz(b,1,1024,fs);

% Perform digital filtering
y=filter(b,1,x);

figure;
subplot(2,1,1);plot(w,abs(h));
xlabel('Frequency (Hz)');ylabel('Magnitude response');
phi=180*unwrap(angle(h));
subplot(2,1,2);plot(w,phi);
xlabel('Frequency (Hz)');ylabel('Phase response (degrees)');

% Single-sided spectrum of the filtered data
y_fft=(1/n)*abs(fft(y));
y_fft(2:n)=2*y_fft(2:n);

figure;
subplot(2,1,1);plot(f_axis,x_fft(1:n/2+1));
xlabel('Frequency (Hz)');ylabel('Amplitude');
subplot(2,1,2);plot(f_axis,y_fft(1:n/2+1));
xlabel('Frequency (Hz)');ylabel('Amplitude');

% plotting noisy and noiseless signal  
figure;
subplot(2,1,1);plot(x);
xlabel('Number of samples');ylabel('Noisy Signal');
subplot(2,1,2);plot(y);
xlabel('Number of samples');ylabel('Pure Signal');


