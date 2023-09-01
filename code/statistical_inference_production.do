
use "${temp}/production.dta", clear


/*******************************************************************************
 Q1: Summary statistics
 ******************************************************************************/
 
tabstat x,  stat(mean semean median sd variance kurtosis skewness ///
 range min max sum count) col(var)

 
/*******************************************************************************
 Q2: Test for population mean (unknown variance)
 ******************************************************************************/

loc hypothesized_mean = 100

ttest x==`hypothesized_mean'

di "p-value two-tail: " r(p)
di "p-value one-tail: " r(p)/2
di "t credical value one-tail: " invt(r(df_t), 1-0.05)
di "t credical value two-tail: " invt(r(df_t), 1-0.05/2)
