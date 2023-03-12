
use "./distance.dta", clear


/*******************************************************************************
 Q1: Summary statistics of time
 ******************************************************************************/        

tabstat kms,  stat(mean semean median sd variance kurtosis skewness ///
 range min max sum count) col(var)
 
// Stata doesn't have a command to calculate mode, which we care less often
// In this dataset, we have multiple modes...
tab1 kms, sort

/*******************************************************************************
 Q2: What is a 95% CI of population mean (unknown variance)?
 ******************************************************************************/

ci mean kms		// uses the sample std.dev.


