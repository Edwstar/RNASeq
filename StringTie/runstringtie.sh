# Run stringtie assemble and quantify expressed genes and transcripts
#  -v verbose (log bundle processing details)
# input from Hisat2 (already sorted by samtools)

for((i=1; i<=10; i=i+1))
do
/anomegap/edward/Edw_StringTie/stringtie_app/stringtie-1.3.5.Linux_x86_64/stringtie -p 7 -G /anomegap/edward/Edw_StringTie/genome_gtf/genes.gtf -o /anomegap/edward/Hisat2-stringtie-deseq2/stringtieAssenble_output/stringtie_out_sample${i}.gtf -v -e /anomegap/edward/Edw_hisat2/samtoolstobam/sorted/hisat2sample${i}_sorted.bam
done
