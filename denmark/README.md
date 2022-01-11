# denmark

[Statens Serum Institut](https://ssi.dk) dataset on daily Omicron
cases in Denmark. Details can be found here:
https://covid19.ssi.dk/virusvarianter/delta-pcr

## Sources

* https://files.ssi.dk/covid19/podepind-sekventering/variant-pcr-test-december2021/opgoerelse-variantpcr-covid19-11012022-sp2h
  (saved at file.pdf)

## Data dictionary

* **date** (date in DD-MM-YYYY): Date corresponding to case counts
* **total_positive_pcr** (int): Total number of positive PCR cases on this date
* **positive_pcr** (int): Positive PCR tests where Variant PCR
  analysis has been performed by Testcenter Danmark (TCDK)
* **other_variants** (int): Number of PCR tests corresponding to variants
  variants other than Omicron
* **inconclusive** (int): Number of PCR tests that were inconclusive
  with respect to variant identification
* **confirmed_omicron** (int): Confirmed cases of Omicron
* **omicron_percent** (float): Percentage of *confirmed_omicron*
  within *positive_pcr*
