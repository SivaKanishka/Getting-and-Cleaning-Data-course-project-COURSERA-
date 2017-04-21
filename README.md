### Course project
This repo contains R script file and code book file of the project.  
*This file will expalin all the steps carried out during the project*  
The process of merging and subsetting mean and standard deviation values from the _X-Train_ and _X-test_ are done simulataneously. First, the feature vector was read into _R_. Since the problem statement asked for extracting mean values from features, there are total of 33 measurements on which various summaries are made. So, there will be 33 mean measures and 33 standard deviation measures. Concretley, 33 measurements are:  
1. tBodyAcc-XYZ
2. tGravityAcc-XYZ
3. tBodyAccJerk-XYZ
4. tBodyGyro-XYZ
5. tBodyGyroJerk-XYZ
6. tBodyAccMag
7. tGravityAccMag
8. tBodyAccJerkMag
9. tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag  
Eventhough there are only 17 measurements listed above, measuremnts which have XYZ gives additional three measurements each. So, there will be a total of 66 measures or variables in our dataset. These *mean* and *standard deviation* values are extracted using _grep_ function. The indices extracted from _grep_ function are used to subset columns in X-Train and X-Test data sets. Two separate data sets, namely, train and test, are created after binding _subject_ and _y_ data sets to their respective X-train and X-test data sets. Finally, _train_ and _test_ datasets are merged to make a dataframe called *_df_*. An additional vector with names of variables extracted from _grep_ function is created and names as _feature_names_. The column names of _df_ are changed to *subject_id*, *names from feature_names vector* and *activity*.
The _activity_labels_ data set is read into _R_ and after changing the class of _activity_ variable to _Factor_, names in the activity_label data set are assigned as levels to _activity_ variable.  
The names of variables are formated using _gsub_ function for better comprehension of variables as coded in the R script file using regular expressions and litterals. The complete description about the variables is recorded in the *_Code Book_*.  
The final step of averaging each vaiable for each subject and activity is achieved using _summarise_each_ function. Finally, the _activity_ variable column is shifted to the last column using _select_ function and the final data frame is named as *df_final*. The *df_final* data frame is written to the local system using _write.table_ function and it saved as *Final_Table*.
