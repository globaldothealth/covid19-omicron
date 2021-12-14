name=uk-ltla
description="Omicron cases by UK LTLA merged with case counts from the UK coronavirus API"
sources="https://khub.net/documents/135939561/405676950/Confirmed+Omicron+cases+SGTF+LTLA+2021-12-08.xlsx/8003737a-cfc5-a320-2b55-794495cdbb09  ltla_sgtf.xlsx
https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=newCasesBySpecimenDate&format=csv ltla_daily_cases.csv"
depends="python3"  # see requirements.txt in toplevel for python specific packages

build() {
    python3 merge_sgtf_daily_geocodes.py
}
