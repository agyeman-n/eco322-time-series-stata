* ECO322 - Homework 2: Chow and Wang (2010), Empirics of Inflation in China

clear all
capture log close
log using "hw2.log", replace text

* Load data (no header row: A = year, B = P, C = M2, D = Y)
import excel "Chow-Wang_Data.xls", clear
rename (A B C D) (year P M2 Y)
tsset year, yearly

gen lp  = ln(P)
gen lmy = ln(M2/Y)

* (1) Augmented Dickey-Fuller tests

* Choosing lag length
varsoc lp
varsoc lmy

* levels; tests with a time trend (lags = varsoc lag - 1)
dfuller lp, trend lags(2) regress
dfuller lmy, trend lags(1) regress
dfgls lp
dfgls lmy

* first differences
dfuller D.lp, lags(1) regress
dfuller D.lmy, lags(1) regress

* (2) Johansen cointegration test
varsoc lp lmy
vecrank lp lmy, lags(2)
vecrank lp lmy, lags(2) level99
vecrank lp lmy, lags(2) max levela

* (3) Engle-Granger estimation
ssc install egranger
egranger lp lmy
egranger lp lmy, ecm lags(1) regress

log close

* Save the log as a PDF
translate "hw2.log" "hw2.pdf", replace
