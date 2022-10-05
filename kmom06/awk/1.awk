BEGIN {
    FS=","
    OFS="\t"
    print "\n"
    printf("%-15s\t%-15s\t%-30s\t%-15s\t%-15s\t%-15s\n","Förnamn",
    "Efternamn",
    "Stad",
    "Född",
    "Telefon",
    "Mail")
    print "\n"

}

NR==1 { next }
{
    printf("%-15s\t%-15s\t%-30s\t%-15s\t%-15s\t%-15s\n", $1,$2,$3,$4,$5,$6)
}

END {
    print "\n---- Slut på utskrift ----\n"
}