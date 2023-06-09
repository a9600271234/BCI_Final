BCI Final project  
===

Comparison of Different Methods in EEG Artifact Removal and Reconstruction
---
### Member:  
108011110 杜碩彥  
108020013 林昱翔  
111591519 洪維妮

### Video:
Link: https://www.youtube.com/watch?v=96Sgieqna6s&ab_channel=Bratis

I. Introduction
---
The raw EEG data collected by the electrodes typically contains a significant amount of noise, including signal interference from adjacent electrodes, high electrode and brain resistance, as well as artifacts from facial expressions, eye movements, and mouth movements. To improve the resolution of the data and facilitate analysis of brain waves, various methods have been developed to remove these artifacts.  

There are several available techniques for removing noise and separating signals from raw EEG data, ranging from traditional mathematical methods such as filtering and Artifact Subspace Reconstruction (ASR), to more recent AI models such as Convolutional Neural Networks (CNN). In this project, our objective is to compare and evaluate the differences among these methods using various evaluation techniques.

The signal processing algorithms we will be using include two built-in functions from EEGLAB in Matlab and two AI models. The specific methods are as follows:
1. EEG Filter (Math) [1]   
2. ASR (Math) [2]  
3. UNet++ (AI Model) [3]  
4. IC-UNet (AI Model) [4]

We will employ these four methods to remove artifacts and then compare and evaluate the results using ICLable and PSD in EEGLAB. This analysis will help us determine which methods exhibit better performance.

II. Dataset
---

The dataset we used is motor imagery dataset in brain-computer interface from GigaDB [5]. This dataset comprises EEG recordings of subjects performing grasp-and-lift (GAL) trials. Initially, there were a total of 52 subjects included in the dataset. However, we excluded subjects number 2, 12, 13, 17, and 33 from our data analysis due to abnormal signaling detection. These subjects exhibited brain activations in specific regions, as identified through IClabel analysis.  

Consequently, we were left with a total of 47 datasets for analysis. To minimize redundant and overlapping signal reception, we selected 30 out of the original 64 channels (as shown in Fig.1). Four channels from the electrode patch, which were used to detect muscle movements, were excluded from the original 68 channels. The original sampling rate of the data was 512, which we downsampled to 256 to facilitate further analysis.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/30_channel/ch.png)  
Fig.1. The channel location of 30  channels.   

III. Model Framework & Validation
---
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/framework.png)  
Fig.2. Models flow and framework 

The objective of this study is to utilize different algorithms to eliminate unwanted signals in order to identify specific hand movements using EEG data. The Power Spectral Density (PSD) values obtained from these algorithms will be calculated and compared. Additionally, the ICA (Independent Component Analysis) function in EEGLAB will be employed to separate different sources (brain, eye, muscle, heart, channel noise, line noise, etc.) from the EEG signals. The differences between the raw data and various processing methods will be compared by using IClabel to observe whether the number of brain signals has increased.  

The "brain component" value in the quantity column serves as a crucial indicator of data cleanliness. It represents the average number of channels out of the 30 selected channels that contain brain signals. Therefore, a higher value indicates a cleaner signal. This metric will be used to compare the results obtained from different algorithms and signal processing techniques.  


IV. Usage
---
### Environment and Softwares used:
- Matlab 2021a
- EEGLAB
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
### - ICLable
The components detected in motor imagery EEG datasets can be divided into brain, eye muscle, heart, channel noise, line noise and others. The means of  heart, channel noise and line noise didn’t show statistically significant no matter the usage of artifact removal methods. Wile the means of components of eyes and muscle have edged up, with the mean of raw data 0, treated with Filer, ASR, UNet++,  ICUnet and labeled with ICA, but it is still relatively small. Brain and others are the relatively large portion of the components to be classified in this data.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/bar/bar.png)  
Fig.3. Mean of quantity of brain Componet by different methods

The number of the brain components in an EEG data, the more quantities it has, the more accuracy and reliability of the data is. Through the process of Filter, ASR, UNet++ and ICUnet, the numbers of brain components in EEG data have increased(Fig.3 to 12). The means, 8.51, 13.51, 25.13 and 19.15, respectively represent the value of  the brain components contained in data after we remove the noise by the above methods. Compared with the original mean 1.38 from raw data, each of the four methods performed a great rise. Also the components that are classified as others have decreased.   

The mean of the others components detected in raw data is 28.62, and the means detected in Filter, ASR, UNet++ and ICUnet are 21.11, 15.28, 4.85 and 10.6. Gathering the information of the different means, the increase in brain and the decrease in others components, all of the approaches to obtain the filtered data have gained a better resolution than those without filtered.   

The value obtained from UNet++ shows a significant difference in contrast with others. Indicated a better efficiency among the four algorithms. In addition, the components of eyes and muscle can be separated after ICA, but it is still relatively small. Brain and others are the relatively large portion of the components to be classified in this data.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/Comb_graph/Comb_Raw.png)   
Fig.4. The 2D and 3D plot of raw data from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/Comb_graph/Comb_Filter.png)  
Fig.5. The 2D and 3D plot of data processed by filter from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/Comb_graph/Comb_ASR.png)  
Fig.6. The 2D and 3D plot of data processed by ASR from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/Comb_graph/Comb_Unetpp.png)  
Fig.7. The 2D and 3D plot of data processed by UNet++ from the fifth subject.  
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/Comb_graph/Comb_ICUNet.png)    
Fig.8. The 2D and 3D plot of data processed by IC-UNet from the fifth subject.  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/data/long_table.jpeg)   
Fig.9. The result table of differnet way of artifact removal   

### - PSD
![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/info.png)  
Fig.11. Setting of PSD plot  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/raw.png)    
Fig.12. PSD of the raw data of fifth subject  

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/filter.png)    
Fig.13. PSD of the data after filtered of fifth subject   

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/ASR.png)  
Fig.14. PSD of the data after ASR of fifth subject   

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/Unet_pp.png)  
Fig.15. PSD of the data after UNet++ of fifth subject   

![image](https://github.com/a9600271234/BCI_Final/blob/main/Image/PSD/ICUNET.png)  
Fig.16. PSD of the data after IC-UNet of fifth subject   

In the raw data, it is evident that low-frequency components exhibit higher log power spectral density, with a significant number of channels showing signals exceeding 50 and reaching a maximum of 60 μV<sup>2</sup>/Hz. 

After applying the Filter and Filter+ASR techniques, both methods exhibit similar PSD distributions, albeit with slightly lower overall intensity in the ASR approach. 

Under the UNet++ model, there is a noticeable reduction in overall intensity, resulting in comparable signal strengths among channels in both low-frequency and high-frequency ranges. As for IC-UNet, the overall intensity is relatively higher compared to UNet++, while maintaining comparable signal strengths among individual channels.


VI. References
---
[1] Gonçales, L., Farias, K., Kupssinskü, L., & Segalotto, M. (2021). The effects of applying filters on EEG signals for classifying developers’ code comprehension. Journal of Applied Research and Technology, 19(6), 584-602.

[2] Patrick Bloniasz. (2022). Artifact Subspace Reconstruction (ASR) for electroencephalography artifact removal must be optimized for each unique dataset. Qeios. doi:10.32388/SMEI50. 

[3] Zhou, Z., Rahman Siddiquee, M. M., Tajbakhsh, N., & Liang, J
(2018). Unet++: A nested -net architecture for medical image segmentation. In Deep Learning in Medical Image Analysis and Multimodal Learning for Clinical Decision Support: 4th International Workshop, DLMIA 2018, and 8th International Workshop, ML-CDS 2018, Held in Conjunction with MICCAI 2018, Granada, Spain, September 20, 2018, Proceedings 4 (pp. 3-11). Springer International Publishing.    

[4] Chuang CH, Chang KY, Huang CS, Jung TP. IC-U-Net: A U-Net-based Denoising Autoencoder Using Mixtures of Independent Components for Automatic EEG Artifact Removal. Neuroimage. 2022 Nov;263:119586. doi: 10.1016/j.neuroimage.2022.119586. Epub 2022 Aug 27. PMID: 36031182.

[5] http://gigadb.org/dataset/100295  

[6] Luciw, M., Jarocka, E. & Edin, B. Multi-channel EEG recordings during 3,936 grasp and lift trials with varying weight and friction. Sci Data 1, 140047 (2014).    


