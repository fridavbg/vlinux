#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    print "\n"
    printf("%-15s\t%-15s\t%20s\n","Förnamn",
    "Efternamn",
    "Stad")
    print "--------------------------------------------"
}

{ 
if(NR > 1 && $3  ~ /stad/ && $4 ~ /(-01-)|(-10-)/)
    printf( "%-15s\t%-15s\t%20s\n", $1,$2,$3)
}

END {
    print "\n---- Slut på utskrift ----\n"
}