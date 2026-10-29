* ECO322 HW3

clear all
capture log close
log using "hw3.log", replace text

* Load data
use "PK_Data_HW3.dta", clear

rename consumerpriceindex           inflation
rename productionindexmanufacturing mfg
rename moneymarketrate              intrate
rename exchangerate                 exrate
rename reservemoney                 mgrowth

* Quarterly date from var1 and restrict sample to 1974-2007
gen date = qofd(dofm(monthly(var1, "MY")))
format date %tq
tsset date
keep if tin(1974q1, 2007q4)

summarize inflation mfg intrate exrate mgrowth


* MODEL 1


*varsoc command to determine the number of lags
varsoc inflation mfg intrate exrate, maxlag(8)

*var command to run vector autoregression
var inflation mfg intrate exrate, lags(1/5) dfk small

*display variance-covariance matrix
matlist e(Sigma)

*Granger causality tests
vargranger

*create impulse response functions
quietly var inflation mfg intrate exrate, lags(1/5) dfk small
irf create var1, step(20) set(myirf) replace

*graph impulse response functions
irf graph oirf, irf(var1) impulse(inflation mfg intrate exrate) ///
    response(inflation mfg intrate exrate) ///
    yline(0, lcolor(black)) xlabel(0(4)20) ylabel(#5) byopts(yrescale)
graph export "irf_model1_interest.png", replace width(2000)


* MODEL 2


varsoc inflation mfg mgrowth exrate, maxlag(8)

var inflation mfg mgrowth exrate, lags(1/5) dfk small

matlist e(Sigma)

vargranger

quietly var inflation mfg mgrowth exrate, lags(1/5) dfk small
irf create var2, step(20) set(myirf) replace

irf graph oirf, irf(var2) impulse(inflation mfg mgrowth exrate) ///
    response(inflation mfg mgrowth exrate) ///
    yline(0, lcolor(black)) xlabel(0(4)20) ylabel(#5) byopts(yrescale)
graph export "irf_model2_money.png", replace width(2000)

log close

* Save the log as a PDF
translate "hw3.log" "hw3.pdf", replace
