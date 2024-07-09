# The-Prevalence-of-Functional-Limitations-in-the-United-States-Workforce

In order to reproduce clean data and results run main.do
The following describes the do files within each folder 


## Data Preparation for analysis
#### data_prep.do
##### inputs:
variables_full_fml.xlsx : Crosswalks FML items and HFCS questions, labeled with degree of limitation \
imputation_missing_ess_tel_fro.xlsx : These are SOC codes that we imputed teleworkable/essential status from related occuaptions \
status_by_SOC.dta : teleworkable/essential status by SOC code from (Dingle Neiman/ ****) \
hfcs_clean_recodes_full_fml.dta : \
variables_full_fml.xlsx : HFCS questions, labels, and groupings \
ISCO_SOC_Crosswalk.xls : crosswalks SOC codes to 1 digit isco codes with an indicator for when SOC codes have multiple 1 digit ISCO codes 
##### outputs:
hfcs_recodes.dta : HFCS data with essential/teleworkable status, 1 digit ISCO codes, limitation degrees scaled from 0-3, and variables of interest for occupation, industry, etc. \
hfcs_recodes_clpsd.dta : collapsed version of hfcs_recodes by person identitfier

#### medical_conditions.do 
##### inputs :
HFCS Collapsed Medical Condition Categories_06152020.xlsx \ 
variables.xlsx \
HFCS_CLEAN.dta \
lim_clpsd.dta 
##### ouputs:
medcond_g.dta

## Create Crosswalks
#### cps_occ_tele_ess_xwalk.do 
##### inputs:
SOC_Census_crosswalk.xlsx \
status_by_SOC.dta 
##### oupts:
occupation_ess_tele_xwalk.dta

#### cps_2018_population.do 
##### inputs:
cps_00048.dat \
SOC_Census_crosswalk.xlsx \
isco_soc_xwalk_clean.csv \
occ_isco_crosswalk_HC.xlsx \
occupation_ess_tele_xwalk.dta 
##### outputs:
cps_2018_22+_working_demo_collapse.dta

## Run Analysis and produce exhibits
#### exhibit_1_descr_stats.do 
##### inputs:
hfcs_recodes.dta \
HFCS_CLEAN.dta \
cps_2018_22+_working_demo_collapse.dta 
##### output:
descriptive_stats_hfcs.csv

#### exhibit_2_prevalence.do 
##### inputs:
hfcs_recodes.dta
##### ouput: 
hfcs_recodes_collapse.dta \
prevalence_by_group.png

#### exhibit_3_mean_limitations.do 
##### inputs:
hfcs_recodes.dta \
HFCS_CLEAN.dta
##### ouput:
mean_limitations.dta \
mean_limitations_by_group.png

#### exhbit_4_reg_ranking.do 
##### inputs:
medcond_g.dta
##### outputs:
medcond_g_reg.dta \
med_condition_coefficients.xlsx \
boot_results.dta \
exhibit_4.xlsx

#### exhibit_s1_prevalence.do 
