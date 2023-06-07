BCI Final project  
===

Comparison of Different Methods in EEG Artifact Removal and Reconstruction
---
### Member:  
108011110 杜碩彥  
108020013 林昱翔  
111591519 洪維妮

I. Introduction
---
The EEG raw data collected by the electrodes normally contained a significant amount of noise such as signal interference from adjacent electrodes, large resistance of electrodes and the brain, facial expressions, eye movements and mouth movements. To get the data with better resolution so that it can make use for analyzing brain waves, plenty of ways were designed for removing artifacts. 

The available methods for removing noise and separating signals from EEG raw data, ranging from traditional mathematical methods such as filtering and ASR to current popular AI models such as CNN. To compare the differences between these methods through the evaluation techniques is our aim in this project.

The existing signal processing algorithms that we use include 2 functions from EEGlab in Matlab and 2 Al models listed as follows:  
1. EEG Filter (Math) [1]   
2. ASR (Math) [2]  
3. IC-UNet (AI Model) [3]  
4. UNet++ (AI Model) [4]

We will use these methods applied to the same EEG data (Motor-Imagery) for processing the signal. And compare the differences between the efficacy among the signal processing methods by different evaluation techniques including PSD. Each result will then be compared with the raw data, to distinguish the difference.  

II. Dataset
---
The data set we use in practice is the EEG datasets for motor imagery brain computer interface from GigaDB [5], which contains EEG recordings of subjects performing grasp-and-lift (GAL) trials. There are 52 subjects in total. Among them, we removed subjects number 2, 12, 13, 17 and  33 from our data analysis. Due to the abnormal signaling detection, which received only brain components and only showed activations in certain regions in the brain through the IClabel.

So there are only 47 data sets we use for analyzing. To reduce the redundant and same-source signal reception, we choose 30 out of 64 channel (Four channels  from Electrode patch to detect the movement from muscles be excluded from the original 68 channels). The original sampling rate was 512, downsample to 256.

The channel location of 30 channels is as following:


III. Model Framework & Validation
---
The goal is to use these different algorithms to reject unwanted signals so we can identify when a hand is conducting specific movements using EEG data. The PSD values resulting from different algorithms will be calculated and compared. Also, through the ICA function in EEGLab, different sources (brain, eye, muscle, heart, Channel Noise, Line Noise, others) are separated from the EEG signals. The differences between the raw data and various processing methods are compared after using IClabel to observe whether the number of brain signals has increased. 

The brain component from the quantity column is an important index of how clean the data is. It indicates on average how many channels out of 30 channels does the signal coming from the brain component. Therefore, the higher this value is, the better the signal is. Again, we are using this method to compare the result of different signals coming from different algorithms.

IV. Usage
---
V. Results
---
VI. References
---

## 
## 
`
test
`
- 
