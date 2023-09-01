
use "${temp}/garlic.dta", clear


/*******************************************************************************
 Q1: Summary statistics
 ******************************************************************************/
 
tabstat x,  stat(mean semean median sd variance kurtosis skewness ///
 range min max sum count) col(var)

 
/*******************************************************************************
 Q2: Test for population mean (known variance)
 ******************************************************************************/

// Assume population standard deviation is 10
ztest x==500, sd(10)

di "p-value two-tail: " r(p)
di "p-value one-tail: " r(p)/2
di "Z credical value one-tail: " invnormal(1-0.05)
di "Z credical value two-tail: " invnormal(1-0.05/2)

// Alternatively, ...
// su x, mean
// ztesti `r(N)' `r(mean)' 10 500
