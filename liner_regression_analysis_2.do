/*******************************************************************************
  ____  _   _ ____ ____ _____ ___   ___ ____  
 | __ )| | | / ___/ ___|___  / _ \ / _ \___ \ 
 |  _ \| | | \___ \___ \  / / (_) | | | |__) |
 | |_) | |_| |___) |__) |/ / \__, | |_| / __/ 
 |____/ \___/|____/____//_/    /_/ \___/_____|
 
 Welcome to BUSS7902 Quantitative Business Research Methods
 
 - Instructor: Dr. Claire Liu (claire.liu@sydney.edu.au)
 - Assistant: Dr. Mingze Gao (mingze.gao@sydney.edu.au)
 - 2023 Semester 1, University of Sydney
 
 ******************************************************************************/   
 

/* Hint:
   You can execute this file by either of the following:
	1) Click on the "Execute (do)" button
	2) "Ctrl+D" on Windows or "CMD+SHIFT+D" on Mac
 */
 
 
 /*******************************************************************************
 Example: Real Estate
 ******************************************************************************/
 
 // The original dataset from Excel spreadsheet
use "./data/real_estate.dta", clear

// Investigate multiculinearity
corr x1 x2
// |Corr(X1,X2)| = 0.3283 < 0.95 ==> Multicollinearity does not exist
pwcorr x1 x2, sig

// Remember to check help file
// help reg
reg y x1 x2


// Plot y against x1 and x2, respectively
twoway scatter y x1
twoway scatter y x1

// Plot y against x1 and x2, together
twoway (scatter y x1) (scatter y x2)


// Get predicted values of Y
predict y_predicted

// Multiple R, correlation between Y and Y_predicted
// https://en.wikipedia.org/wiki/Coefficient_of_multiple_correlation
corr y y_predicted


// Get residuals
// Put residuals in a new variable named "resid"
predict resid, residuals

// Standarized residuals
center resid, standardize generate(c_resid)


// Plots
// Ordered values of varname against quantiles of uniform distribution
quantile y

// Quantiles of varname against quantiles of normal distribution
qnorm y

// Residusls agains predicted values
twoway scatter resid  y_predicted 


// Prediction Interval

cap drop y_predicted

// Add one more observation
local newobs = _N + 1
set obs `newobs' 		// set number of obs. to be current obs.+1
replace x1=250 in L		// set x1, x2 values in the last (new) obs.
replace x2=12 in L
 
// Get predicted values of Y
predict y_predicted
// Get the standard error of the predicted value
predict se_forecast, stdf // stdf is undocumented
// critical value
gen tmult = invttail(20, .025)
// lower and upper bounds for the Prediction Interval
gen prediction_interval_lb = y_predicted - tmult * se_forecast
gen prediction_interval_ub = y_predicted + tmult * se_forecast

list if x1==250 & x2==12


 
 

