# Electrocardiography-ECG-Analysis
This repository contains MATLAB code for basic ECG (Electrocardiogram) signal analysis and feature extraction. The code demonstrates how to load ECG data, plot the signal, calculate R-R intervals, assess heart rate variability (HRV), and analyze electrical alternans.

# Features
ECG Signal Plotting: Visualizes the ECG signal with time in seconds and amplitude in millivolts.
R-R Interval Calculation: Identifies R-peaks in the ECG signal and calculates the intervals between consecutive R-peaks, which are crucial for analyzing the heart's rhythm.
Heart Rate Variability (HRV): Computes HRV by converting R-R intervals to heart rate in beats per minute (BPM), providing insights into the autonomic nervous system's control over the heart.
Electrical Alternans: Calculates the differences between consecutive R-peak amplitudes, which can be an important indicator of certain cardiac conditions.

# Usage
Load your ECG data into MATLAB. Here an ECG recording from the ECG-ID Database is used. 
Run the script to visualize the ECG signal, R-R intervals, HRV, and electrical alternans.
Modify the parameters such as sampling rate and peak height threshold as needed to suit your data.

# Requirements
MATLAB
Signal Processing Toolbox 

# License
This project is open-source and available under the MIT License.

# Contributions
Contributions are welcome! Please feel free to submit a pull request or open an issue if you have suggestions for improvements or new features.

# References
Lugovaya T.S. Biometric human identification based on electrocardiogram. [Master's thesis] Faculty of Computing Technologies and Informatics, Electrotechnical University "LETI", Saint-Petersburg, Russian Federation; June 2005.
