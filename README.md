# GCD_Course_Project

Getting and Cleaning Data Course Project

This file has been created for Coursera course as a assigment.

Created by Jouni Huopana 22 April 2015

Works only with particular input data files provided in the course.

This code has specific paths set to work in Windows enviroment. If using another OS, check the proper function of the file structure.

The R-code run_analysis.R takes specific input files and reduces the files into a single data frame.

##R-code has the following structure
1. Reads common features for both "train" and "test" data
2. Reads "training" data and combines it with common feature data
3. Reads "test" data and combines it with common feature data
4. Merging "train" and "test" data frames into one data frame
5. Reduces the merge data to only have the columns with "mean" and "std" values
6. Creates a new tidy data set with mean for each subject and activity
7. Writes the tidy data set as a txt (tidyData.txt). 


