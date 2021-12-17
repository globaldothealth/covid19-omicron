# usa

USA CDC dataset on variants

The dataset is from:
https://covid.cdc.gov/covid-data-tracker/#variant-proportions

## Sources

* https://public.tableau.com/views/Variant_Proportions_Weekly/RegionsDashboard.csv?%3Adisplay_static_image=y&%3AbootstrapWhenNotified=true&%3Aembed=true&%3Alanguage=en-US&:embed=y&:showVizHome=n&:apiID=host0#navType=0&navSrc=Parse
  (saved at usa.csv)

## Data dictionary

All column types are strings unless stated otherwise.

* **Day of Week Ending** (date): Date in form Month day, year
* **Lineage Bin**: Lineage bin, one of *Other* or *VOC*
* **Modeltype**: One of *smoothed* or *weighted*
* **Usa Or Hhsregion**: One of *USA* or [HHS region number](https://www.hhs.gov/about/agencies/iea/regional-offices/index.html) (1 - 10)
* **Variant**: Variant of SARS-CoV-2 (Pango lineage)
* **95CI** (numeric range): 95% confidence interval of *Share* (low-high%)
* **Share** (float): Variant share (0 - 1)
