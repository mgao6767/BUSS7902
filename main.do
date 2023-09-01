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


/* 1 to execute, 0 to only open the files */
local execute_do_files = 1


/*******************************************************************************
 Setup
 ******************************************************************************/
cls
set more off
set linesize 255

cap ado uninstall setroot
net install setroot, from("https://raw.githubusercontent.com/sergiocorreia/stata-setroot/master/src/")

setroot, more
cd $root

/* 
  -setroot- makes available global macros for the directories in the folder.
  It is useful for cross-platform/computer compatibility of the code.
 */
di "Project root: ${root}"
di "- folder for code: ${code}"
di "- folder for data: ${data}"
di "- folder for temporary files: ${temp}"
di "- folder to store logs: ${log}"
di "- folder to store input files: ${input}"
di "- folder to store outputs (figures, tables, etc.): ${output}"
di "  - subfolder within outputs for figures: ${figures}"
di "  - subfolder within outputs for tables: ${tables}"

/* 
  Delete all files in the temp folder
 */
local temp_files : dir "${temp}" files "*"
foreach f of local temp_files {
    erase "${temp}/`f'"
}

/*******************************************************************************
 Start logging
 ******************************************************************************/

global logname "BUSS7902"

local today : display %tdCYND date(c(current_date), "DMY")
cap log close ${logname}
log using "${log}/`today'.log", replace name(${logname})


/*******************************************************************************
 Introduction
 ******************************************************************************/
/* 
  Open introduction.do in the do editor
 */
doedit ${code}/introduction.do

/*******************************************************************************
 Statistic inference
 ******************************************************************************/
doedit ${code}/statistical_inference_1.do
doedit ${code}/statistical_inference_2.do
doedit ${code}/statistical_inference_3.do
doedit ${code}/statistical_inference_4.do

if `execute_do_files' {
  do ${code}/statistical_inference_1.do
  do ${code}/statistical_inference_2.do
  do ${code}/statistical_inference_3.do
  do ${code}/statistical_inference_4.do
}

/*******************************************************************************
 Linear regression analysis
 ******************************************************************************/
doedit ${code}/liner_regression_analysis_1.do
doedit ${code}/liner_regression_analysis_2.do
doedit ${code}/liner_regression_analysis_3.do

if `execute_do_files' {
  do ${code}/liner_regression_analysis_1.do
  do ${code}/liner_regression_analysis_2.do
  do ${code}/liner_regression_analysis_3.do
}

/*******************************************************************************
 Stop logging
 ******************************************************************************/

log close ${logname}


