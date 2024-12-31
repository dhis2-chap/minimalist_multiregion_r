# Minimalist example of model integration with multiple regions in R
This document will explain how to expand the "minimalist_example_r" model to handle mutliple regions.
We will still use the same simple linear regression model, and assume that the regions are indepedent to keep the example simple.
So the model will handle data with multiple regions, but will essentially model each region on its own with no influence from other regions.

## Running the model without CHAP integration
The example can be run in isolation (e.g. from the command line) using the file isolated_run.py:
```
python isolated_run.py  
```

For details on code files and data, please consult the "minimalist_example_r" model. The only differences are that:
* The training data file ("traindata.csv") here contains lines with multiple values (loc1 and loc2) in the location column:
```csv
time_period,rainfall,mean_temperature,disease_cases,location
2023-05,10,30,200,loc1
2023-06,2,30,100,loc1
2023-05,2,30,1000,loc2
2023-06,10,20,2000,loc2
```
* The train function in "train.R" uses a utility function "get_df_per_location" to split the dataframe, before iterating over the different locations:
```
dataframe_list <- get_df_per_location(csv_fn)
for (location in names(dataframe_list)){
    ...
}
```
* The predict function in "predict.R" also iterates over the locations. Saving the final dataframe as a csv is also slighlty more complicated. The first location initializes the dataframe and the follwing are rowbinded on as below:
```
if (first_location){
    full_df <- df
    first_location <- FALSE
}
else {
    full_df <- rbind(full_df, df)
}
``` 
