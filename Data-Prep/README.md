
These two files take the cleaned HFCS data and add additional information needed for analysis

data_prep.do : Add additional information needed for analysis to the HFCS survey repsonse data \
inputs: \
variables_full_fml.xlsx : Crosswalk between FML questions and HFCS questions with degree of limitation \
imputation_missing_ess_tel_fro.xlsx  : Codes that did not originally have a teleworkable/essential identifier. Values were imputed from the average of related occuaption codes \
status_by_SOC.dta : Essential and teleworkable identifiers from Dingel and Neiman and CISA \
hfcs_clean_recodes_full_fml.dta : HFCS/FML data \
ISCO_SOC_Crosswalk.xls : ISCO_SOC_Crosswalk 

Outputs: \
hfcs_recodes.dta \
hfcs_recodes_clpsd.dta \

medical_conditions.do : Add medical condition labels and groupings to HFCS data, save as medcond_g.dta \
inputs: 
HFCS Collapsed Medical Condition Categories_04302024.xlsx: * Medical conditions grouped by category, groupings were created by the authors. This excel sheet is formatted with the name of the Category listed only once in "Category", with multiple rows of conditions listed in "Conditions" that belong to that category which in turn correspond to empty values of Category \
HFCS_CLEAN.dta \
hfcs_recodes_clpsd.dta \
output: medcond_g.dta
