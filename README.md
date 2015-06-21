# tidyData

The first step is to load the required data from the text files. 
First, the keys for activities and different measurement types are 
loaded.  Next, The desired measurement types are found by searching 
for mean or std.  

With thse preliminary vectors loaded, we proceed to load the testX
and testY data along witht he corresponding subject list.  The next
step is to pull only the mean/std values from testX.  We then name 
the activities identified in testY according the the activityLabels 
key.  Everything is then labeled with the proper names and then bound
together in a single dataframe.

Following performing the same ayalysis on the training data, the test
and train sets are stacked atop each other in a single dataframe (data).
data is then melted into id and variable components and a tidy dataframe
is created showing the mean of each variable according to subject and
activity label.
