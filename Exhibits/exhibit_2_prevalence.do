* Exhibit 2- Prevalence of any limitation in functional domain
* Author: Alexandra Rome
* Purpose: 
* 	Find prevalence of any limitation within the 16 functional domains and plot

*==================================================================================================

* Set to your computer's wokring directory

* Load HFCS data 
use "Data\HFCS\clean_data\hfcs_recodes.dta" , clear

* Keep if working and passed screener
keep if working == 1
keep if pass_screener == 1

* If no limitation data then treat as no limitation (i.e. 0) 
replace value = 0 if missing(value)

* Convert value to binary;
*	= 0 for Normal/Somewhat Limited 
*	= 1 for Slightly Limited/Limited
replace value = cond(value >= 2, 1, 0)

* Drop observations for hand preference, it is not a limitation and therefore does not belong to a functional domain 
drop if missing(Functional_Group)

* Take the maximum value within each functional group to create an indicator for if there is any limitation in that group
collapse (max) value , by(prim_key Functional_Group weight)

* Survey Set the data
svyset prim_key [pw=weight], strata(Functional_Group)

* Save collapsed data in an iterim folder to call at the top of a loop
save "Data\HFCS\clean_data\interim\hfcs_recodes_collapse.dta" , replace

* Create local of indicators for each functional group
levelsof Functional_Group, local(groups)

* Create empty dataset with 1 variable "Functional_Group" to save as a tempfile and append to each loop
clear
gen Functional_Group = ""
tempfile results
save `results' , replace

* Find prevalence of limitations in each functional group with confidence intervals 

foreach g of local groups {
	
	use "Data\HFCS\clean_data\interim\hfcs_recodes_collapse.dta" , clear
	
	keep if Functional_Group == "`g'"
	
	svy, subpop(if value<.): mean value
	matrix b = r(table)
	gen prevalence = b[1,1]
	gen lower = b[5,1]
	gen upper = b[6,1]
	
	collapse (first) prevalence upper lower , by(Functional_Group)
	
	append using `results'
	
	save `results' , replace

}

egen numvar = group(Functional_Group), label
drop if Functional_Group == "Body Function, Not Elsewhere Classified"

sort prevalence
gen var_order = _n

set scheme cleanplots

graph twoway (bar prevalence var, horizontal barwidth(0.7) color(navy)) (rcap lower upper var, horizontal color(maroon)), ylabel(1 "Verbal and Written Communication" 2 "Sensory" 3 "Pace" 4 "Standing" 5 "Memory, Attention and Cognition" 6 "Hand and Finger Movements" 7 "Arm Movements" 8 "Social Skills and Emotional Regualtion" 9 "Head and Neck Movements" 10 "Mobility" 11 "Sitting" 12 "Immune System" 13 "Knee Movements" 14 "Ambient Environment" 15 "Upper Body Strength and Torso Range of Motion" , angle(0) labsize(small)) xlabel(0 "0%" 0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%") ytitle("") leg(off) 

graph export "Exhibit 2\prevalence_by_group.png" , replace
