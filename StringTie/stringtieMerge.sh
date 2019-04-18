#Merge all transcripts from all samples

/anomegap/edward/Edw_StringTie/stringtie_app/stringtie-1.3.5.Linux_x86_64/stringtie --merge -p 7 -G /anomegap/edward/Edw_StringTie/genome_gtf/genes.gtf -o /anomegap/edward/Hisat2-stringtie-deseq2/stringtieMerge_output/stringtiemerge.gtf /anomegap/edward/Hisat2-stringtie-deseq2/stringtieMerge_output/samplelist.txt
