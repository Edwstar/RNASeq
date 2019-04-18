# The output from Hisat2 mapping is .sam file, needed to be converted to .bam file
# This is for SAMtools version 1.2.1 or the older ones

# Convert SAM files to binary BAM files:
for((i=1; i<=10; i++))
do
samtools view -bS /anomegap/edward/Edw_hisat2/hisat2_output/hisat2sample${i}.sam > /anomegap/edward/Edw_hisat2/samtoolstobam/unsortedBam/hisat2sample${i}_unsorted.bam
done

# Sorted the BAM files:
for((i=1; i<=10; i++))
do
samtools sort -@ 7 /anomegap/edward/Edw_hisat2/samtoolstobam/unsortedBam/hisat2sample${i}_unsorted.bam /anomegap/edward/Edw_hisat2/samtoolstobam/sorted/hisat2sample${i}_sorted
done