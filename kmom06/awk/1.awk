#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
}

NR==1 { next }
{
    printf("%-15s\t%-15s\n", $1,$2)
}

END {
    print "\n---- Slut på utskrift ----\n"
}