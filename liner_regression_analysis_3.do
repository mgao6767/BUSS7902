/*******************************************************************************
  ____  _   _ ____ ____ _____ ___   ___ ____  
 | __ )| | | / ___/ ___|___  / _ \ / _ \___ \ 
 |  _ \| | | \___ \___ \  / / (_) | | | |__) |
 | |_) | |_| |___) |__) |/ / \__, | |_| / __/ 
 |____/ \___/|____/____//_/    /_/ \___/_____|
 
 Welcome to BUSS7902 Quantitative Business Research Methods
 
 This material is prepared by Dr. Mingze Gao (mingze.gao@sydney.edu.au).
 Course coordinator:
 - Dr. Claire Liu (claire.liu@sydney.edu.au) 2023 Semester 1
 - Dr. Boris Choy (boris.choy@sydney.edu.au) 2023 Semester 2

 ******************************************************************************/   
 

/* Hint:
   You can execute this file by either of the following:
	1) Click on the "Execute (do)" button
	2) "Ctrl+D" on Windows or "CMD+SHIFT+D" on Mac
 */
 
 
/*******************************************************************************
 Interactions in regression model
 ******************************************************************************/

 
sysuse auto, clear

eststo clear

eststo: reg price length foreign      mpg rep78 headroom
eststo: reg price c.length##c.foreign mpg rep78 headroom 


esttab ,  ar2 interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(N r2 r2_a, label( "Observations" "R-squared" "Adjusted R-squared") fmt(0 3 3)) title("Dependent variable: price") noconstant varwidth(30) 

// adjust order of variables in the table
esttab ,  ar2 interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(N r2 r2_a, label( "Observations" "R-squared" "Adjusted R-squared") fmt(0 3 3)) title("Dependent variable: price") noconstant varwidth(30) order(length foreign c.length#c.foreign headroom mpg rep78)
 
 
/*******************************************************************************
 Standard error clustering in regression model
 ******************************************************************************/
 
sysuse auto, clear


eststo clear

eststo: reg price  mpg rep78 headroom length 
eststo: reg price  mpg rep78 headroom length, cluster(make)

eststo: reg price  mpg rep78 headroom trunk weight length turn displacement gear_ratio
eststo: reg price  mpg rep78 headroom trunk weight length turn displacement gear_ratio, vce(cluster make)
eststo: reg price  mpg rep78 headroom trunk weight length turn displacement gear_ratio, vce(cluster foreign) // only 2, not recommended to cluster by foreign. This is for demonstration only.

// For double S.E. clustering, we need to use -reghdfe- instead
eststo: reghdfe price  mpg rep78 headroom trunk weight length turn displacement gear_ratio, vce(cluster foreign make) noa


esttab ,  ar2 mtitles("no cluster" "by make" "no cluster" "by make" "by foreign" "by make and foreign") interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(N r2 r2_a, label( "Observations" "R-squared" "Adjusted R-squared") fmt(0 3 3)) title("Dependent variable: price") noconstant varwidth(20) 



/*******************************************************************************
 A more complete example (?)
 ******************************************************************************/
 
sysuse auto, clear

eststo clear

eststo: reghdfe price  mpg rep78 headroom length, noa // option "noa" means no fixed effect absorbed
estadd local fe 		"none", replace
estadd local secluster 	"none", replace

eststo: reghdfe price  mpg rep78 headroom length, noa cluster(make) // cluster s.e. by make
estadd local fe 		"none", replace
estadd local secluster 	"by make", replace

eststo: reghdfe price  mpg rep78 headroom trunk weight length turn displacement gear_ratio, noa cluster(make)
estadd local fe 		"none", replace
estadd local secluster 	"by make", replace

eststo: reghdfe price  mpg rep78 headroom trunk weight length turn displacement gear_ratio, a(foreign) cluster(make)
estadd local fe 		"foreign", replace
estadd local secluster 	"by make", replace

eststo: reghdfe price  c.mpg##c.foreign rep78 headroom trunk weight length turn displacement gear_ratio, noa cluster(make)
estadd local fe 		"none", replace
estadd local secluster 	"by make", replace


esttab ,  ar2 interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(fe secluster N r2 r2_a, label("Fixed Effects" "S.E. cluster" "Observations" "R-squared" "Adjusted R-squared") fmt(0 3 3)) title("Dependent variable: price") noconstant varwidth(30) order(mpg foreign c.mpg#c.foreign)

