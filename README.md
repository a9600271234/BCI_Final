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

So there are only 47 data sets we use for analyzing. To reduce the redundant and same-source signal reception, we choose 30 (Fig.1) out of 64 channel (Four channels  from Electrode patch to detect the movement from muscles be excluded from the original 68 channels). The original sampling rate was 512, downsample to 256.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/30_channel/ch.png)  
Fig.1. The channel location of 30  channels.  

The goal is to use these different algorithms to reject unwanted signals so we can identify when a hand is conducting specific movements using EEG data. The PSD values resulting from different algorithms will be calculated and compared. Also, through the ICA function in EEGLab, different sources (brain, eye, muscle, heart, Channel Noise, Line Noise, others) are separated from the EEG signals. The differences between the raw data and various processing methods are compared after using IClabel to observe whether the number of brain signals has increased. 

The brain component from the quantity column is an important index of how clean the data is. It indicates on average how many channels out of 30 channels does the signal coming from the brain component. Therefore, the higher this value is, the better the signal is. Again, we are using this method to compare the result of different signals coming from different algorithms.

Usage : Describe the usage of their BCI model's code. Explain the required environment and dependencies needed to run the code. Describe any configurable options or parameters within the code. Provide instructions on how to execute the code.


III. Model Framework & Validation
---
The goal is to use these different algorithms to reject unwanted signals so we can identify when a hand is conducting specific movements using EEG data. The PSD values resulting from different algorithms will be calculated and compared. Also, through the ICA function in EEGLab, different sources (brain, eye, muscle, heart, Channel Noise, Line Noise, others) are separated from the EEG signals. The differences between the raw data and various processing methods are compared after using IClabel to observe whether the number of brain signals has increased. 

The brain component from the quantity column is an important index of how clean the data is. It indicates on average how many channels out of 30 channels does the signal coming from the brain component. Therefore, the higher this value is, the better the signal is. Again, we are using this method to compare the result of different signals coming from different algorithms.

IV. Usage
---
### Enviromnet and Softwares used:
- Matlab 2021a
- EEGlab 
- Python 3.8
- PyTorch 1.7.1

### Step


1. Download the dataset from http://gigadb.org/dataset/100295. The format of this dataset is .mat documents. However, the later process of artifact removal requires the use of .set and .csv formats, so we need to process it later.

2. Use the Step0_extract_EEG.m file in the code folder to extract the EEG part of the data.

3. Use the Step1_to_30ch.m file in the code folder to extract the 30 channels we need for later processing from the dataset generated in step 2.

4. Use the Step2_ICA.m file in the code folder to generate the data after applying ICA with raw data, ICA with filtered data, ICA with filtering and ASR individually. You can choose the desired method in the code.

5. Use the Step3_ICA.m file in the code folder to calculate the mean and average quantity of each component after different methods of artifact removal.

6. The UNet++ and ICUNet models and their usage can be found at https://github.com/roseDwayane/AIEEG. The data format required by the AI model is .csv, and you can use the Step4_extract_csv.m file in the code folder to extract the EEG signal.

7. Finally, use the Step5_csv_to_set.m file in the code folder to transform the data after the AI model from .csv to .set format. Then, follow step 5 to calculate the result.


V. Results
---
The components detected in motor imagery EEG datasets can be divided into brain, eye muscle, heart, channel noise, line noise and others. The means of  heart, channel noise and line noise didn’t show statistically significant no matter the usage of artifact removal methods. Wile the means of components of eyes and muscle have edged up, with the mean of raw data 0, treated with Filer, ASR, UNet++,  ICUnet and labeled with ICA, but it is still relatively small. Brain and others are the relatively large portion of the components to be classified in this data.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/bar/bar.png)  
Fig.2. Mean of quantity of brain Componet by different methods

The number of the brain components in an EEG data, the more quantities it has, the more accuracy and reliability of the data is. Through the process of Filter, ASR, UNet++ and ICUnet, the numbers of brain components in EEG data have increased(Fig.2, 3, 4, 5, 6). The means, 8.51, 13.51, 25.13 and 19.15, respectively represent the value of  the brain components contained in data after we remove the noise by the above methods. Compared with the original mean 1.38 from raw data, each of the four methods performed a great rise. Also the components that are classified as others have decreased.   

The mean of the others components detected in raw data is 28.62, and the means detected in Filter, ASR, UNet++ and ICUnet are 21.11, 15.28, 4.85 and 10.6. Gathering the information of the different means, the increase in brain and the decrease in others components, all of the approaches to obtain the filtered data have gained a better resolution than those without filtered.   

The value obtained from UNet++ shows a significant difference in contrast with others. Indicated a better efficiency among the four algorithms. In addition, the components of eyes and muscle can be separated after ICA, but it is still relatively small. Brain and others are the relatively large portion of the components to be classified in this data.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/2D/5_2D_RAW.png)  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/3D/5_3D_RAW.png)  
Fig.3 & 4. The 2D and 3D plot of raw data from the fifth subject.
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/2D/5_2D_Filter.png)  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/3D/5_3D_Filter.png)  
Fig.5 & 6. The 2D and 3D plot of data processed by filter from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/2D/5_2D_ASR.png)
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/3D/5_3D_ASR.png)  
Fig.7 & 8. The 2D and 3D plot of data processed by ASR from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/2D/5_2D_UNet_PP.png)  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/3D/5_3D_UNet_PP.png)  
Fig.9 & 10. The 2D and 3D plot of data processed by UNet++ from the fifth subject. 
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/2D/5_2D_ICUnet.png)  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/3D/5_3D_ICUnet.png)  
Fig.10 & 11. The 2D and 3D plot of data processed by ICUnet from the fifth subject.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/data/1.png)  
Fig. 12 The result of Raw data  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/data/2.png)  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/data/3.png)  
Fig. 13 & 14 The result of differnet way of artifact removal   

VI. References
---
[1] Gonçales, L., Farias, K., Kupssinskü, L., & Segalotto, M. (2021). The effects of applying filters on EEG signals for classifying developers’ code comprehension. Journal of Applied Research and Technology, 19(6), 584-602.

[2] Patrick Bloniasz. (2022). Artifact Subspace Reconstruction (ASR) for electroencephalography artifact removal must be optimized for each unique dataset. Qeios. doi:10.32388/SMEI50. 

[3] Chuang CH, Chang KY, Huang CS, Jung TP. IC-U-Net: A U-Net-based Denoising Autoencoder Using Mixtures of Independent Components for Automatic EEG Artifact Removal. Neuroimage. 2022 Nov;263:119586. doi: 10.1016/j.neuroimage.2022.119586. Epub 2022 Aug 27. PMID: 36031182.

[4] Zhou, Z., Rahman Siddiquee, M. M., Tajbakhsh, N., & Liang, J
(2018). Unet++: A nested -net architecture for medical image segmentation. In Deep Learning in Medical Image Analysis and Multimodal Learning for Clinical Decision Support: 4th International Workshop, DLMIA 2018, and 8th International Workshop, ML-CDS 2018, Held in Conjunction with MICCAI 2018, Granada, Spain, September 20, 2018, Proceedings 4 (pp. 3-11). Springer International Publishing.    

[5] http://gigadb.org/dataset/100295  

[6] Luciw, M., Jarocka, E. & Edin, B. Multi-channel EEG recordings during 3,936 grasp and lift trials with varying weight and friction. Sci Data 1, 140047 (2014).    
