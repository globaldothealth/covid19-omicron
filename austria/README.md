# austria

Austrian Agency for Health and Food Safety dataset on variant numbers

See more details on the dataset at:
https://www.ages.at/en/topics/pathogenic-organism/coronavirus/sars-cov-2-varianten-in-oesterreich/

## Sources

* https://www.ages.at/fileadmin/AGES2015/Themen/Krankheitserreger_Dateien/Coronavirus/Varianten_ab_Mai/Varianten_nach_KWs_2021-12-20.csv
  (saved at data.csv)

## Data dictionary

All column types are integers unless stated otherwise.

* **week** (int): Week in 2021 corresponding to the data
* **date** (date in YYYY-MM-DD): Monday corresponding to *week*
* **alpha**: Number of cases with the B.1.1.7 (Alpha) variant
* **beta**: Number of cases with the B.1.351 (Beta) variant
* **gamma**: Number of cases with the P.1 (Gamma) variant
* **delta**: Number of cases with the B.1.617.2 (Delta) variant
* **omicron**: Number of cases with the B.1.1.529 (Omicron) variant
* **total**: Total number of cases
