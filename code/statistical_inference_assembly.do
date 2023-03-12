
use "./assembly.dta", replace


/*******************************************************************************
 Q1: Summary statistics of time
 ******************************************************************************/        

summarize time, detail

tabstat time,  stat(mean semean sd variance kurtosis skewness ///
 range min max sum count) col(var)
 
/* NOTE on the Kurtosis
	See https://en.wikipedia.org/wiki/Kurtosis#Sample_kurtosis
	Excel uses the Standard unbiased estimator
	Stata uses the natural but biased estimator (method of moments)
	
   NOTE on the Skewness
    Excel SKEW() uses the sample skewness, SKEW.P() uses the population skewness
	Stata uses the latter or the Fisher's moment coefficient of skewness
 */ 

/*******************************************************************************
 Q2: What is a 95% CI of population mean (known variance)?
 ******************************************************************************/                                             
// Assume that we know the sample standard deviation is 10

ci mean time		// uses the sample std.dev.=11.06, not 10

// We can do ...
quietly: summarize time
scalar obs = r(N)
scalar mu = r(mean)
scalar knownSD = 10

cii means obs mu knownSD	// uses t-distribution not standard normal


// Normal approximation (standard normal distribution):
scalar critval = invnormal(1-(1-0.95)/2)
scalar stderr = knownSD / sqrt(obs)

sca cilb = mu - critval * stderr
sca ciub = mu + critval * stderr
di "mean = " mu ", CI(lower) = " cilb ", CI(upper) = " ciub


