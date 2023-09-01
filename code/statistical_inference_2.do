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
display "BUSS7902 Chapter 4A - Statistical Inference II"



/*******************************************************************************
 Import data from Excel spreadsheet
 ******************************************************************************/                    

local spreadsheet "${input}/spreadsheets/BUSS7902 Chapter 4B Lecture (Data).xlsx"

import excel using "`spreadsheet'", describe

forvalues i=1/`r(N_worksheet)' {
	loc sheetname "`r(worksheet_`i')'"
	loc range "`r(range_`i')'" // e.g. A1:K101
	loc rangeClose = substr("`range'", 5, strlen("`range'"))
	qui: import excel using "`spreadsheet'", firstrow sheet("`sheetname'") ///
		cellrange(A1:A`rangeClose') clear
	loc sheetname = strlower("`sheetname'")
	save "${temp}/`sheetname'.dta", replace
}


/*******************************************************************************
 Run do files and solve questions
 ******************************************************************************/                    

do "${code}/statistical_inference_garlic.do"
do "${code}/statistical_inference_advertising.do"
do "${code}/statistical_inference_production.do"
do "${code}/statistical_inference_survey.do"
do "${code}/statistical_inference_product.do"

