# PracticumPhysics
The flavors of physics kaggle competition completed for Regis University's MSDS Practicum 1

# Explanation of Work
My presentation is Practicum 1.pdf that explains my work


# Competition Website
https://www.kaggle.com/c/flavours-of-physics
Please download the following files from the kaggle competition to perform this model:
- check_agreement.csv
- check_correlation.csv
- sample_submission.csv
- test.csv
- training.csv

# The Final Model
### The file "FinalModels" ends with my final two models for my prediction. 
GBC1.pkl and GBC2.pkl are my saved models.
I weighted the predictions 27% GBC1 and 73% GBC2

# Data
The training data is in training.csv
There are 3 test data sets: test.csv, check_correlation.csv, and check_agreement.csv

# Data Exploration
I performed all my data exploration in R and can be found in the EDA.R file.

# Data Cleaning
There appeared to be outliers in the data when looking at boxplots, however the same outliers are also
seen in the test set and they could be important clues to finding this unknown science. 
I cleaned the training file after splitting it into a train (tn) and validation (val) sets because
validation is only performed on data points with an ANN value greater than 0.4  so I romoved any lower
and put them back into the training set to be a 20/80 split.

# Tuning Hyperparameters
The hyperparameter files are the different models I tested to tune my model 

# Submission 
- The JH1101620 was my final submission file to kaggle
- 181008 was my previous prediction on my Tuesday 10/16/2018 presentation making the JH101618 prediction. 

