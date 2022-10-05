#!/usr/bin/env awk


function roundCorrect(val) {
    val = val + 0.5
    return val
}


# BEGIN {
#     FS=","
#     OFS="\t"
#     print "\n---- Mobiltelefoner i lager ----\n"
#     # print "#\tTillverkare\tModell\tPris\n"
#     printf("%s\t%-15s\t%-15s\t%-10s\t%-10s\t%s\n", "#", "Tillverkare", "Modell", "Antal", "Pris st", "Totalt pris")
#     total = 0
# }

# NR==1 { next }
# {
#     # print NR-1":",$1,$2,int($3/8.31)
#     current = dollar*$4
#     total += current
#     printf("%d\t%-15s\t%-15s\t%-10s\t%-10s\t%s\n", NR-1":",$1,$2,$4"st","$"dollar,"$"current)
# }

# END {
#     print "\nTotal summa: $"total
#     print "\n---- Slut på utskrift ----\n"
# }

BEGIN {
    FS=","
    OFS="\t"
    print "\nMärke\tModell\t\tI lager\n"
}
NR==1 { next }
{
    if ($4 > 10) {
        print $1,$2,$4
    }
}
