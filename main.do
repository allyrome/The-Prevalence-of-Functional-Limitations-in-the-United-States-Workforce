* The Prevalence of Functional Limitations in the United States Workforce 
* Author: Alexandra Rome
* Purpose: Creates 6 exhibits used in analysis 

*==================================================================================================

* Set to your computer's working directory

* Clean HFCS Data
do "Code/hfcs_cleaning/process.do"
do "Code/hfcs_cleaning/labeling.do"
do "Code/hfcs_cleaning/export_variables.do" 
do "Code/hfcs_cleaning/add_conditions_text.do" 
do "Code/hfcs_cleaning/merge.do"
do "Code/hfcs_cleaning/recodes_full_fml.do"

* Create Crosswalks 
do "Code/occ10_isco08_crosswalk.do"
do "Code/occ10_soc18_crosswalk.do"

* Clean CPS Data 
do "Code/cps_2018_population.do"

* Data prep for analysis and figures
do "Code/data_prep.do" 
do "Code/medical_conditions.do"

* Run analysis/produce images tables
do "Code/exhibit_1_descr_stats.do"
do "Code/exhibit_2_prevalence.do"
do "Code/exhibit_3_mean_limitations.do"
do "Code/exhibit_4_reg_ranking.do"
do "Code/exhibit_s1_prevalence.do"
do "Code/exhibit_s2_full_regression_table.do"
