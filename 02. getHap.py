from decimal import Decimal
# Iterate over each line in 'data_info.txt' file, the file contains the name of the gvcf file generated in the previous section
for i in open('data_info.txt', 'r'):
    # Append key SNPs information of Sa to the 'hap.txt' file
    with open('hap.txt', 'a') as f:
        # Write the gvcf file name to the file
        f.write(i.strip() + '\n')
        for n in open(i.strip(), 'r'):
            if 'Sa' in n and 'GT' in n:
                set = n.strip().split('\t')
                # The key snp information is at the 6435(SaF), 11236(SaM), 16182(SaFL), 16183(SaFL), 16316(SaFL) position of ref.fa
                if set[1] == '6435':
                    f.write('6435' + '\t' + set[3] + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
                else:
                    if 'END' in n:
                        end = set[7].replace('END=', '')
                        if int(set[1]) < int(6435) <= int(end):
                            f.write('6435' + '\t' + 'C' + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
							
                if set[1] == '11236':
                    f.write('11236' + '\t' + set[3] + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
                else:
                    if 'END' in n:
                        end = set[7].replace('END=', '')
                        if int(set[1]) < int(11236) <= int(end):
                            f.write('11236' + '\t' + 'T' + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
							
                if set[1] == '16182':
                    f.write('16182' + '\t' + set[3] + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
                else:
                    if 'END' in n:
                        end = set[7].replace('END=', '')
                        if int(set[1]) < int(16182) <= int(end):
                            f.write('16182' + '\t' + 'G' + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')

                if set[1] == '16183':
                    f.write('16183' + '\t' + set[3] + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
                else:
                    if 'END' in n:
                        end = set[7].replace('END=', '')
                        if int(set[1]) < int(16183) <= int(end):
                            f.write('16183' + '\t' + 'C' + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')

                if set[1] == '16316':
                    f.write('16316' + '\t' + set[3] + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')
                else:
                    if 'END' in n:
                        end = set[7].replace('END=', '')
                        if int(set[1]) < int(16316) <= int(end):
                            f.write('16316' + '\t' + 'C' + '\t' + set[4] + '\t' + set[8] + '\t' + set[9] + '\n')

with open('hap.txt', 'r') as m:
    # Read all lines of the file
    s = m.readlines()
    # Open the file 'haplotype.csv' in append mode
    with open('haplotype.csv', 'a') as a:
        # Iterate through each line in the file
        for b in s:
            if 'gvcf' in b:
                # Write sample name to 'haplotype.csv'
                a.write(b.strip() + ',')
            else:
                c = b.strip().split('\t')
                format = c[4].strip().split(':')
                if Decimal(c[0]) == Decimal(6435):
                    if c[4] == str('0/0:0:0:0:0,0,0'):
                        a.write('null' + ',')
                    else:
                        if format[0] == str('0/1') or format[0] == str('0|1'):
                            a.write('+/-' + ',')
                        if format[0] == str('0/0'):
                            a.write('-' + ',')
                        if format[0] == str('1/1') or format[0] == str('1|1'):
                            a.write('+' + ',')
							
                    if c[4] == str('0/0:0:0:0:0,0,0'):
                        a.write('null' + ',')
                    else:
                        if format[0] == str('0/1') or format[0] == str('0|1'):
                            a.write('+/-' + ',')
                        if format[0] == str('0/0'):
                            a.write('-' + ',')
                        if format[0] == str('1/1') or format[0] == str('1|1'):
                            a.write('+' + ',')
                
                if Decimal(c[0]) == Decimal(16182):
                    if c[4] == str('0/0:0:0:0:0,0,0'):
                        a.write('null' + ',')
                    else:
                        if format[0] == str('0/1') or format[0] == str('0|1'):
                            a.write('+/-' + ',')
                        if format[0] == str('0/0'):
                            a.write('-' + ',')
                        if format[0] == str('1/1') or format[0] == str('1|1'):
                            a.write('+' + ',')
                
                if Decimal(c[0]) == Decimal(16183):
                    if c[4] == str('0/0:0:0:0:0,0,0'):
                        a.write('null' + ',')
                    else:
                        if format[0] == str('0/1') or format[0] == str('0|1'):
                            a.write('+/-' + ',')
                        if format[0] == str('0/0'):
                            a.write('-' + ',')
                        if format[0] == str('1/1') or format[0] == str('1|1'):
                            a.write('+' + ',')
							
                if Decimal(c[0]) == Decimal(16316):
                    if c[4] == str('0/0:0:0:0:0,0,0'):
                        a.write('null' + ',' + '\n')
                    else:
                        if format[0] == str('0/1') or format[0] == str('0|1'):
                            a.write('+/-' + ',' + '\n')
                        if format[0] == str('0/0'):
                            a.write('-' + ',' + '\n')
                        if format[0] == str('1/1') or format[0] == str('1|1'):
                            a.write('+' + ',' + '\n')