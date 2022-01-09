name=denmark
description="Statens Serum Institut dataset on daily Omicron cases in Denmark"
sources="https://files.ssi.dk/covid19/podepind-sekventering/variant-pcr-test-december2021/opgoerelse-variantpcr-covid19-09012022-u8r1  file.pdf"
tabula_source="https://github.com/tabulapdf/tabula-java/releases/download/v1.0.5/tabula-1.0.5-jar-with-dependencies.jar"
depends="java"

setup() {
    test ! -f tabula.jar && curl -L "$tabula_source" -o tabula.jar
    check_hashes sha256sums.tabula.txt
}

data_page() {
    local page
    page="${1:-1}"
    # tabula is confused by the commas, so output to TSV and convert
    java -jar tabula.jar file.pdf --format TSV  --pages=$page | \
    # remove lines upto proevedato (marks start of table)
    # replace month names with numbers
    sed '1,/^proevedato/d
    s/[[:space:]]*$//g  # remove trailing whitespace
    s/ /,/g  # change back from space/tab separated
    s/\t/,/g
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
    s/,\./,/g  # remove pending .
    '
}


build() {
    # table header
    echo -e "date,total_positive_pcr,positive_pcr,other_variants,inconclusive,confirmed_omicron,omicron_percent" > "$output"
    data_page 1 >> "$output"
    data_page 2 >> "$output"
}
