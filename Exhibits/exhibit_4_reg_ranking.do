* Exhibit 4 - Regression Results
* Author: Alexandra Rome
* Purpose: 
* 	Find the top ten highest impact medical conditions, ranked by population impact 
* 	Find:
*	1. Increase in number of functional limitations by medical condition
*	2. Find the prevalence of each medical condition
*	3. Multiply (1) * (2) x 100 to get the top 10 highest impact medical conditions
* Export table to excel
*==================================================================================================

cd "C:\Users\arome\Dropbox (HMS)\Medical Conditions Affecting Work Capacity"

use "Data\HFCS\clean_data\interim\medcond_g.dta" , clear

drop if missing(med_group)

keep if pass_screener == 1
keep if emp_stat == 1

gen age22_34 = (age_grp3 == 1)
gen age35_49 = (age_grp3 == 2)
gen age50_64 = (age_grp3 == 3)
gen age65 = (age_grp3 == 4)

replace med_group = substr(med_group, 1, 27)

reshape wide value, i(prim_key) j(med_group) string

foreach v of varlist value* {
  local new = substr("`v'", 6, .) 
  rename `v' `new'
}

svyset [pw=weight], singleunit(certainty) 

* Save data for bootstrap 
save "Data\HFCS\clean_data\interim\medcond_g_reg.dta" , replace

global med_groups Abnormal_heart_rhythm Arthritis_and_other_joint_d Asthma_or_COPD Atherosclerotic_vascular_di Back_pain Blindness Blood_disorder Cancer Chronic_pain Connective_tissue_disorders Deafness Dementia Developmental_disorder Diabetes_and_obesity Fibromyalgia_and_neuropathi HIV_and_other_infectious_di Inflammatory_bowel_disease_ Kidney_or_Bladder_Disease MSK_injuries_and_limb_defor Mental_Illness Migraine Neck_pain Other Other_Lung_Disease Other_Neurologic_Disorder Other_heart_or_circulatory_ Rheumatologic_Disease SUD_and_related_complicatio Spinal_cord_injury Structural_Heart_Disease 

svy: reg num_limit $med_groups age35_49 age50_64 age65 female
putexcel set "Papers\Burdens of Functional Limitations\Exhibit 4\med_condition_coefficients.xlsx", replace

putexcel A1 = "condition" 
putexcel B1 = "coeff"
putexcel C1 = "coeff_se"
putexcel D1 = "coeff_p"
putexcel E1 = "prevalence" 
putexcel F1 = "prevalence_se"
putexcel G1 = "increase"

local groups Abnormal_heart_rhythm Arthritis_and_other_joint_d Asthma_or_COPD Atherosclerotic_vascular_di Back_pain Blindness Blood_disorder Cancer Chronic_pain Connective_tissue_disorders Deafness Dementia Developmental_disorder Diabetes_and_obesity Fibromyalgia_and_neuropathi HIV_and_other_infectious_di Inflammatory_bowel_disease_ Kidney_or_Bladder_Disease MSK_injuries_and_limb_defor Mental_Illness Migraine Neck_pain Other Other_Lung_Disease Other_Neurologic_Disorder Other_heart_or_circulatory_ Rheumatologic_Disease SUD_and_related_complicatio Spinal_cord_injury Structural_Heart_Disease

forvalues i = 1/30 {
   local var : word `i' of `groups'
   local pvalue = 2*ttail(`e(df_r)', abs(_b[`var']/_se[`var']))
   putexcel A`=`i'+1' = "`var'"
   putexcel B`=`i'+1' = _b[`var']
   putexcel C`=`i'+1' = _se[`var']
   putexcel D`=`i'+1' = `pvalue'
   
   quietly summarize `var' [aw=weight]
   putexcel E`=`i'+1' = (r(mean)) 
   putexcel F`=`i'+1' = ((r(sd))/sqrt(r(N))) 
   putexcel G`=`i'+1' = ((_b[`var'])*(r(mean))*100)  
}

putexcel close



*************** Bootstrap SE for Beta X Prevalence X 100 *****************

* Reset working directory 
cd "C:\Users\arome\Dropbox (HMS)\Medical Conditions Affecting Work Capacity\Data\HFCS\clean_data\interim"

* Create a postfile called boot_results with 2 variables; condition (which is the nam eof the condition the regression coefficients come from and a string) and increase (which is the statistic of interest (Beta X Prevalence X 100))
postfile boot_results str27 condition increase using boot_results , replace

* Create local of the 31 conditions we need to calculate increase for
local med_groups Abnormal_heart_rhythm Arthritis_and_other_joint_d Asthma_or_COPD Atherosclerotic_vascular_di Back_pain Blindness Blood_disorder Cancer Chronic_pain Connective_tissue_disorders Deafness Dementia Developmental_disorder Diabetes_and_obesity Fibromyalgia_and_neuropathi HIV_and_other_infectious_di Inflammatory_bowel_disease_ Kidney_or_Bladder_Disease MSK_injuries_and_limb_defor Mental_Illness Migraine Neck_pain Other Other_Lung_Disease Other_Neurologic_Disorder Other_heart_or_circulatory_ Rheumatologic_Disease SUD_and_related_complicatio Spinal_cord_injury Structural_Heart_Disease 

*Set random number seed
set seed 082094


forvalues b = 1/2000 {
	* Preserve data to restore to at the end of each loop and resample from
	preserve 
	
	* Sample with replacement form dataset
	bsample
	
	* Run analysis
	svy: reg num_limit $med_groups age35_49 age50_64 age65 female	
	
	* add variable name and increase in functional limitations to the postfile for 31 conditions
	foreach var of local med_groups{
		qui sum `var' [aw=weight]
		post boot_results ("`var'") ((_b[`var'])*(r(mean))*100)
	}
	restore
}

postclose boot_results

use boot_results , clear

*There are zero results in here... I think they should be dropped because they were omitted from the regression after resampling 
drop if increase == 0
collapse (sd)  boot_se = increase , by(condition)

tempfile boot_se
save `boot_se'

cd "C:\Users\arome\Dropbox (HMS)\Medical Conditions Affecting Work Capacity"
import excel "Papers\Burdens of Functional Limitations\Exhibit 4\med_condition_coefficients.xlsx", cellrange(A1:G31) firstrow clear

merge 1:1 condition using `boot_se'
drop _merge
gen boot_z = increase/boot_se
gen boot_p = 2*(normal(-abs(boot_z)))

****************** Prepare table for output **********************
gsort -increase 
gen rank = _n
keep if rank < 11


gen coeff_rnd = string(round(coeff, 0.01), "%9.2f") 
replace coeff_rnd = coeff_rnd + "*" if coeff_p < 0.10 & coeff_p >= 0.05
replace coeff_rnd = coeff_rnd + "**" if coeff_p < 0.05 & coeff_p >= 0.01
replace coeff_rnd = coeff_rnd + "***" if coeff_p < 0.01

gen increase_rnd = string(round(increase, 0.01), "%9.2f") 

replace increase_rnd = increase_rnd + "*" if boot_p < 0.10 & boot_p >= 0.05
replace increase_rnd = increase_rnd + "**" if boot_p < 0.05 & boot_p >= 0.01
replace increase_rnd = increase_rnd + "***" if boot_p < 0.01

gen prevalence_rnd = string(round(prevalence, 0.001), "%9.3f") 

gen coeff_se_rnd = string(round(coeff_se, 0.01), "%9.2f")
replace coeff_se_rnd = "(" + coeff_se_rnd + ")" 

gen prevalence_se_rnd = string(round(prevalence_se, 0.001), "%9.3f") 
replace prevalence_se_rnd = "(" + prevalence_se_rnd + ")"

gen boot_se_rnd = string(round(boot_se, 0.01), "%9.2f")
replace boot_se_rnd = "(" + boot_se_rnd + ")" 

keep condition coeff_rnd coeff_se_rnd prevalence_rnd prevalence_se_rnd increase_rnd boot_se_rnd rank

rename coeff_rnd coeff1
rename coeff_se_rnd coeff2
rename prevalence_rnd prevalence1
rename prevalence_se_rnd prevalence2
rename increase_rnd increase1
rename boot_se_rnd increase2

reshape long coeff prevalence increase , i(condition) j(se_ind)
sort rank se_ind

replace condition = "" if se_ind == 2

drop se_ind rank

* Fix condition formatting
replace condition = subinstr(condition, "_", " ", .)
* Fill in missing words
replace condition = "Arthritis and other joint disease" if condition == "Arthritis and other joint d"
replace condition = "Substance use disorder (SUD) and related complications" if condition == "SUD and related complicatio"
replace condition = "Asthma or chronic obstructive pulmonary disease (COPD)" if condition == "Asthma or COPD"
replace condition = "Fibromyalgia and neuropathic pain and fatigue" if condition == "Fibromyalgia and neuropathi"

label variable condition "Medical Condition"
label variable coeff "Increase in Number of Functional Limitations"
label variable prevalence "Prevalence of Medical Condition"
label variable increase "Increase in Number of Functional Limitations X Prevalence of Medical Condition X 100"

* After exporting to Excel, some additional formatting is doenw ithin excel and word to adjust the text etc.
export excel using "Papers\Burdens of Functional Limitations\Exhibit 4\exhibit_4", replace firstrow(varlabels)
