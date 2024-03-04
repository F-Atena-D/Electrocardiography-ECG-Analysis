
%% Pan–Tompkins Algorithm

% Clear the workspace, close all figures, and clear the command window
clc; clear;

% Load the ECG data 
load('rec_3m.mat') % 'val' variable is in the file

% Define the gain and sampling rate
gain = 128;
fs = 500;

% Define the time vector for the first 10,000 samples
t = 1:10000;

% Extract the ECG signal from the second row of 'val' and scale it by the gain
ecg = val(2, t) / gain;

% Plot the original ECG signal
figure;
plot(t / fs, ecg);
title('ECG')
xlabel('Time (seconds)');
ylabel('Amplitude (millivolts)');

% Remove baseline wander from the ECG signal using FFT
N = length(ecg);
M = N;
k = round(M / fs);
y = fft(ecg, M);
y(1:k) = 0;
y((M - k + 2):M) = 0;
ecg = ifft(y, M);

% Plot the ECG signal without baseline wander
figure;
plot(t / fs, ecg)
title('ECG without baseline')
xlabel('Time (seconds)');
ylabel('Amplitude (millivolts)');

% Apply a low-pass filter (LPF) to the ECG signal
LPF_num = (1 / 32) * [1 0 0 0 0 0 -2 0 0 0 0 0 1];
LPF_den = [1 -2 1];
[LPF_h, LPF_w] = freqz(LPF_num, LPF_den);
figure;
subplot(2, 1, 1);
plot(LPF_w / pi, abs(LPF_h));
title('LPF');
xlabel('\omega/\pi')
ylabel('Amplitude');
y_LPF = filter(LPF_num, LPF_den, ecg);
subplot(2, 1, 2);
plot(t / fs, y_LPF);
title('LPF-Filtered ECG');
xlabel('Samples')
ylabel('Amplitude');

% Apply a high-pass filter (HPF) to the ECG signal
HPF_num = (1 / 32) * [-1 zeros(1, 15) 32 -32 zeros(1, 14) 1];
HPF_den = [1 -1];
[hpf_h, hpf_w] = freqz(HPF_num, HPF_den, 1024);
figure; subplot(2, 1, 1);
plot(hpf_w / pi, abs(hpf_h));
title('HPF Filter');
xlabel('\omega/\pi')
ylabel('Amplitude');
y_HPF = filter(HPF_num, HPF_den, ecg);
subplot(2, 1, 2);
plot(t / fs, y_HPF);
title('HPF-Filtered ECG');
xlabel('Samples')
ylabel('Amplitude');

% Combine LPF and HPF to create a band-pass filter (BPF) and apply it to the ECG signal
BPF = filter(LPF_num, LPF_den, ecg);
y_BPF = filter(HPF_num, HPF_den, BPF);
figure;
plot(t / fs, y_BPF);
title('BPF-Filtered ECG');
xlabel('Samples')
ylabel('Amplitude');

% Apply a derivative filter to the band-pass filtered ECG signal to highlight the QRS complex
z = zeros(1, length(y_BPF));
for ii = 5:length(y_BPF)
    z(ii) = (1 / 8) * (2 * y_BPF(ii) + y_BPF(ii - 1) - y_BPF(ii - 3) - 2 * y_BPF(ii - 4));
end
figure;
plot(t / fs, z);
title('Derivatived ECG');
xlabel('Samples')
ylabel('Amplitude');

% Square the derivative-filtered signal to enhance the QRS complex
V = z.^2;
figure;
plot(t / fs, V);
title('Squared ECG');
xlabel('Samples')
ylabel('Amplitude');

% Apply a moving average filter to the squared signal to smooth it and further enhance the QRS complex
w = zeros(1, length(V));
for ii = 31:length(V)
    for jj = 0:30
        w(ii) = w(ii) + V(ii - jj) / 30;
    end
end
figure;
plot(t / fs, w);
title('MA-Filtered ECG');
xlabel('Samples')
ylabel('Amplitude');

