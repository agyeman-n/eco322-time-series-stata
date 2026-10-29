# Time Series Econometrics in Stata

Stata code and output from my work for a course in Econometric Tools for Research in Macroeconomics. Each folder has the do-file and the log it produced.

| Folder | Topic | Methods |
|---|---|---|
| `hw1_unit_roots/` | Stationarity of West German investment and consumption, 1960–1982 | Lag selection with `varsoc`, ADF (`dfuller`), DF-GLS, and KPSS tests in levels and first differences |
| `hw2_cointegration_china/` | Replication of Chow and Wang (2010), "The Empirics of Inflation in China" | ADF and DF-GLS tests on log prices and log money-to-output, Johansen trace and max-eigenvalue tests (`vecrank`), Engle-Granger estimation and error-correction model (`egranger`) |
| `hw3_var_pakistan/` | Monetary transmission in Pakistan, 1974q1–2007q4 | Four-variable VARs (inflation, manufacturing output, exchange rate, and either the money market rate or reserve money), Granger causality tests, orthogonalized impulse responses |

In HW3, reserve money Granger-causes inflation at the 5% level (p = 0.033) while the money market rate does not, which is consistent with a money-based rather than rate-based transmission channel over the sample. The impulse response figures for both models are in the folder.

## Running the code

The do-files expect their data in the same folder. HW1 loads `lutkepohl2` with `webuse`, so it runs as is. The HW2 data (annual China series, 1952–2008) and HW3 data (Pakistan quarterly macro series) were provided by the course and are not included here. HW1 and HW2 install `kpss` and `egranger` from SSC.
