#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
}

NR==1 { next }
{
    split($4, date, "-");
    days = date[3]
    if (match($5, date[3]))
    {
        printf("%s %s, %s, %s\n", $1,$2, $4, $5)
    }
}

END {
    print "--------------"
}