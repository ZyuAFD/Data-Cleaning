Data-Cleaning
=============

Assignment for Coursera Data Cleaning

Run.analysis.r:
	reads Samsung activity data from test and train sub-directories;
	
	merges in column names, activity names, and subject ids

	combines the post-merge rows from the test and train (uning rbind)
 
	retains measurement columns if and only if tey contain the string "std" or "mean"
		(observations representing means and standard deviations)

	calculates means for each retained measurement by subject and activity;

	and outputs a tidy data set: tidy_version_means.csv.txt

	In the output data set, column names for within-subject-and-activity mean measurements are the same as the original ciolumn names, with the substring "()" removed.
	


