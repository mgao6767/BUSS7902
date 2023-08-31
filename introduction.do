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
 
// A line like this starting with "//" is a comment that will not be executed.
 
 /* Block comment starts with "/*" and ends with "*/",
    which can be placed anywhere...
	... so that all the enclosed text becomes a block of comments.
	*/ 


// To actually do something in Stata, we use commands.
// For example, the command "display" instructs Stata to print a message.
/* Hint:
   You can execute it by either of the following:
	1) manually type it in the Command window, and hit "Enter", or
	2) select the whole line here and hit
		"Ctrl+D" on Windows or "CMD+SHIFT+D" on Mac
 */
display "hello, world"

// Note that you can check the help file of "display" command by typing
// "help display" in the Command window.
// You can use this technique to check the help file of any command in Stata.
// For example, "help #delimit" tells you how to change line delimiter to ";"
// while by default we do not need a explicit line delimiter.


// Stata provides some example datasets, which can be loaded by "sysuse".
// You can use "sysuse dir" to list all example datasets available.

sysuse auto, clear			// use Automobile dataset, 
							// "clear" option relaces data in memory, if any
							
// Some basic commands
browse						// opens data browser
describe					// describe data, all variables by default
describe price make			// describe specified variables (e.g., price, make)


/* Variables in Stata are referenced by their names.
   Variable names are case-sensitive.
   Each variable can have an optional label to store more information.
   Variable labels can be very useful in tabulating results.
   It's recommended that you clearly label each variable whenever possible.
 */
 
// e.g., we can change the label of variable "price" to "Price ($)" to add unit
label variable price "Price ($)"

// then check again the variable label of "price":
des price					// "des" is short for "describe"
							// most Stata commands have an abbreviation:
							// "describe" -> "des"
							// "regress"  -> "reg" ...
	
// Besides the meta info of the variables, we can get their summary statistics:
summarize					// or simply "sum" or "su"

sum price, d				// check only summary stats of "price",
							// "d" is short for "detail" option.
							// the syntax of "summarize" command (see help file)
							// says that after the comma "," are options.
							// most Stata commands have options.

// Simple plotting
hist price					// produce a histogram for "price"
							// Graphics>Histogram dialog allows you to build a 
							// more complex or customised histogram.		
	

// Simple OLS regression
// Stata is a powerful statistical software, and so regression analysis is 
// straightforward with the builtin command "regress", or "reg" in short.

// Say, we'd like to know how various factors affect the price of a car, and
// we choose to regress car price on an array of variables.
// Our Stata command literally reads so, "regress Y on X":
reg price mpg rep78 headroom trunk weight length turn displacement gear_ratio foreign
	
/* Note that the above command may be a little too long (>80 characters).
   We can break a long line to multiple lines by adding three forward slashes
   "///" in between, e.g., */
reg price mpg rep78 headroom trunk weight ///
          length turn displacement        ///
		  gear_ratio foreign
// which yields the same regression result.
// This is purely aesthetic preference ;-)



// We can save the table in Word file very easily.
putdocx begin
putdocx table mytable = etable
putdocx save auto.docx, replace





