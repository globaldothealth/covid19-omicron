name=denmark
description="Statens Serum Institut dataset on daily Omicron cases in Denmark"
sources="https://files.ssi.dk/covid19/podepind-sekventering/variant-pcr-test-december2021/opgoerelse-variantpcr-covid19-15122021-34fe  file.pdf"
tabula_source="https://github.com/tabulapdf/tabula-java/releases/download/v1.0.5/tabula-1.0.5-jar-with-dependencies.jar"
depends="java"

setup() {
    test ! -f tabula.jar && curl -L "$tabula_source" -o tabula.jar
    check_hashes sha256sums.tabula.txt
}

build() {
    # table header
    echo -e "date,positive_pcr,confirmed_omicron,inconclusive,other_variants,omicron_percent" > "$output"
    # tabula is confused by the commas, so output to TSV and convert
    java -jar tabula.jar file.pdf --format TSV | \
    # remove lines upto Prøvedato (marks start of table)
    # replace month names with numbers
    sed '1,/^Prøvedato/d
    s/\.//g  # remove pending .
    s/,/./g  # commas in floats -> period
    s/ /,/g  # change back from space separated
    s/JAN/-01-/g
    s/FEB/-02-/g
    s/MAR/-03-/g
    s/APR/-04-/g
    s/MAY/-05-/g
    s/JUN/-06-/g
    s/JUL/-07-/g
    s/AUG/-08-/g
    s/SEP/-09-/g
    s/OCT/-10-/g
    s/NOV/-11-/g
    s/DEC/-12-/g
    ' >> "$output"
}
