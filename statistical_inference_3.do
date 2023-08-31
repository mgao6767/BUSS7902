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
 Q1: CI for population mean (known variance)
	
	Test for two-sample mean with known variance
 ******************************************************************************/
 
// Command ztesti
// Immediate form of two-sample unpaired z test
// ztesti #obs1 #mean1 #sd1 #obs2 #mean2 #sd2 [, level(#)]

// "Commision" example

ztesti 60 33000 7000 100 30250 7000, level(95)

// "Leave" example

ztesti 36 73 6 36 62 6, level(99)


/*******************************************************************************
 Q2: CI for population mean (unknown variances)
 ******************************************************************************/
 
// Command ttesti
// Immediate form of two-sample t test
// ttesti #obs1 #mean1 #sd1 #obs2 #mean2 #sd2 [, options2]
// options2          Description
// -----------------------------------------------------------------------------
//     Main
//       unequal         unpaired data have unequal variances
//       welch           use Welch's approximation
//       level(#)        set confidence level; default is level(95)

// welch specifies that the approximate degrees of freedom for the test be
//         obtained from Welch's formula (1947) rather than from Satterthwaite's
//         approximation formula (1946), which is the default when unequal is
//         specified.  Specifying welch implies unequal.

// Mingze's note: https://en.wikipedia.org/wiki/Welch%27s_t-test

// "11.12" example, equal variances

ttesti 15 1.48 0.18  15 1.23 0.14, level(90) 

// "11.12" example, unequal variance

ttesti 15 1.48 0.18  15 1.23 0.14, unequal level(90) 

// "11.24" example is paired

ttesti 5 3.8 3.11 0, level(95)

// "11.33" example is about proportion
// Immediate form of two-sample test of proportions
// prtesti #obs1 #p1 #obs2 #p2 [, level(#) count]

prtesti 200 0.25 100 0.35, level(95)


/*******************************************************************************
 Q3: Variale based, unknown and known variances
 ******************************************************************************/
 
// 1) Two-sample mean test, known but unequal variances

use "./data/store.dta", clear

// Also, Statistics->Summaries,tables and tests->Classical tests of hypotheses
// ->z test (mean comparison test, known variance)

ztest logancity == ipswich, unpaired sd1(5365) sd2(7440) level(95)


// 2) Two-sample mean test, unknown but equal variances, independent samples

use "./data/desk.dta", clear

ttest designa == designb, unpaired level(95)


// 3) Two-sample mean test, unknown and unequal variances, independent samples

use "./data/cereals.dta", clear

ttest consumers == nonconsumers, unpaired level(95) unequal


// 4) Two-sample mean test, unknown and unequal variances, dependent samples
// H0: mu1 - mu2 = 2
gen newdesign_2 = newdesign - 2

ttest newdesign_2 == existingdesign, level(95) 


// 5) Two-sample proportion test, non-zero difference
// H0: p1 - p2 = d
// d = 0.03, p1 = 0.16
// no available command for this test

local se = sqrt(.16*(1-.16)/500+.05*(1-.05)/200)
local z = (.16-.05-.03)/`se'
di "Test stat z is " `z'
di "Z critical value one-tail: " invnormal(1-0.05)
di "Z critical value two-tail: " invnormal(1-0.05/2)


