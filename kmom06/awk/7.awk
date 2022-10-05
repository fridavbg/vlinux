#!/usr/bin/env awk

function getYear(year) {
    arr["year"] = year
    split(year, date, "-");
    return date[1]
}



BEGIN {
    FS=","
    OFS="\t"
    print "\n"
    printf("%-15s%-15s\n",
    "Årtal",
    "Antal")
    print "--------------------------------------------"
}

NR==1 { next }
{ 
    year = int($4)
    years = getYear($4)
    printf("%-15s%-15s\n", years, antal)
}

END {
    print "\n---- Slut på utskrift ----\n"
}