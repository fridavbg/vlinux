#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    print "\n"
    printf("%-15s\t%-15s\t%-20s\t%-15s\t%-15s\t%-15s\n","Förnamn",
    "Efternamn",
    "Stad",
    "Född",
    "Telefon",
    "Mail")
    print "--------------------------------------------"
}

{ 
if(NR >= 507 && NR <= 515)
    printf( "%-15s\t%-15s\t%-20s\t%-15s\t%-15s\t%-15s\n", $1,$2,$3,$4,$5,$6)
}

END {
    print "\n---- Slut på utskrift ----\n"
}