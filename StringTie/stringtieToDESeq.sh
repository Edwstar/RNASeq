#This script is to transform stringtie output for DESeq2 analysis

python prepDE.py -i /anomegap/edward/Hisat2-stringtie-deseq2/stringtie2ballgown_output/abundancesamplelist.txt -g /anomegap/edward/Hisat2-stringtie-deseq2/stringtieToDeseq_output/gene_count_matrix.csv -t /anomegap/edward/Hisat2-stringtie-deseq2/stringtieToDeseq_output/transcript_count_matrix.csv
