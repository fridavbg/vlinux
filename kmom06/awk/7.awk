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
        split($4, items, "-");
        data[items[1]]++
    }
}

END {
    for (item in data) {
        printf "%s\t%s\n", item, data[item]
    }
}