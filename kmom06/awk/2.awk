#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    print "\n"
}

NR>101 { next }
{ 
    printf( NR-1 ":  %-15s\t%-15s\t%-30s\t%-15s\t%-15s\t%-15s\n", $1,$2,$3,$4,$5,$6)
}

END {
    print "\n---- Slut på utskrift ----\n"
}