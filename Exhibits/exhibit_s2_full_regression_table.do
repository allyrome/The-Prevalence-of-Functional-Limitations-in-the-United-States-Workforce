* Exhibit S2 - Full Regression Table
* Author: Alexandra Rome
* Purpose: 
* 	Create table of full regression results for appendix - rather than just top 10 as in Table 2

*==================================================================================================

* Set to your computer's working directory

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
replace condition = "Musculoskeletal (MSK) injuries and limb deformities and burns" if condition == "MSK injuries and limb defor"
replace condition = "Inflammatory bowel disease and other gastrointestinal (GI) disorders" if condition == "Inflammatory bowel disease "
replace condition = "Atherosclerotic vascular disease" if condition == "Atherosclerotic vascular di"
replace condition = "HIV and other infectious diseases" if condition == "HIV and other infectious di"
replace condition = "Other heart or circulatory disorder" if condition == "Other heart or circulatory "

label variable condition "Medical Condition"
label variable coeff "Increase in Number of Functional Limitations"
label variable prevalence "Prevalence of Medical Condition"
label variable increase "Increase in Number of Functional Limitations X Prevalence of Medical Condition X 100"

* After exporting to Excel, some additional formatting is doenw ithin excel and word to adjust the text etc.
export excel using "Papers\Burdens of Functional Limitations\Appendix\exhibit_s2", replace firstrow(varlabels)
