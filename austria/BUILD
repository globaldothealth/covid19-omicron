name=austria
description="Austrian Agency for Health and Food Safety dataset on variant numbers"
sources="https://www.ages.at/fileadmin/AGES2015/Themen/Krankheitserreger_Dateien/Coronavirus/Varianten_ab_Mai/Varianten_nach_KWs_2022-01-21.csv  data.csv"

build() {
    echo year_week,alpha,beta,gamma,delta,omicron,total > "$output"
    tail -n +2 data.csv | sed 's/;/,/g' >> "$output"
}

