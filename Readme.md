Folder/File Hierarchy
------------------------------------
'ExampleDriver.m' %Preliminary example of filtering
'Example_filtered.mat' %Exampled of filtered image for ZCA whitening
Outex_SS_00000
	'GT2TrainingData.m' %DRIVER: Goes to each folder 000-099 and generates Data#.ras from GT#.mat and Train_01.ras-Train05.ras
	-000
	-001
	-002
	...
	-099
		'Train_01.ras'-'Train_05.ras' %Training Textures we use to build filter bank
		'filter.mat' %generated filter bank
		'Data1.ras'-'Data1000.ras' %randomly generated problems for training machine learning algorithms (correspond to ground truths) 
		'Problem.ras' %Final Testing image
		'Features1.mat'-'Features1000.mat' %Extracted features from each image (Get histogram w/ ewtc(i,j,:))
groundtruths
	'GT1.mat'-GT1000.mat' %Ground Truths that correspond to each Data image/Feature file -> For training


EWT
	Contains entire Empirical Wavelet Transform package
	-> Used functions include
		- 
PolarLab
	Contains entire PolarLab package (from link)
	-> Used functions include
		- PPFFT() is used by the empirical curvelet transform
FilterBanks
	'buildSupervisedTextureFilterBank.m' %FUNC: used to generate filterbank from five training textures
	'applyFilterBank.m' %FUNC: Used to apply filter bank to Data#.ras and get Features#.mat
	'FilterBankCreationDriver.m' %DRIVER: Builds filter bank for each folder 000-099
	'
CNN
	'CNN_FCNT.m' %Fully Convolutional Network for Textures
SVM
KNN