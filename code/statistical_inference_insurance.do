
use "${temp}/insurance.dta", clear


/*******************************************************************************
 Q1: What is a 99% CI of population proportion?
 ******************************************************************************/        

ci proportions affected, wald level(99)

