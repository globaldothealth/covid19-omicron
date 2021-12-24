name=austria
description="Austrian Agency for Health and Food Safety dataset on variant numbers"
sources="https://www.ages.at/fileadmin/AGES2015/Themen/Krankheitserreger_Dateien/Coronavirus/Varianten_ab_Mai/Varianten_nach_KWs_2021-12-23.csv  data.csv"

year=2021
week_jan1=$(date -d "$year-01-01" +'%W')
weekday_jan1=$(date -d "$year-01-01" +'%u')
unix_jan1=$(date -d "$year-01-01" +'%s')

week_number_to_date() {
    year=$1
    week_number=$2
    # find first monday and shift weeks
    date -I -d@$(($unix_jan1 +
       (8 - $weekday_jan1) * 86400 +
       ($week_number - 1) * 7 * 86400))
}

build() {
    echo week,date,alpha,beta,gamma,delta,omicron,total > "$output"
    head -n -1 data.csv | \
        tail -n +2 | \
        while IFS=';' read -r week alpha beta gamma delta omicron total; do
            week=${week//\"/}
            echo "$week,$(week_number_to_date 2021 $week),$alpha,$beta,$gamma,$delta,$omicron,$total" >> "$output"
        done
}

