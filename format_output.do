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
 Example code to produce formatted regression output
 ******************************************************************************/

// Summary statistics

// clear whatever is already stored
eststo clear

// -estpost- posts results from various Stata commands in e() so that they can be
// tabulated using esttab or estout.
estpost tabstat margin number nearest office enrolment income distance, stats(mean sd p10 median p90 n) columns(statistics) 

// -esttab- is then used to display formatted regression table
// Here we specify the cells directly as we don't yet have any regression output
// For example, "mean(fmt(%9.3f))" prints out sample mean with 3 decimal points
// "label" option prints out variable label instead of variable name
// "type" force printing to the screen (we can print to file too)
// ... many more options, see help file
esttab ., replace cells("count mean(fmt(%9.3f)) sd(fmt(%9.3f)) p10(fmt(%9.3f)) p50(fmt(%9.3f)) p90(fmt(%9.3f))")  noobs nonumber type label compress


// We can also output the table directly to a file
// For example, to a CSV file
esttab using "Table_1_summary_stat.csv", csv replace cells("count mean(fmt(%9.3f)) sd(fmt(%9.3f)) p10(fmt(%9.3f)) p50(fmt(%9.3f)) p90(fmt(%9.3f))") nonumber noobs label 

// Or, to a TeX file
esttab using "Table_1_summary_stat.tex", tex replace cells("count mean(fmt(%9.3f)) sd(fmt(%9.3f)) p10(fmt(%9.3f)) p50(fmt(%9.3f)) p90(fmt(%9.3f))") nonumber noobs label 



// About regression 
// It is very common that we report regression results of sevearl related models
// in a single table.

// Start by clearing whatever is alread stored
eststo clear

// Model 1
eststo: reg margin number nearest

// Model 2
eststo: reg margin number nearest office

// Model 3
eststo: reg margin number nearest office enrolment 

// Model 4
eststo: reg margin number nearest office enrolment income 

// Model 5
eststo: reg margin number nearest office enrolment income distance


// Export to CSV file
esttab using "Table_2_baseline.csv", csv replace ar2 mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5") interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(N r2 r2_a, label( "Observations" "R-squared" "Adjusted R-squared") fmt(0 3 3)) title("Dependent variable: margin") noconstant 

// Export to TeX file
esttab using "Table_2_baseline.tex", tex replace ar2 mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5") interaction(" \$\times\$ ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(N r2 r2_a, label( "Observations" "\$R^2\$" "Adjusted \$R^2\$") fmt(0 3 3)) title("Dependent variable: margin") noconstant 



// We can also add more to it...

eststo clear

// Model 1
eststo: reg margin number nearest
estadd local sample "All", replace

// Model 2
eststo: reg margin number nearest office
estadd local sample "All", replace

// Model 3
eststo: reg margin number nearest office enrolment 
estadd local sample "All", replace

// Model 4, removing some "outliers"
sum margin, detail
gen toRemove = margin<r(p5) | margin>r(p95)
eststo: reg margin number nearest office enrolment if !toRemove
estadd local sample "Winsored", replace


// Export to CSV file
esttab using "Table_3_robustness.csv", csv replace ar2 mtitles("Model 1" "Model 2" "Model 3" "Model 4") interaction(" X ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(sample N r2 r2_a, label("Sample" "Observations" "R-squared" "Adjusted R-squared") fmt(a1 0 3 3)) title("Dependent variable: margin") noconstant 

// Export to TeX file
esttab using "Table_3_robustness.tex", tex replace ar2 mtitles("Model 1" "Model 2" "Model 3" "Model 4") interaction(" \$\times\$ ") star(* 0.10 ** 0.05 *** 0.01) nogaps compress b(3) t(3) ar2(3) nodepvar label noconstant s(sample N r2 r2_a, label("Sample" "Observations" "\$R^2\$" "Adjusted \$R^2\$") fmt(a1 0 3 3)) title("Dependent variable: margin") noconstant 


