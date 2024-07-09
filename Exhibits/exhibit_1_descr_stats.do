* Exhibit 1 - Decsriptive Statistics for the HFCS analysis sample
* Author: Alexandra Rome
* Purpose: 
* 	Find unweighted and weighted statitcis of the HFCS sample, as well as the weighted statistics of the 2018 CPS popualtion for comparison and output table

*==================================================================================================

* Set to your computer's working directory

* Exhibit 1: Table 1: Sample Summary Statistics

******* Unweighted Descriptive Statitics *********

* Load HFCS data with teleowrkable/essential identifiers to merge to HFCS data
use "Data\HFCS\clean_data\hfcs_recodes.dta" , clear

destring isco_1dig, replace

* Collapse to a single row per individual with teleworkable and essential identifiers and merge to wide HFCS data 
collapse (max) essential Teleworkable isco_1dig , by(prim_key)
merge 1:1 prim_key using "Data\HFCS\clean_data\HFCS_CLEAN.dta"

* Keep if working and passed screener 
keep if working == 1
keep if pass_screener == 1

* Create male identifier
gen male = (female == 0)

* Create age groups 
gen age_22_34 = (AGE<35)
gen age_35_49 = (AGE>=35 & AGE<50)
gen age_50_64 = (AGE>=50 & AGE<65)
gen age_65_plus = (AGE>=65)

* Create identifier for no college
gen no_college = (college == 0)

* Create Work variables
gen full_time = (Q83>=35)
gen part_time = (Q83<35)

* Create non-essential and non-teleworkable 
gen non_essential = (essential == 0)
gen non_tele = (Teleworkable == 0)

* Create Health Outcome variables
gen one_med_cond = (num_health_problems >= 1)
gen one_func_limit = (num_impair_total >= 1)

* Add super-sector information to lim_clpsed_screener, 1: goods-producing, 2: service-producing
gen goods =  (Q81<= 5 & Q81 != 3)
gen service = (Q81 > 5 | Q81 == 3)

tab isco_1dig, gen(isco_1dig)

rename isco_1dig2 managers
rename isco_1dig3 professionals
rename isco_1dig4 technicians
rename isco_1dig5 clerical
rename isco_1dig6 service_sales
rename isco_1dig8 craft
rename isco_1dig9 plant
rename isco_1dig10 elementary

* Unweighted Means 
collapse (mean) male female age_22_34 age_35_49 age_50_64 age_65_plus college no_college full_time managers professionals technicians clerical service_sales craft plant elementary goods service essential non_essential Teleworkable non_tele part_time one_med_cond one_func_limit num_impair_total

* Transpose from wide to long with variable names in rows
xpose , clear varname
rename v1 unweighted

tempfile unwtd
save `unwtd'

******* Weighted Descriptive Statitics *********

* Load HFCS data with teleowrkable/essential identifiers to merge to HFCS data
use "Data\HFCS\clean_data\hfcs_recodes.dta" , clear

destring isco_1dig, replace

* Collapse to a single row per individual with teleworkable and essential identifiers and merge to wide HFCS data 
collapse (max) essential Teleworkable isco_1dig, by(prim_key)
merge 1:1 prim_key using "Data\HFCS\clean_data\HFCS_CLEAN.dta"

* Keep if working and passed screener 
keep if working == 1
keep if pass_screener == 1

* Create male variable 
gen male = (female == 0)

* Create age groups 
gen age_22_34 = (AGE<35)
gen age_35_49 = (AGE>=35 & AGE<50)
gen age_50_64 = (AGE>=50 & AGE<65)
gen age_65_plus = (AGE>=65)

* Create no college
gen no_college = (college == 0)

* Create Work variables
gen full_time = (Q83>=35)
gen part_time = (Q83<35)

* Create non-essential and non-teleworkable 
gen non_essential = (essential == 0)
gen non_tele = (Teleworkable == 0)

* Create Health Outcome variables
gen one_med_cond = (num_health_problems >= 1)
gen one_func_limit = (num_impair_total >= 1)

* Add super-sector information to lim_clpsed_screener, 1: goods-producing, 2: service-producing
gen goods =  (Q81<= 5 & Q81 != 3)
gen service = (Q81 > 5 | Q81 == 3)

tab isco_1dig, gen(isco_1dig)

rename isco_1dig2 managers
rename isco_1dig3 professionals
rename isco_1dig4 technicians
rename isco_1dig5 clerical
rename isco_1dig6 service_sales
rename isco_1dig8 craft
rename isco_1dig9 plant
rename isco_1dig10 elementary

* Weighted Means 
collapse (mean) male female age_22_34 age_35_49 age_50_64 age_65_plus college no_college full_time managers professionals technicians clerical service_sales craft plant elementary goods service essential non_essential Teleworkable non_tele part_time one_med_cond one_func_limit num_impair_total [aw=weight]

xpose , clear varname
rename v1 weighted

merge 1:1 _varname using `unwtd'
drop _merge

tempfile table1 
save `table1'

******* 2018 CPS Working Population *********

use "Data\CPS\cps_2018_22+_working_demo_collapse.dta" , clear
rename ba college
rename noba no_college
rename work_35hrs full_time
rename less_35 part_time 
rename occ_cat1 managers
rename occ_cat2 professionals
rename occ_cat3 technicians
rename occ_cat4 clerical
rename occ_cat5 service_sales
rename occ_cat7 craft
rename occ_cat8 plant
rename occ_cat9 elementary
rename supersector1 goods 
rename supersector2 service

xpose , clear varname
rename v1 cps

* Merge CPS population stats to unweighted and weighted stats 
merge 1:1 _varname using `table1'
drop if _merge == 1
drop _merge

order _varname unweighted weighted cps

* Create ordering of statistics
gen varname_num = .
replace varname_num = 1 if _varname == "male"
replace varname_num = 2 if _varname == "female"
replace varname_num = 3 if _varname == "age_22_34"
replace varname_num = 4 if _varname == "age_35_49"
replace varname_num = 5 if _varname == "age_50_64"
replace varname_num = 6 if _varname == "age_65_plus"
replace varname_num = 7 if _varname == "college"
replace varname_num = 8 if _varname == "no_college"
replace varname_num = 9 if _varname == "full_time"
replace varname_num = 10 if _varname == "part_time"
replace varname_num = 11 if _varname == "managers"
replace varname_num = 12 if _varname == "professionals"
replace varname_num = 13 if _varname == "technicians"
replace varname_num = 14 if _varname == "clerical"
replace varname_num = 15 if _varname == "service_sales"
replace varname_num = 16 if _varname == "craft"
replace varname_num = 17 if _varname == "plant"
replace varname_num = 18 if _varname == "elementary"
replace varname_num = 19 if _varname == "goods"
replace varname_num = 20 if _varname == "service"
replace varname_num = 21 if _varname == "essential"
replace varname_num = 22 if _varname == "non_essential"
replace varname_num = 23 if _varname == "Teleworkable"
replace varname_num = 24 if _varname == "non_tele"
replace varname_num = 25 if _varname == "one_med_cond"
replace varname_num = 26 if _varname == "one_func_limit"
replace varname_num = 27 if _varname == "num_impair_total"

* Label variuable ordering 
label define var_titles 1 "Male" 2 "Female" 3 "22-34" 4 "35-49" 5 "50-64" 6 "65+" 7 "BA" 8 "No BA" 9 "Full time" 10 "Part time" 11 "Managers" 12 "Professionals" 13 "Technicians and associate professionals" 14 "Clerical support workers" 15 "Services and sales workers" 16 "Craft and related trade workers" 17 "Plant and machine operators and assemblers" 18 "Elementary occupations" 19 "Goods-producing" 20 "Service-producing" 21 "Essential" 22 "Non-essential" 23 "Teleworkable" 24 "Non-teleworkable"  25 "At least one medical condition" 26 "At least one functional limitation" 27 "Number of functional limitations"
label values varname_num var_titles


** Output to .csv file **
estpost tabstat unweighted weighted cps, by(varname_num)
esttab using "Exhibit 1\summary statistics.csv", replace ///
	refcat(1 "Sex" 3 "Age" 7 "Education" 9 "Hours of Work" 11 "Occupation" 19 "Industry" 21 "Work" 25 "Health Outcomes", nolabel) ///
	cells("unweighted(fmt(%9.3f)) weighted(fmt(%9.3f)) cps(fmt(%9.3f))") ///
	compress nonumber nomtitle nonote noobs ///
	varlabels(`e(labels)') ///
	collabels("Mean (unweighted)" "Mean (weighted)" "2018 CPS Working Population") ///
	drop(Total) varwidth(45)
	

