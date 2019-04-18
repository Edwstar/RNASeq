# Estimate transcript abundances and create table counts for Ballgown
# -G here uses merged.gtf, not the genome one
for((i=1; i<=10; i=i+1))
do
/anomegap/edward/Edw_StringTie/stringtie_app/stringtie-1.3.5.Linux_x86_64/stringtie -e -B -p 7 -G /anomegap/edward/Hisat2-stringtie-deseq2/stringtieMerge_output/stringtiemerge.gtf -o /anomegap/edward/Hisat2-stringtie-deseq2/stringtie2ballgown_output/abundance${i}.gtf /anomegap/edward/Edw_hisat2/samtoolstobam/sorted/hisat2sample${i}_sorted.bam
done
