# Repeatly run featureCounts 1-10 samples

for((i=1; i<=10; i=i+1))
do
/anomegap2/users/steven/subread-1.6.3-Linux-x86_64/bin/featureCounts -s 0 -p -T 4 -F GTF -a /anomegap/edward/script_test/genome/gtf/genes.gtf -o /anomegap/edward/Hisat2-featureCounts-deseq2/hisat2-featureCounts_output/hisat2featureCounts_sample${i} /anomegap/edward/Edw_hisat2/samtoolstobam/sorted/hisat2sample${i}_sorted.bam
done