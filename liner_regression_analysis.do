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
 Example: Exam
 ******************************************************************************/
 
 // The original dataset from Excel spreadsheet
use "./data/exam.dta", clear

 
// Correlation?
corr


// This codeblock below is to do statistical testing for population correlation
// after running the "corr" command
quietly {

	scalar sample_size = 1221		 // modify as needed
	scalar hypothesised_val = 0.65    // modify as needed
	scalar level_significance = 0.05 // modify as needed
	
	scalar dof = sample_size - 2
	scalar sample_corr = r(rho)
	
	scalar se = sqrt((1-sample_corr^2)/dof)
	scalar t  = (sample_corr - hypothesised_val)/se

	scalar p_val_onetail = 1 - t(dof,t)
	scalar p_val_twotail = 2 * p_val_onetail

	scalar t_critical_val_onetail = invt(dof,1-level_significance)
	scalar t_critical_val_twotail = invt(dof,1-level_significance/2)

}
// Display results:
	di "Test statistic t is " t
	di "One-tail p-value is " p_val_onetail
	di "Two-tail p-value is " p_val_twotail
	di "One-tail t critical value is " t_critical_val_onetail
	di "Two-tail t critical value is " t_critical_val_twotail



// Remember to check help file
// help reg
reg y x

// Get predicted values of Y
predict y_predicted

// What's E(y|x=75)?
// If there is an observation where x=75, 
// then the predicted value is available
list if x==75

// But what if we want E(Y|X=x) where x is not in the sample?
// help margins 
// -- Marginal means, predictive margins, and marginal effects
margins, at(x=75) 

// Note that -margins- gives the Confidence Interval for the predcited value
// However, we are interested in the Prediction Interval given x=75

// So, we need to get the standard error of the predicted value
predict se_forecast, stdf
// critical value
gen tmult = invttail(1219, .025)
// lower and upper bounds for the Prediction Interval
gen prediction_interval_lb = y_predicted - tmult * se_forecast
gen prediction_interval_ub = y_predicted + tmult * se_forecast

list if x==75


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

 
 

 
 /*******************************************************************************
 Example: Galton
 ******************************************************************************/
 
// The original dataset from Excel spreadsheet
use "./data/galton.dta", clear


// Correlation?
corr


// This codeblock below is to do statistical testing for population correlation
// after running the "corr" command
quietly {

	scalar sample_size = 100		 // modify as needed
	scalar hypothesised_val = 0.3    // modify as needed
	scalar level_significance = 0.01 // modify as needed
	
	scalar dof = sample_size - 2
	scalar sample_corr = r(rho)
	
	scalar se = sqrt((1-sample_corr^2)/dof)
	scalar t  = (sample_corr - hypothesised_val)/se

	scalar p_val_onetail = 1 - t(dof,t)
	scalar p_val_twotail = 2 * p_val_onetail

	scalar t_critical_val_onetail = invt(dof,1-level_significance)
	scalar t_critical_val_twotail = invt(dof,1-level_significance/2)

}
// Display results:
	di "Test statistic t is " t
	di "One-tail p-value is " p_val_onetail
	di "Two-tail p-value is " p_val_twotail
	di "One-tail t critical value is " t_critical_val_onetail
	di "Two-tail t critical value is " t_critical_val_twotail
	



// Remember to check help file
// help reg

reg son father

// Get predicted values of Y
predict son_predicted

// What's E(son|father=70)?
// If there is an observation where father=70, 
// then the predicted value is available
list if father==70

// But what if we want E(Y|X=x) where x is not in the sample?
// e.g., E(son|father=70)?
// help margins 
// -- Marginal means, predictive margins, and marginal effects
margins, at(father = 70)

predict se_forecast, stdf
// critical value
gen tmult = invttail(1219, .025)
// lower and upper bounds for the Prediction Interval
gen prediction_interval_lb = son_predicted - tmult * se_forecast
gen prediction_interval_ub = son_predicted + tmult * se_forecast

list if father==70


// Get residuals
// Put residuals in a new variable named "resid"
predict resid, residuals

// Standarized residuals
center resid, standardize generate(c_resid)


// Plots
// Ordered values of varname against quantiles of uniform distribution
quantile son

// Quantiles of varname against quantiles of normal distribution
qnorm son

// Residusls agains predicted values
twoway scatter resid  son_predicted 


