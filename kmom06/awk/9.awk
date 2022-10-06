#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    nintiesKids = 0
}

NR==1 { next }
{
    split($4, date, "-");
    days = date[3]
    if (match($5, date[3]))
    {
        if(date[1] < 2000) {
            nintiesKids++
        }
        printf("%s %s, %s, %s\n", $1,$2, $4, $5)
    }
}

END {
    print "\n"
    print nintiesKids " stycken är födda innan år 2000."
    print "--------------"
}