# europe

ECDC dataset on variants

https://www.ecdc.europa.eu/en/publications-data/data-virus-variants-covid-19-eueea

**Data license**: [ECDC copyright](https://www.ecdc.europa.eu/en/copyright), [GISAID acknowledgments](https://www.ecdc.europa.eu/en/publications-data/gisaid-acknowledgements)

## Sources

* https://opendata.ecdc.europa.eu/covid19/virusvariant/csv/data.csv
  (saved at europe.csv)

## Data dictionary

Based on [upstream data dictionary](https://www.ecdc.europa.eu/sites/default/files/documents/2021-04-19_Variable_Dictionary_and_Disclaimer_variant-data.pdf), updated to follow current data.


All column types are strings unless stated otherwise.

* **country**: Country corresponding to counts
* **country_code**: Country ISO-3166-1 two letter code
* **year_week**: Year followed by week number, separated by hyphen
  (-)
* **source**: Data source, either GISAID or TESSy
* **new_cases** (int): Weekly number of new confirmed cases. Set to
  zero in the event that countries have negative case counts due to
  retrospective correction of data.
* **number_sequenced** (int): Weekly number of sequences carried out
* **percent_cases_sequenced** (float): Percentage of *new_cases* in
  *number_sequenced*
* **valid_denominator**: GISAID data: Yes, TESSY data: No if there
  are discrepancies in the data reported for a given week, such as
  where the sum of number_detections_variant across all variants
  exceeds number_sequenced (aggregate data), or where no sequences
  have been reported that are coded as 'wild type' (case based data)
* **variant**: Each VOC, SGTF, Other or UNK 
* **number_detections_variant** (int): Number of detections reported of
  the variant
* **number_sequenced_known_variant** (int): Total number of sequences
  corresponding to *source* in *year_week*
* **percent_variant** (float): Percentage of *number_detections_variant* in
  *number_sequenced*. No value given if *valid_denominator* = No

