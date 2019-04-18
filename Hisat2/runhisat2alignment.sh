# Run hisat2, align the RNA-seq reads to the genome
# Run multiple sample
# NOTE:the end of -x command is not the folder pathway, it's the name of .ht file!

for((i=1; i<=10; i++))
do
/anomegap/edward/Edw_hisat2/installation/hisat2-2.1.0/hisat2 -p 7 --dta -x /anomegap/edward/Edw_hisat2/hisat2index/mm10/genome -1 /anomegap/edward/RNASeq_project/fastq/sample${i}/sample${i}_r1.fq.gz -2 /anomegap/edward/RNASeq_project/fastq/sample${i}/sample${i}_r2.fq.gz -S /anomegap/edward/Edw_hisat2/hisat2_output/hisat2sample${i}.sam
done