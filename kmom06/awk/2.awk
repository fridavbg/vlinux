#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    print "\n"
}

{
    if(NR > 1 && NR <= 101)
    printf("2%s %s, %s\n", $1,$2,$3)
}

END {
    print "\n---- Slut på utskrift ----\n"
}