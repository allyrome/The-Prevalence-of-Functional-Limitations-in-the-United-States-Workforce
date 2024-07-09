These files run the analysis and produce the 6 exhibits 

## exhibit_1_descr_stats.do 
Produces Table 1, inputs: hfcs_recodes.dta HFCS_CLEAN.dta outputs: summary statistics.csv

## exhibit_2_prevalence.do 
Produces Figure 1, inputs: hfcs_recodes.dta hfcs_recodes_collapse.dta output: prevalence_by_group.png

## exhibit_3_mean_limitations.do 
Produces Figure 2, inputs: hfcs_recodes.dta HFCS_CLEAN.dta output: mean_limitations_by_group.png

## exhibit_4_reg_ranking.do 
Produces Table 2, inputs: medcond_g.dta interim: medcond_g_reg.dta, med_condition_coefficients.xlsx, boot_results output: exhibit_4.xlsx

## exhibit_s1_prevalence.do 
Produces Table S1 inputs: hfcs_recodes.dta, variables_full_fml.xlsx interim: hfcs_recodes_collapse_s1.dta output: common_func_limitations.xlsx

## exhibit_s2_full_regression_table.do 
Produces Table S2 inputs: boot_results.dta med_condition_coefficients.xlsx output: exhibit_s2.xlsx
