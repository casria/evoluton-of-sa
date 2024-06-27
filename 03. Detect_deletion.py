from decimal import Decimal

# Open the file for writing and write the header
with open('del.txt', 'a') as x:
    x.write('sra' + '\t' + 'F_del' + '\t' + 'M_del' + '\t' + 'Mm_del' + '\t' + 'Fl_del' + '\n')

    for name in open('data_info.txt', 'r'):
        # Write the name to the file
        x.write(name.strip() + '\t')

        # Initialize variables to keep track of deletions for different categories
        F_del = 0
        M_del = 0
        Mm_del = 0
        Fl_del = 0

        for line in open(name.strip(), 'r+'):
            if '#' not in line and 'Sa' in line:
                line = line.strip().split('\t')
                start = line[1]
                end = line[7].replace('END=', '')
                # Calculate deletion, '0/0:0:0:0:0,0,0' means the unmapping region 
                # SaF start from 5576 to 7308, SaM start from 9144 to 12936, the deletion part in SaM start from 11677 to 12597, SaFL start from 15214 to 16533
                if str(line[-1]) == '0/0:0:0:0:0,0,0':
                    #print(line)
                    if  Decimal(start)<=5576 and Decimal(end)>=7308:
                        F_del=F_del+Decimal(7308-5576)
                    if Decimal(start)<=5576 and 5576<Decimal(end)<7308:
                        F_del=F_del+Decimal(end)-5576
                    if 5576<Decimal(start)<7308:
                        if Decimal(end)>=7308:
                            F_del=F_del+(7308-Decimal(start))
                        if Decimal(end)<7308:
                            F_del=F_del+Decimal(end)-Decimal(start)
                    if  Decimal(start)<=9144 and Decimal(end)>=12936:
                        M_del=M_del+Decimal(12936-9144)
                    if Decimal(start)<=9144 and 9144<Decimal(end)<12936:
                        M_del=M_del+Decimal(end)-9144
                    if 9144<Decimal(start)<12936:
                        if Decimal(end)>=12936:
                            M_del=M_del+(12936-Decimal(start))
                        if Decimal(end)<12936:
                            M_del=M_del+Decimal(end)-Decimal(start)
                    if  Decimal(start)<=11677 and Decimal(end)>=12597:
                        Mm_del=Mm_del+Decimal(12597-11677)
                    if Decimal(start)<=11677 and 11677<Decimal(end)<12597:
                        Mm_del=Mm_del+Decimal(end)-11677
                    if 11677<Decimal(start)<12597:
                        if Decimal(end)>=12597:
                            Mm_del=Mm_del+(12597-Decimal(start))
                        if Decimal(end)<12597:
                            Mm_del=Mm_del+Decimal(end)-Decimal(start)
                    if  Decimal(start)<=15214 and Decimal(end)>=16533:
                        Fl_del=Fl_del+Decimal(16533-15214)
                    if Decimal(start)<=15214 and 15214<Decimal(end)<16533:
                        Fl_del=Fl_del+Decimal(end)-15214
                    if 15214<Decimal(start)<16533:
                        if Decimal(end)>=16533:
                            Fl_del=Fl_del+(16533-Decimal(start))
                        if Decimal(end)<16533:
                            Fl_del=Fl_del+Decimal(end)-Decimal(start)
        # Write the calculated deletion lengths to the file
        x.write(str(F_del)+'\t'+str(M_del)+'\t'+str(Mm_del)+'\t'+str(Fl_del)+'\n')