
%% ECG Analysis

% Load the ECG data
load('rec_1m.mat'); % 'val' variable containning the ECG signal is in the file

% Create a new figure for plotting
figure;

% Define the time vector for the first 10,000 samples
t = 1:10000;

% Plot the ECG signal
% - The time axis is converted from samples to seconds by dividing by the sampling rate (500 Hz)
% - The amplitude of the ECG signal is converted from raw units to millivolts by dividing by 128
plot(t / 500, val(2, t) / 128);

% Label the x-axis as 'Time' in seconds
xlabel('Time (seconds)');

% Label the y-axis as 'Amplitude' in millivolts
ylabel('Amplitude (millivolts)');

% Set the title of the plot to indicate ECG data from which patient and record is being displayed
title('ECG - P1R1');

%% R-R interval calculation
% Find peaks in the ECG signal with a minimum peak height of 100
[pks, locs] = findpeaks(val(2, :), 'MinPeakHeight', 100);

% Plot the ECG signal and mark the detected R-peaks
figure;
plot(val(2, :)); % Plot the ECG signal
hold on; % Hold the current plot
plot(locs, pks, 'ro'); % Mark the R-peaks with red circles
xlabel('Sample');
ylabel('Amplitude');

% Calculate the R-R intervals (differences between consecutive R-peak locations)
i = 2:length(locs); % Index vector starting from the second peak
RR = locs(i) - locs(i - 1); % R-R intervals

% Plot the R-R intervals
figure;
plot(RR / 500); % Convert intervals from samples to seconds by dividing by the sampling rate (500 Hz)
xlabel('Beat Number');
ylabel('R-R Interval (seconds)');

%% Heart Rate Variability (HRV)
figure;
plot(500 * 60 ./ RR); % Convert R-R intervals to heart rate in beats per minute (BPM)
xlabel('Beat Number');
ylabel('HRV (BPM)');

%% Electrical Alternans
i = 2:length(pks); % Index vector starting from the second peak
alter = pks(i) - pks(i - 1); % Differences between consecutive R-peak amplitudes
figure;
plot(alter); % Plot the R-wave alternance
xlabel('Beat Number');
ylabel('Alternans');

