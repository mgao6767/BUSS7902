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
 Example: 4 Machines
 ******************************************************************************/
 
// The original dataset from Excel spreadsheet is not in a desirable format
use "${data}/4machines.dta", clear

// Reshape it
gen i = _n
reshape long machine id, i(i) j(group)
drop i id

// One-way ANOVA
oneway machine group, tabulate

// Normality test using Jarque-Bera Test

// Surprisingly Stata does not have available command, 
// perhaps because it's too easy?

/* NOTE on the Kurtosis
	See https://en.wikipedia.org/wiki/Kurtosis#Sample_kurtosis
	Excel uses the Standard unbiased estimator
	Stata uses the natural but biased estimator (method of moments)
	
   NOTE on the Skewness
    Excel SKEW() uses the sample skewness, SKEW.P() uses the population skewness
	Stata uses the latter or the Fisher's moment coefficient of skewness
 */ 
 
quietly su machine if group==1, detail
local jb_stat = r(N) * (r(skewness)^2 + (r(kurtosis)-3)^2/4)/6
di "JB test stat is " `jb_stat'
// Very different result from Excel. We trust Stata.
di "Chi2 critical value is " invchi2(2, 1-0.05)


// Two-sample variance F-test

// As an example, machine1 vs machine2
sdtest machine if group==1 | group==2, by(group)
// As an example, machine2 vs machine3
sdtest machine if group==2 | group==3, by(group)




/*******************************************************************************
 Example: Assembly
 ******************************************************************************/
 
use "${data}/assembly2.dta", clear

quietly su time, detail
local jb_stat = r(N) * (r(skewness)^2 + (r(kurtosis)-3)^2/4)/6
di "JB test stat is " `jb_stat'
di "p-value is " 1 - chi2(2, `jb_stat')
di "Chi2 critical value is " invchi2(2, 1-0.05)




/*******************************************************************************
 Example: Salary
 ******************************************************************************/

// The original dataset from Excel spreadsheet is not in a desirable format
use "${data}/salary.dta", clear

// Let's rename and reshape 
rename group1 salary1
rename group2 salary2
rename group3 salary3
rename group4 salary4

gen i = _n
reshape long salary id, i(i) j(group)
drop i id


// One-way ANOVA
oneway salary group, tabulate


// Normality test using Jarque-Bera Test, same as before

quietly su salary if group==1, detail
local jb_stat = r(N) * (r(skewness)^2 + (r(kurtosis)-3)^2/4)/6
di "JB test stat is " `jb_stat'
// Very different result from Excel. We trust Stata.
di "Chi2 critical value is " invchi2(2, 1-0.05)
