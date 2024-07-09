** Set working directory 

** Read in data from IPUMS 
set more off

clear
quietly infix                 ///
  int     year         1-4    ///
  long    serial       5-9    ///
  byte    month        10-11  ///
  double  hwtfinl      12-21  ///
  double  cpsid        22-35  ///
  byte    asecflag     36-36  ///
  byte    pernum       37-38  ///
  double  wtfinl       39-52  ///
  double  cpsidp       53-66  ///
  byte    age          67-68  ///
  byte    sex          69-69  ///
  int     race         70-72  ///
  byte    marst        73-73  ///
  int     hispan       74-76  ///
  byte    empstat      77-78  ///
  byte    labforce     79-79  ///
  int     occ          80-83  ///
  int     ind          84-87  ///
  int     uhrsworkt    88-90  ///
  int     educ         91-93  ///
  int     uhrsworkorg  94-96  ///
  using `"cps_00048.dat"'

replace hwtfinl     = hwtfinl     / 10000
replace wtfinl      = wtfinl      / 10000

format hwtfinl     %10.4f
format cpsid       %14.0f
format wtfinl      %14.4f
format cpsidp      %14.0f

label var year        `"Survey year"'
label var serial      `"Household serial number"'
label var month       `"Month"'
label var hwtfinl     `"Household weight, Basic Monthly"'
label var cpsid       `"CPSID, household record"'
label var asecflag    `"Flag for ASEC"'
label var pernum      `"Person number in sample unit"'
label var wtfinl      `"Final Basic Weight"'
label var cpsidp      `"CPSID, person record"'
label var age         `"Age"'
label var sex         `"Sex"'
label var race        `"Race"'
label var marst       `"Marital status"'
label var hispan      `"Hispanic origin"'
label var empstat     `"Employment status"'
label var labforce    `"Labor force status"'
label var occ         `"Occupation"'
label var ind         `"Industry"'
label var uhrsworkt   `"Hours usually worked per week at all jobs"'
label var educ        `"Educational attainment recode"'
label var uhrsworkorg `"Usual hours worked per week, outgoing rotation groups"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

label define hispan_lbl 000 `"Not Hispanic"'
label define hispan_lbl 100 `"Mexican"', add
label define hispan_lbl 102 `"Mexican American"', add
label define hispan_lbl 103 `"Mexicano/Mexicana"', add
label define hispan_lbl 104 `"Chicano/Chicana"', add
label define hispan_lbl 108 `"Mexican (Mexicano)"', add
label define hispan_lbl 109 `"Mexicano/Chicano"', add
label define hispan_lbl 200 `"Puerto Rican"', add
label define hispan_lbl 300 `"Cuban"', add
label define hispan_lbl 400 `"Dominican"', add
label define hispan_lbl 500 `"Salvadoran"', add
label define hispan_lbl 600 `"Other Hispanic"', add
label define hispan_lbl 610 `"Central/South American"', add
label define hispan_lbl 611 `"Central American, (excluding Salvadoran)"', add
label define hispan_lbl 612 `"South American"', add
label define hispan_lbl 901 `"Do not know"', add
label define hispan_lbl 902 `"N/A (and no response 1985-87)"', add
label values hispan hispan_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define labforce_lbl 0 `"NIU"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define uhrsworkt_lbl 997 `"Hours vary"'
label define uhrsworkt_lbl 999 `"NIU"', add
label values uhrsworkt uhrsworkt_lbl

label define educ_lbl 000 `"NIU or no schooling"'
label define educ_lbl 001 `"NIU or blank"', add
label define educ_lbl 002 `"None or preschool"', add
label define educ_lbl 010 `"Grades 1, 2, 3, or 4"', add
label define educ_lbl 011 `"Grade 1"', add
label define educ_lbl 012 `"Grade 2"', add
label define educ_lbl 013 `"Grade 3"', add
label define educ_lbl 014 `"Grade 4"', add
label define educ_lbl 020 `"Grades 5 or 6"', add
label define educ_lbl 021 `"Grade 5"', add
label define educ_lbl 022 `"Grade 6"', add
label define educ_lbl 030 `"Grades 7 or 8"', add
label define educ_lbl 031 `"Grade 7"', add
label define educ_lbl 032 `"Grade 8"', add
label define educ_lbl 040 `"Grade 9"', add
label define educ_lbl 050 `"Grade 10"', add
label define educ_lbl 060 `"Grade 11"', add
label define educ_lbl 070 `"Grade 12"', add
label define educ_lbl 071 `"12th grade, no diploma"', add
label define educ_lbl 072 `"12th grade, diploma unclear"', add
label define educ_lbl 073 `"High school diploma or equivalent"', add
label define educ_lbl 080 `"1 year of college"', add
label define educ_lbl 081 `"Some college but no degree"', add
label define educ_lbl 090 `"2 years of college"', add
label define educ_lbl 091 `"Associate's degree, occupational/vocational program"', add
label define educ_lbl 092 `"Associate's degree, academic program"', add
label define educ_lbl 100 `"3 years of college"', add
label define educ_lbl 110 `"4 years of college"', add
label define educ_lbl 111 `"Bachelor's degree"', add
label define educ_lbl 120 `"5+ years of college"', add
label define educ_lbl 121 `"5 years of college"', add
label define educ_lbl 122 `"6+ years of college"', add
label define educ_lbl 123 `"Master's degree"', add
label define educ_lbl 124 `"Professional school degree"', add
label define educ_lbl 125 `"Doctorate degree"', add
label define educ_lbl 999 `"Missing/Unknown"', add
label values educ educ_lbl


** Create demographic variables 
* Female
gen female = (sex == 2)
gen male = (sex == 1)

* Age Groups 
gen age_22_34 = inrange(age, 22, 34)
gen age_35_49 = inrange(age, 35, 49)
gen age_50_64 = inrange(age, 50, 64)
gen age_65_plus = (age >= 65)

* Bachelor's degree
gen ba = (educ >= 111 & educ != 999)
gen noba = (educ < 110 & educ != 999)

* Employed 
gen employed = (inlist(empstat, 10, 12))

* Hours worked
replace uhrsworkt = . if inlist(uhrsworkt, 997, 999)

gen work_35hrs = uhrsworkt >= 35 
gen less_35 = uhrsworkt < 35

* 1,480,164 observations, 1-4 per person depending on what time of year they were sampled
tempfile cps_2018 
save `cps_2018'

** Add crosswalk between 2010 Census occupation codes to SOC codes 
* 1172 observations, maps 6 digit SOC codes to 4 digit census codes
* # of unique SOC codes that map to # of unique census codes; 577 -> 1, 287 -> 2, 7 -> 3
* # of unique Census codes that map to # of unique SOC codes; 505 -> 1, 89 -> 2, 47 -> 3, 23 -> 4, 11 -> 5, 6 -> 6, 2 -> 7, 5 -> 8, 1 -> 9, 1 -> 11, 1 -> 17, 2 -> 37
* 871 unique SOC codes in this crosswalk 
import excel "C:\Users\arome\Dropbox (HMS)\DIEP RRTC Project 1\Data\Essential Teleworkable Frontline\SOC_Census_crosswalk.xlsx", sheet("Sheet1") firstrow clear
replace SOCCode = subinstr(SOCCode, "-", "", .) // 2018 SOC code
replace SOCCode = subinstr(SOCCode, " ", "", .)
destring SOCCode, gen(soc_code)

rename B census_code // 2010/2018 Census code 
destring census_code, gen(occ) 

keep occ soc_code

tempfile census_soc
save `census_soc' /// 1,172 obs mapping of SOC to Census, sometimes multiple SOC per census and vice versa

** Add crosswalk between 6 digit SOC codes to 1-digit ISCO-08
* Includes a variable "dup" which is an indicator for if an soc_code has multiple isco_1dig codes attached to it. # of unique SOC codes that map to # of unique isco codes; 767 -> 1, 65 -> 2, 7 -> 3, 1 -> 4
* 840 unique SOC codes in this crosswalk
* 922 observations
import delimited "\Data\HFCS\raw_data\isco_soc_xwalk_clean.csv", clear 

joinby soc_code using `census_soc' , unmatched(using)

* merge m:m soc_code using `census_soc' 

* keep if _merge == 3 
set seed 082094
gen order = runiform()
gsort order 

collapse (firstnm) soc_code isco_1dig, by(occ)

* Merge with CPS data from above. 1,480,164 observations (739,722 without occupation codes(NIL)), 1-4obs per person. There are 484 unique occupation codes in the CPS data. The crosswalk we are merging to has 603 unique occupation codes
merge 1:m occ using `cps_2018'

* _merge == 1 : 158 obs with occ codes in the crosswalk not in the cps data 
* _merge == 3 : 667,015 obs in cps data that match to the crosswalk

tempfile missing_isco 
save `missing_isco'

* _merge == 2 : 813,149 obs with occ codes in cps data that are not in the soc-isco-occ crosswalk. 739,772 of these observations are occ == 0 (NIL). So 73,377 observations in cps data with occ codes not in crosswalk. These 73,377 have 39 unique occ codes that are missing from the soc-isco-occ crosswalk

* This crosswalk maps 38 of the 39 missing occ codes to 1 digit isco codes. This mapping was done by going from 2010 census occ codes to 6 digit SOC codes to ISCO codes. Some census codes map into multiple SOC codes, but these SOC codes then map to the same 1 digit isco code so it is not a problem. When a census occ code maps to multiple SOC codes that map to multiple 1 digit ISCO codes, an isco code is selected at random. Random selection occurs for 3/38 occupation codes, these decisions are documented in the crosswalk.
import excel "C:\Users\arome\Dropbox (HMS)\Medical Conditions Affecting Work Capacity\Data\CPS\occ_isco_crosswalk_HC.xlsx", sheet("Sheet1") firstrow clear
rename Occ occ 
rename digitISCO onedigit_isco
keep occ onedigit_isco

* Merge 38/39 missing 1 digit isco codes for census occ codes (no isco code for 9840: armed forces) 
merge 1:m occ using `missing_isco', nogen

* Replace missing 1 digit isco codes for 38 census occupations with the mapped in isco codes (73,295 of the 73,377 observations with occupation codes without 1 digit isco codes get populated. The remainder come from occ code 9840 not in either crosswalk)
replace isco_1dig = onedigit_isco if isco_1dig == .

drop if isco_1dig == 0 // armed forces occupations
tab isco_1dig, gen(occ_cat)

** Add crosswalk between 2012 Census industry codes to NAICS supersectors 
/// Crosswalk based on https://www.bls.gov/cps/cenind2012.htm
gen ind_super = . 
replace ind_super = 1 if inrange(ind, 170, 290) | inrange(ind, 370, 490) | ind == 770 | inrange(ind, 1070, 3990)
replace ind_super = 2 if ind_super == . & ind_super != 0
label define supersector_lbl 1 "Goods-Producing" 2 "Service-Producing"
label values ind_super supersector_lbl

tab ind_super, gen(supersector)
rename soc_code SOC_6_Digit
tostring SOC_6_Digit, replace
drop _merge

* Master data has 1,480,318 observations, 813,149 of these are missing soc codes
* Merge in teleworkable, essential, frontline
* The 39 occ codes that we previously mapped in 1 digit isco codes for are still missing SOC codes. That is what essential and teleworkable are based on, so essential and teleworkable will not merge in for those codes
merge m:1 SOC_6_Digit using "\Data\HFCS\clean_data\status_by_SOC.dta"

save "CPS\cps_2018.dta", replace 
* Keep population to match HFCS (22+ & employed)
keep if age >= 22
keep if employed == 1

save "CPS\cps_2018_22+_working.dta", replace 

collapse (mean) female male age_22_34 age_35_49 age_50_64 age_65_plus ba noba work_35hrs less_35 occ_cat1 occ_cat2 occ_cat3 occ_cat4 occ_cat5 occ_cat6 occ_cat7 occ_cat8 occ_cat9 supersector1 supersector2 Teleworkable essential  [aw=wtfinl]

save "CPS\cps_2018_22+_working_demo_collapse.dta", replace 


