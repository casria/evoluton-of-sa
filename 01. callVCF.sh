# Get the current directory path
p=`pwd`

# Align and sort using bwa
bwa mem -t 20 -R '@RG\tID:foo\tPL:illumina\tSM:${sample}' $p/ref.fa $p/01.fq/${sample}_R1.fq.gz $p/01.fq/${sample}_R2.fq.gz | samtools sort -@ 20 -O bam -o $p/02.align/${sample}.sorted.bam

# Mark duplicates using gatk
gatk MarkDuplicates -I $p/02.align/${sample}.sorted.bam \
-O $p/02.align/${sample}.sorted.markdup.bam -REMOVE_SEQUENCING_DUPLICATES true -M $p/02.align/${sample}.sorted.markdup_metrics

# Create an index for the marked duplicates file
samtools index $p/02.align/${sample}.sorted.markdup.bam

# Perform variant calling for a single sample using gatk
gatk HaplotypeCaller -R $p/ref.fa --emit-ref-confidence GVCF \
-I $p/02.align/${sample}.sorted.markdup.bam \
-O $p/03.vcf/${sample}.gvcf

# Transform GVCF files into one VCF file
gatk GenotypeGVCFs -R $p/ref.fa \
-V $p/03.vcf/${sample}.gvcf \
-O $p/03.vcf/${sample}.vcf

# Remove intermediate files
rm $p/02.align/${sample}.sorted.bam $p/02.align/${sample}.sorted.markdup.bam