# Tidy-Data-Assignment

First we set working directory, install plyr as it is a required package

We then set the URL viariable to the assignment URL, and download the data to a file variable.
  

 The assigment involves performing the following repetitive actions
 1- reading data from a file and assigning column headers to it
 2- merging 2 files.
 
 We build two functions to help perform these tasks
First function 'Readd_Data' accepts two inputs 'filenames' and 'colNames'( which is kept at a default value of NULL)
The second function Merge_Data accepts two data files with similar column names and merges them together into a single file using cbind.


We then execute our key tasks as follows 
a) read the fatures file and ,merging it with the train file so that the colums of the new train file contains features as the column name
b) merge the features file with the test file so that the new test file has the features as their column name.
c) using rbind, we comnine the two files into a single large file, called 'comnined_data' and re-arrange this using the data ids.
d) we then extract from this comnined dataset, those columns that have the string 'std' ( for standard deviation) and mean. We use the grep command to achieve this.

We name the files in the data set using descriptive names obtained from the 'activity_labels.txt


Using ddply, we evaluate the average of each value ( colName) and keep it in a separate data set called tidy_dataset, and then assigning new names to it - prefacing each new variable with the string 'Mean'.


We save our final results in 3 files
One of them being the codebook ( column names for the new tify dataset)
#