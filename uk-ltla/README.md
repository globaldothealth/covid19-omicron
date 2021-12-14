# uk-ltla

Counts of omicron cases by UK LTLA (lower tier local authority),
merged with aggregated data from the [UK Coronavirus
dashboard](https://coronavirus.data.gov.uk/), and geocoded using
[Office for National Statistics](https://www.ons.gov.uk) lookup
table.

## Sources

* https://khub.net/documents/135939561/405676950/Confirmed+Omicron+cases+SGTF+LTLA+2021-12-08.xlsx/8003737a-cfc5-a320-2b55-794495cdbb09
  (saved at ltla_sgtf.xlsx)
* https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=newCasesBySpecimenDate&format=csv
  (saved at ltla_daily_cases.csv)

## Data dictionary

* **date** (date in YYYY-MM-DD): Week in which specimen was taken
  from case (week following Monday-Sunday)
* **areaName**: LTLA of residence of case (2021 geography)
* **Region**: Region of residence of case (2021 geography),
  previously referred to as 'PHE Region'
* **Confirmed Omicron cases** (int): Number of confirmed Omicron
  cases via whole-genome sequencing or genotyping
* **SGTF cases** (int): Number of SGTF cases (Case confirmed to have
  SGTF in a sample with specimen date since November 1st 2021,
  excluding confirmed Omicron cases and cases identified to be
  a different variant. Note SGTF totals may therefore differ from
  other publications where this exclusion does not occur)
* **Total** (int): Total number of cases (SGTF cases + Confirmed
  Omicron cases)
* **newCasesBySpecimenDate** (int): Aggregated over the preceding
  week, the total number of COVID-19 cases obtained from the
  dashboard. The entry corresponding to a week starting Monday is
  the sum total of daily counts for the *previous* week ending on
  that day.
* **long** (float): Geocoded longitude of LTLA from lookup table
* **lat** (float): Geocoded latitude of LTLA from lookup table
