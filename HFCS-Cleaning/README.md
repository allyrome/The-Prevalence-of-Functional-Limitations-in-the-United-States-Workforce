
These files take the raw data from RAND American Life Panel (ALP) Well Being 522 - Health & Functional Capacity Survey and process and clean them to create hfcs_clean_recodes_full_fml.dta

Files run in this order 

process.do : merges in end-of-survey comments, destrings variables to convert to numeric, creates useful variables for later use 

labeling.do : add variable and value labels, input: output: HFCS_CLEAN.dta

export_varaibles.do : Exports variables and variable labels into Excel file. input: HFCS_CLEAN.dta output: variables.xlsx

add_conditions_text.do : Update standardized medical conditions (Q1 variables) with free text information (Must have already run freetext_conditions_clean.R to produce test.csv) i9nput: HFCS_CLEAN.dta & test.csv output: HFCS_CLEAN.dta

merge.do : Merges hand-coded variables input: FINAL_OCCUPATIONS.csv, occupation_todo.csv

recodes_full_fml.do : collapse all impairments into binary and put into same direction, creates clean data: hfcs_clean_recodes_full_fml.dta
