# Merge all the gvcf files and index
bcftools merge -l gvcf.files -Oz -o merge.gvcf.gz
tabix merge.gvcf.gz

# Extract genotype of key SNP of Sa locus
vcftools --gzvcf merge.gvcf.gz --extract-FORMAT-info GT --positions SNP.position --keep Species.txt --out SNP.GT

# Extract Depth information of Sa locus
vcftools --gzvcf merge.gvcf.gz --extract-FORMAT-info DP --chr 1 --from-bp 22375575 --to-bp 22386532 --keep Species.txt --out Sa.DP

# Calculate depth  of Sa locus
python3 03. countDP.py
