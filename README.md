# Getting-and-Cleaning-Data-Course-Project
The `script_analysis.R` does the following:

1. Download the dataset
2. Load files
3. Testing and keeping only those columns which contains a mean or std and loads the activity / subject data for each dataset, and merges those columns with the dataset.
4. Converts the activity / subject columns into factors
5. Create `tidydata.txt` file that contains the average per variable per subject / activity pair.
