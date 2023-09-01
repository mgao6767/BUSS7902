
use "${temp}/survey.dta", clear


/*******************************************************************************
 Q1: Summary statistics
 ******************************************************************************/
 
tabstat x,  stat(mean semean median sd variance kurtosis skewness ///
 range min max sum count) col(var)

 
/*******************************************************************************
 Q2: Test for population proportion
 ******************************************************************************/


prtest x==0.12, level(90)


di "p-value two-tail: " r(p)
di "p-value one-tail: " r(p)/2
di "t credical value one-tail: " invnormal(1-0.1)
di "t credical value two-tail: " invnormal(1-0.1/2)
