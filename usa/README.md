# usa

USA CDC dataset on variants

The dataset is from:
https://covid.cdc.gov/covid-data-tracker/#variant-proportions

This is not a time-series dataset, it is an aggregation of variant
statistics across US jurisdictions across a time period.

## Sources

* https://public.tableau.com/views/WeightedStateVariantTable/StateVBMTable.csv?%3Adisplay_static_image=y&%3AbootstrapWhenNotified=true&%3Aembed=true&%3Alanguage=en-US&:embed=y&:showVizHome=n&:apiID=host0#navType=0&navSrc=Parse
  (saved at usa.csv)

## Data dictionary

All column types are strings unless stated otherwise.

* **Measure Names**: Measure names are one of *Share Low*, *Share*
  or *Share High*, where share represents estimated weighted
  proportions of variants by jurisdiction. *Share Low* and *Share
  High* represent the lower and upper of the confidence interval.
* **State/Jurisdiction**: Jurisdiction (state or territory)
* **Variant**: Variant of SARS-CoV-2 (Pango lineage)
* **Measure Values** (float): Measure value (weighted proportion)
  corresponding to the measure name in the first column, ranges
  between 0 and 1.
* **Total Sequences** (int): Total number of sequences corresponding to
  this jurisdiction
