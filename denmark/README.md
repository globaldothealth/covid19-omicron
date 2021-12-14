# denmark

[Statens Serum Institut](https://ssi.dk) dataset on daily Omicron
cases in Denmark. Details can be found here:
https://covid19.ssi.dk/virusvarianter/delta-pcr

## Sources

* https://files.ssi.dk/covid19/omikron/statusrapport/rapport-omikronvarianten-11122021-uy12
  (saved at file.pdf)

## Data dictionary

* **date** (date in DD-MM-YYYY): Date corresponding to case counts
* **cases** (int): Number of COVID-19 cases
* **omicron_cases** (int): Number of COVID-19 cases with the Omicron
  variant
* **omicron_percent** (float): Percentage of *omicron_cases* within *cases*
