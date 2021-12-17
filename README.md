# Omicron datasets

This repository contains datasets on reported cases of the SARS-CoV-2 Omicron
(B.1.1.529) Variant of Concern.

NOTE: Please check data licenses from the original sources before using these data.

## Datasets

* **[austria](austria)**: Austrian Agency for Health and Food Safety dataset
  on variant numbers (counts)
* **[denmark](denmark)**: Statens Serum Institut dataset on daily
  Omicron cases in Denmark (counts)
* **[europe](europe)**: ECDC dataset on variants (counts)
* **[travel](travel)**: Global, curated dataset of Omicron genomes with
  information on travel history (individual, geocoded)
* **[uk-ltla](uk-ltla)**: Omicron cases by UK LTLA geocoded and merged
  with case counts obtained from the UK coronavirus dashboard API
  (counts, geocoded)
* **[usa](usa)**: USA CDC dataset on estimated weighted proportions
  of variants by jurisdiction (proportions, aggregated)

Usually, the data files are named as `<folder>.csv` within the
respective folder.

Direct links to data files:

```
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/austria/austria.csv
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/denmark/denmark.csv
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/europe/europe.csv
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/travel/travel.csv
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/uk-ltla/uk-ltla.csv
https://raw.githubusercontent.com/globaldothealth/covid19-omicron/main/usa/usa.csv
```

For data dictionaries, refer to the respective folders.

Each dataset folder has a `last_updated.txt` file which stores the
timestamp of the last time the file was updated. This is redundant if
you are doing a git clone, as git stores timestamps already, but is
useful for the zip download of this repository, or direct linking.

## Building the datasets yourself

The repository does not host the source files. The
[`build.sh`](build.sh) script uses BUILD files in the respective dataset
folders to build the dataset. See `./build.sh -h` for help.

To build the datasets, you need:

* A **UNIX** based system or virtual machine, such as Linux (with bash
  installed) or macOS.
* **Python** 3.9 or later and the packages in
  [requirements.txt](requirements.txt). If you have pip installed,
  then you can use

      pip install -r requirements.txt

* **curl** a download manager, pre-installed with most Linux
  distributions and macOS.

Once these are present (check dataset specific requirements), run at
a terminal

    ./build.sh -f FOLDER

where FOLDER is the dataset you want to build. This will create the
output file in the folder.

Normally, build only fetches sources the first time, or if it finds no source
files are present. After the initial build, you can use the -u flag to update
the source files (pass -U to only fetch the sources and not build).

### Dataset specific requirements

The **denmark** dataset requires Java 8 or later installed, this is via
the dependency on
[tabula-java](https://github.com/tabulapdf/tabula-java). You do not need
to install tabula, it will be downloaded in the build process.

### BUILD file

The build script uses BUILD files in the dataset folders to setup, download sources, build the dataset and update timestamps. BUILD uses shell (bash) syntax, which is for the most part, variable assignments to special variables that are used by the build script:

```bash
# name of the dataset, no spaces (required)
name=your-dataset-name

# source files that are required to build the dataset (required)
# format of this variable is a set of lines in the form
#  url filename
# which will result in url being saved to filename
sources="http://foo.bar/a.csv file.csv
http://bar.baz/g.xlsx  some_other_name.xlsx"

# one line description of the dataset
description="A very useful dataset"

# command line tools that should be present before running build
# NOTE: for Python and R, the build script does not automatically install
#       packages, you can specify those in the README or in the usual
#       manner for your programming language, such as providing a
#       requirements.txt for Python.
depends="python3"

# output dataset file(s)
# if not specified, defaults to name.csv
# output="file1.csv file2.csv ..."

# setup() is called before build and can be used to download
# dependencies or to install packages
# setup() {
# }

# build script to make the dataset (required)
build() {
    python3 code.py
}

# unit tests to run (optional)
# tests() {
#     python3 test_script.py
# }
```

