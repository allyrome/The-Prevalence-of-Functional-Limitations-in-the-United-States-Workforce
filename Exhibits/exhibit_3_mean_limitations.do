* Exhibit 3 - Mean number of limitations by Group
* Author: Alexandra Rome
* Purpose: 
* 	Find the mean number of limitations by group and produce image
*==================================================================================================

* Set to your computer's working directory

* Call in EssentialTeleworkable to merge to HFCS data
use "Data\HFCS\clean_data\hfcs_recodes.dta" , clear

destring isco_1dig , replace

collapse (max) essential Teleworkable isco_1dig, by(prim_key)
merge 1:1 prim_key using "Data/HFCS/clean_data/HFCS_CLEAN.dta"

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

* Create non-essential and non-teleworkable 
gen non_essential = (essential == 0)
gen non_tele = (Teleworkable == 0)

* Add super-sector information 
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


postfile mean_limitations str27 group mean_limit cilb ciub using mean_limitations , replace

foreach var of varlist male female age_22_34 age_35_49 age_50_64 age_65_plus college no_college service goods managers professionals technicians clerical service_sales craft plant elementary essential non_essential Teleworkable non_tele {
 
 preserve
 
  keep if `var' == 1
  ci mean num_impair_total [aw=weight]
  post mean_limitations ("`var'") (r(mean)) (r(lb)) (r(ub))
  
  restore
  
}

postclose mean_limitations
use mean_limitations , clear

gen group_num = _n
gen groups_sum = ""
replace groups_sum = "Sex" if inlist(group_num, 1, 2)
replace groups_sum = "Age" if inrange(group_num, 3 , 6 )
replace groups_sum = "Education" if inrange(group_num, 7 , 8 )
replace groups_sum = "Industry" if inrange(group_num, 9 , 10 )
replace groups_sum = "Occupation" if inrange(group_num, 11, 18)
replace groups_sum = "unnamed" if inrange(group_num, 19, 22)

* Create breaks between groups

replace group_num = group_num + 1 if group_num > 2
replace group_num = group_num + 1 if group_num > 7
replace group_num = group_num + 1 if group_num > 10
replace group_num = group_num + 1 if group_num > 13
replace group_num = group_num + 1 if group_num > 22
replace group_num = group_num + 1 if group_num > 25


* set scheme cleanplots

graph twoway (scatter group_num mean_limit , mcolor(navy) msymbol(circle) msize(small)) (rcap cilb ciub group_num, mcolor(navy) lcolor(navy) horizontal), ///
title() ///
xtitle("Mean Number of Limitations", size(vsmall)) ///
xlabel(1(1)15, labsize(vsmall) grid) ///
xscale(titlegap(10pt)) ///
ytitle("", height(240pt)) ///
ylabel(1 "Male" 2 "Female" 4 "Ages 22-34" 5 "Ages 35-49" 6 "Ages 50-64" 7 "Ages 65+" 9 "BA" 10 "No BA" 12 "Service-Producing Industry" 13 "Goods-Producing Industry" 15 "Managers" 16 "Professionals" 17 "Technicians and Associate Professionals" 18 "Clerical Support Workers" 19 "Services and Sales Workers" 20 "Craft and Related Trades Workers" 21 "Plant and Machine Operators and Assemblers" 22 "Elementary Occupations" 24 "Essential Occupation" 25 "Non-Essential Occupation" 27 "Teleworkable Occupation" 28"Non-Teleworkable Occupation", angle(0) labsize(vsmall) noticks grid ) ///
yline(3 8 11 14 23 26, lcolor(gs9)) ///
yscale(reverse range(1 28) titlegap(15pt) outergap(-5)) ///
xsize(11) ///
ysize(10) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
legend(off)

graph export "Exhibit 3\mean_limitations_by_group.png" , replace



