# denmark

[Statens Serum Institut](https://ssi.dk) dataset on daily Omicron
cases in Denmark. Details can be found here:
https://covid19.ssi.dk/virusvarianter/delta-pcr

## Sources

* https://files.ssi.dk/covid19/podepind-sekventering/variant-pcr-test-december2021/opgoerelse-variantpcr-covid19-20122021-l3h7
  (saved at file.pdf)

## Data dictionary

* **date** (date in DD-MM-YYYY): Date corresponding to case counts
* **positive_pcr** (int): Positive PCR tests where Variant PCR
  analysis has been performed
* **confirmed_omicron** (int): Confirmed cases of Omicron
* **inconclusive** (int): Number of PCR tests that were inconclusive
  with respect to variant identification
* **other_variants** (int): Number of PCR tests that corresponded to
  variants other than Omicron
* **omicron_percent** (float): Percentage of *confirmed_omicron*
  within *positive_pcr*
