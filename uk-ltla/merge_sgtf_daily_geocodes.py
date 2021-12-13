import sys
import pandas as pd

DAILY_LTLA_FILE = "ltla_daily_cases.csv"
SGTF_FILE = "ltla_sgtf.xlsx"
GEOCODE_LOOKUP_FILE = (
    "Local_Authority_Districts_(December_2017)_Boundaries_in_Great_Britain.csv"
)
OUTPUT = "uk-ltla.csv"

MERGE_ERROR_MSG = """
Error: Merge happened incorrectly

The newCasesBySpecimenDate column is empty.
One of the reasons merge could have resulted in an empty column
is setting the incorrect parameter in resample(), try setting
the weekly resampling for a different day of the week."""


def area_weekly_cases(group):
    area_name, area_df = group
    df = area_df["newCasesBySpecimenDate"].resample("W-MON").agg("sum").reset_index()
    df["areaName"] = area_name
    return df


def get_weekly_ltla_cases(filename):
    df = pd.read_csv(filename)
    df["date"] = pd.to_datetime(df["date"])
    df = pd.concat(map(area_weekly_cases, df.set_index("date").groupby("areaName")))
    return df


def read_ltla_sgtf(filename):
    df = pd.read_excel(filename, sheet_name=1).rename(
        columns={"LTLA": "areaName", "Specimen_Week": "date"}
    )
    return df


def read_geocode_lookup(filename):
    keep_columns = ["lad17nm", "long", "lat"]
    return pd.read_csv(GEOCODE_LOOKUP_FILE)[keep_columns].rename(
        columns={"lad17nm": "areaName"}
    )


# read sources
weekly_df = get_weekly_ltla_cases(DAILY_LTLA_FILE)
weekly_sgtf_df = read_ltla_sgtf(SGTF_FILE)

# merge weekly SGTF data with aggregated weekly case data
merged = weekly_sgtf_df.merge(weekly_df, on=["areaName", "date"], how="left")

# merge geocodes
merged = merged.merge(
    read_geocode_lookup(GEOCODE_LOOKUP_FILE), on="areaName", how="left"
)

# sanity check
if len(merged[pd.notnull(merged.newCasesBySpecimenDate)]) == 0:
    print(merged)
    print(MERGE_ERROR_MSG)
    sys.exit(1)
merged.to_csv(OUTPUT, index=False)
