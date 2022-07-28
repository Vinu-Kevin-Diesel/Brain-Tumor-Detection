# Brain-Tumor-Detection-

### This project aims to identify Brain Tumors in the given MRI scans of brain using Morphological operations.

#### Data Augmentation - We are working on a project that belongs to health field. So this should
be more accurate. The dataset has less images(155 for yes and 98 for
no). So we used data augmentation for increasing the size of dataset. We
used “keras.preprocessing.image” library in python for this process.

#### Training - The training part is implemented to test the accuracy of the model where we
fed 2 types of MRI brain images (with and without Brain Tumor). 

#### Testing - In this phase, Random (with or without) MRI Brain scans are fed and the result () are obtained. The brain tumor are highlighted using bwboundaries function for better understanding of tumor location.

#### Result - The model yields 94.15% accuracy when a MRI scan with brain tumor is fed. 
