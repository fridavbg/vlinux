#!/usr/bin/env awk

BEGIN {
    FS=","
    OFS="\t"
    print "\n"
    printf("%-15s\t%-15s\t%-15s\n",
    "Förnamn",
    "Efternamn",
    "Telefonnummer")
    print "--------------------------------------------"
}

{ 
if(NR >1)
    printf( "%-15s\t%-15s\t%-15s\n", $1,$2,$5)
}

END {
    print "------------------------------------------"
}