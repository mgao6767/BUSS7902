
use "${temp}/magicbox.dta", clear


/*******************************************************************************
 Q1: What is the point estimate of P(Green)?
 ******************************************************************************/        

display "Number of success, x"
count if x==1
scalar numSuccess = r(N)
 
display "Sample size, n"
count
scalar sampleSize = r(N)

di "Sample proportion (x/n) = "	numSuccess/sampleSize

 
/*******************************************************************************
 Q2: What is a 95% CI of P(Green)?
 ******************************************************************************/ 

ci proportions x, wald			// "ci" CIs for means, proportions and variances

// "proportion" estimates proportions
// proportion x, citype(normal)	
// di "Note that {cmd:citype(normal)} uses t-distribution in {cmd:proportion}!"


/*******************************************************************************
 Q3: Is P(Green) = 0.25? 
     Is P(Green) > 0.20? 
     Is P(Green) < 0.30? 
 ******************************************************************************/                        
 
prtest x==0.25

prtest x==0.2

prtest x==0.3


di "For one-sample tests of proportions with small-sample sizes and to obtain exact p-values, researchers should use {stata help bitest:bitest}"

