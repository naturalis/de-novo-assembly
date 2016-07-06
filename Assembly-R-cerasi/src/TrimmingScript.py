#!/usr/bin/python

""" 
Dit script trimt alle reads in de meegegeven files. Dit script is gemaakt voor paired end reads in fastq.
Ook is het script voor Illumina reads.

Er moeten twee argumenten mee gegeven worden aan het script.
Dit zijn de twee files die getrimt moeten worden.

Trimmen:

Alle reads met een gemiddelde kwaliteit lager dan 25 worden weg gegooit.
Dit omdat deze reads te onzeker zijn om mee te nemen.

Daarna worden de voor en achterkant van de reads bekeken.
Wanneer een base een lagere kwaliteit heeft dan 25 wordt deze base weg gegooit.
Als er een base komt met een hogere kwaliteit wordt er gekeken of de hogere
kwaliteit aan houdt voor 3 basen. Wanneer dit zo is stopt het trimmen aan die kant.
De read wordt omgedraait om ook aan die kant te trimmen.

Als laatste wordt er naar de lengte gekeken van de getrimde reads.
Wanneer deze lager is dan 30 worden de reads weg gegooid omdat ze te klein zijn.

Het script wordt als volgt aangeroepen:

python TrimmenScriptSER.py sequentiefile1.txt sequentiefile2.txt
"""


import os
import sys

def showUsageInformation():
        print() 
        print("Dit script trimt alle reads in de meegegeven files.")
        print("Dit script is gemaakt voor paired end reads in fastq.")
        print()
        print("Er moeten twee argumenten mee gegeven worden aan het script.")
        print("Dit zijn de twee files die getrimt moeten worden.")
        print()
        print("Het script wordt als volgt aangeroepen:")
        print() 
        print("python TrimmenScriptSER.py sequentiefile1.txt sequentiefile2.txt")
        sys.exit()

def Trimmen_1(line):
    """
    Deze functie berekent de gemiddelde kwaliteit van de read.
    De kwaliteit van een sequentie wordt gegeven aan de functie.
    Er wordt gereturned of desequentie weg moet of niet.
    """
    trimmed = line
    totaal = 0
    weg = False
    if line == "":
        return True
    for ch in trimmed:
        totaal += (ord(ch) -33)
        gem = totaal / len(trimmed)
    if gem < 25:
        weg = True
    return weg

def WegGooien(line, weg):
    """ 
    Wanneer de sequentie weg moet omdat de gemiddelde lengte lager is dan 25,
    maakt deze functie de sequentie leeg. Wanneer de sequentie niet weg moet
    gebeurd er niks mee.
    De sequentie wordt gereturned.
    """
    if weg == True:
        line = ""
    return line

def Trimmen_2(trim_1):
    """ 
    Deze funtctie haalt aan het begin van de kwaliteitsequentie basen weg totdat
    de kwaliteit hoger is dan 25 voor drie basen lang.
    Als er getrimt is wordt de nieuwe sequentie en de hoeveelheid basen die
    weggehaalt zijn gereturned.
    Anders wordt de originele gereturned samen met de index van 0.
    """
    trimt = ""
    score = 0
    count = 0
    for ch in trim_1:
        count += 1
        if (ord(ch) -33) <= 25:
            score = 0
        elif (ord(ch) -33) >= 26:
            score += 1
            pass
        if score >= 3:
            trimt = WegGooien_2(trim_1, count)
            break
    if len(trimt) != 0:
        index = len(trim_1) - len(trimt)
        return trimt, index
    else:
        return trim_1, 0
        

def WegGooien_2(trim_1, count):
    """
    Deze functie krijgt de index en de sequentie mee gegeven en zorgt
    vervolgens dat deze overeen komt en haalt de juiste hoeveelheid basen weg.
    """
    item_2 = ""
    item_2 = trim_1[count-3:len(trim_1)]
    return item_2

def Reverse(trim_2):
    """
    Deze functie keert de sequentie om.
    Deze wordt vervolgens gereturned.
    """
    r_trim_2 = trim_2[::-1]
    return r_trim_2

def Trimmen_3(trim_2_2):
    """
    Deze functie kijkt of de lengte van de read groter is dan 30 .
    Wanneer dit niet zo is wordt de read als leeg gereturned.
    Anders wordt er niks met de read gedaan.
    """
    if len(trim_2_2) < 30:
        return ""
    else:
        return trim_2_2
                
def main(argv):
    """ 
    De main roept ale fncties aan in het script.

    Eerst wordt gekeken of de Usage Information wordt aangeroepen.

    Daarna worden de juiste file geopent en/of gemaakt.
    Daarna wordt er per read alles gedaan door steeds een read uit de file te halen.
    Dan wordt er getrimt volgens de volgorde die hierboven is aangegeven.
    Na het trimmen wordt van de reads met een lege kwaliteitsequentie de header
    weg geschreven naar een aparte file "verwijderen". De goede reads worden in
    geheel opgeslagen in een lijst..

    Daarna wordt hetzelfde met file twe gedaan op een ding na.
    Eerst wordt gekeken of de header van de read in de file "verwijderen" staat.
    Als dit zo is wordt er niks met de read gedaan en komt deze read ook niet
    in de uiteindelijke file. Na het trimmen worden de goede reads weggeshreven
    naar een file.

    Na het trimmen van file 2 wordt er in de lijst van sequenties uit file 1 gekeken
    naar nieuwe overeenkomende headers in "verwijderen". Als de headers niet
    overeen komen kan de read weggescreven worden naar een andere file.
    """
    if len(argv) >= 2:
        if argv[1] == "-h" or argv[1] == "--h" or argv[1] == "-help" or argv[1] == "--help":
            showUsageInformation()

    userfile = sys.argv[1]
    userfile2 = sys.argv[2]
    newfile = sys.argv[3]
    newfile2 = sys.argv[4]
    verwijderen = open('verwijderen.txt', 'w+').close()
    niuew = open(newfile, 'w+').close()
    niuew2 = open(newfile2, 'w+').close()
    seq_list = []
    line_count = 0
    line_count2 = 0
    count = 0
    count2 = 0 
    with open(userfile, 'r') as f:
        for line in f:
            count += 1
            if count % 4000000 == 0:
                print (count)
            line_count += 1
            if line_count == 1:
                header = line
            elif line_count == 2:
                seq = line
            elif line_count == 3:
                header_2 = line
            else:
                line_count = 0
                weg = Trimmen_1(line)
                trim_1 = WegGooien(line ,weg)
                trim_2, index_1 = Trimmen_2(trim_1)
                r_trim_2 = Reverse(trim_2)
                r_trim_2_2, index_2 = Trimmen_2(r_trim_2)
                trim_2_2 = Reverse(r_trim_2_2)
                trim_3 = Trimmen_3(trim_2_2)
                if len(trim_3) != 0:
                    seq_list.append(header[:-1])
                    seq_list.append(seq[index_1:len(seq)-index_2]+'\n')
                    seq_list.append(header_2)
                    seq_list.append(trim_3+'\n')
                else:
                    verwijderen = open('verwijderen.txt', 'a+')
                    verwijderen.write("\n"+header.split()[0])
                    verwijderen.closed
    verwijderen = open('verwijderen.txt', 'a+')
    verwijderen.write("\n einde file 1.")
    verwijderen.closed
    print ("beginnen aan file 2.")
    with open('verwijderen.txt') as v:
        ver = v.read().splitlines()
    sver = set(ver)
    with open(userfile2 , 'r') as f2:
        for line in f2:
            count2 += 1
            if count2 % 4000000 == 0:
                print (count2)
            line_count2 += 1
            if line_count2 == 1:
                header2 = line
            elif line_count2 == 2:
                seq2= line
            elif line_count2 == 3:
                header_22 = line
            else:
                line_count2 = 0
                if header2.split()[0] in sver:
                    line = ""
                weg2 = Trimmen_1(line)
                trim_12 = WegGooien(line ,weg2)
                trim_22, index_12 = Trimmen_2(trim_12)
                r_trim_22 = Reverse(trim_22)
                r_trim_2_22, index_22 = Trimmen_2(r_trim_22)
                trim_2_22 = Reverse(r_trim_2_22)
                trim_32 = Trimmen_3(trim_2_22)
                if len(trim_32) != 0:
                    nieuw = open(newfile2, 'a+')
                    nieuw.write(header2)
                    nieuw.write(seq2[index_12:len(seq2)-index_22]+"\n")
                    nieuw.write(header_22)
                    nieuw.write(trim_32+'\n')
                    nieuw.closed
                else:
                    verwijderen = open('verwijderen.txt', 'a+')
                    verwijderen.write("\n"+header2.split()[0])
                    verwijderen.closed
    verwijderen = open('verwijderen.txt', 'a+')
    verwijderen.write("\n einde file 2.")
    verwijderen.closed
    print("Klaar met file 2. File 1 en 2 gelijk maken.")
    with open('verwijderen.txt') as v2:
        ver2 = v2.read().splitlines()
    sver2 = set(ver2)
    seq_list = map(str.strip, seq_list)
    nieuw2 = open(newfile, 'a+')
    weg_count = 0
    for seq3 in seq_list:
        if weg_count == 0:
            if seq3.split()[0] in sver2 and seq3 != "+":
                weg_count = 1
            else:
                nieuw2.write(seq3+'\n')
        elif weg_count > 0 and weg_count < 3:
            weg_count += 1
        elif weg_count == 3:
            weg_count = 0
    nieuw2.closed

    
        

                                                            
if __name__ == "__main__":
        main(sys.argv)
        

# Additional information:
# =======================
#
# Remarks about the Skeleton Script Python itself.
# Description how it works.
# Description which improvements can be done to improve the Skeleton Script Python itself.
#

