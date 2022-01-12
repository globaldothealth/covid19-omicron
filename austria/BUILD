name=austria
description="Austrian Agency for Health and Food Safety dataset on variant numbers"
sources="https://www.ages.at/fileadmin/AGES2015/Themen/Krankheitserreger_Dateien/Coronavirus/Varianten_ab_Mai/Varianten_nach_KWs_2022-01-10.csv  data.csv"

week_number_to_date() {
    IFS='-' read -r year week_number <<< "$1"
    week_jan1=$(date -d "$year-01-01" +'%W')
    weekday_jan1=$(date -d "$year-01-01" +'%u')
    unix_jan1=$(date -d "$year-01-01" +'%s')
    week_number=${week_number/W/}
    # find first monday and shift weeks
    date -I -d@$(($unix_jan1 +
       (8 - $weekday_jan1) * 86400 +
       ($week_number - 1) * 7 * 86400))
}

build() {
    echo year_week,date,alpha,beta,gamma,delta,omicron,total > "$output"
    head -n -1 data.csv | \
        tail -n +2 | \
        while IFS=';' read -r year_week alpha beta gamma delta omicron total; do
            echo "$year_week,$(week_number_to_date $year_week),$alpha,$beta,$gamma,$delta,$omicron,$total" >> "$output"
        done
}

