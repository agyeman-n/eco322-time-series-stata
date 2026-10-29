* setup
ssc install kpss, replace
capture log close
log using hw1.log, text replace
webuse lutkepohl2, clear

* Choosing lag length 
varsoc ln_inv
varsoc ln_consump

* levels; tests with a time trend 
dfuller ln_inv, trend lags(1) regress
dfuller ln_consump, trend lags(3) regress
dfgls ln_inv
dfgls ln_consump
kpss ln_inv
kpss ln_consump

* First differences; no trend 
dfuller D.ln_inv, drift lags(1) regress
dfuller D.ln_consump, drift lags(3) regress
dfgls D.ln_inv, notrend
dfgls D.ln_consump, notrend
kpss D.ln_inv, notrend
kpss D.ln_consump, notrend

log close
translate hw1.log hw1.pdf, replace
