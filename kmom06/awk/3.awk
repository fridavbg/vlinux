#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
}

{ 
if(NR >= 508 && NR <= 516)
    printf("%s %s, %s\n", $1,$2,$3)
}

END {
    print "\n---- Slut på utskrift ----\n"
}