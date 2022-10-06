#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    printf"%s\t%s\n%s\n",
    "Årtal",
    "Antal", 
    "-------------"
}

{ 
    if (NR > 1)
    {
        split($4, years, "-");
        data[years[1]]++
    }
}

END {
    for (year in data) {
        printf "%s\t%s\n", year, data[year]
    }
}