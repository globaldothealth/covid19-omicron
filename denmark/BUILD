name=denmark
description="Statens Serum Institut dataset on daily Omicron cases in Denmark"
sources="https://files.ssi.dk/covid19/omikron/statusrapport/rapport-omikronvarianten-11122021-uy12	file.pdf"
tabula_source="https://github.com/tabulapdf/tabula-java/releases/download/v1.0.5/tabula-1.0.5-jar-with-dependencies.jar"
depends="java"

setup() {
    test ! -f tabula.jar && curl -L "$tabula_source" -o tabula.jar
    check_hashes sha256sums.tabula.txt
}

build() {
    # table header
    echo -e "date,cases,omicron_cases,omicron_percent" > "$output"
    # drop footnotes on third page
    # tabula is confused by the commas, so output to TSV and convert
    java -jar tabula.jar -p 3 file.pdf --format TSV -a %0,0,80,80 | \
    # cut off header
        tail -n +6 | \
    # remove lines upto 19 cases (marks start of table)
    # remove lines with Data pending
    # remove commas in numbers
        sed '1,/^19 cases/d;/Data pending/d;s/,//g;s/ /,/g;s/\t/,/g' | \
    # cut off footer
        head -n -2 >> "$output"
}
