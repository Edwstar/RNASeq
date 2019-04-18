# R version 3.5.2
# Compile in the container
# The input for this script should be from stringtie
# Get the library DESeq2
options(warn=-1)
suppressMessages(library(DESeq2))
countData <- as.matrix(read.csv("/seqslab/Hisat2-stringtie-deseq2/stringtieToDeseq_output/gene_count_matrix.csv", row.names="gene_id"))
colData <- data.frame(name = c("Tumor1","Tumor2","Tumor3","CTC1","CTC2","CTC3"),celltype = c("Tumor","Tumor","Tumor","CTC","CTC","CTC"),sep="\t", row.names=1)
all(rownames(colData) %in% colnames(countData))
# Should show [1] TRUE and you can go on the next step
countData <- countData[, rownames(colData)]
all(rownames(colData) == colnames(countData))
# Should show [1] TRUE and you can go on the next step

dds <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = ~ celltype)

dds <- DESeq(dds)
res <- results(dds)
(resOrdered <- res[order(res$padj), ])

# DE analysis
suppressMessages(dds2 <- DESeq(dds))
res <- results(dds2, contrast=c("celltype","Tumor","CTC"))
resOrdered <- res[order(res$padj),]
resOrdered=as.data.frame(resOrdered)
head(resOrdered)

# Another transformed model in DESeq
Extracting transformed values
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)

# Get the expected counts
exp_counts <- counts(dds, normalized = TRUE)

# Establish output file pathway, edit your own output pathway and output file name this line!
# Usage: file.path("your-output-pathway","your-output-file-name")
out_pwd_DEGtable1 <- file.path("/seqslab/Hisat2-stringtie-deseq2/deseq2_output","Tumor-vs-CTC.txt")
out_pwd_DEGtable2 <- file.path("/seqslab/Hisat2-stringtie-deseq2/deseq2_output","Tumor-vs-CTC.csv")
out_pwd_ExpCounts1 <- file.path("/seqslab/Hisat2-stringtie-deseq2/deseq2_output","Tumor-vs-CTC_expectedcounts.txt")
out_pwd_ExpCounts2 <- file.path("/seqslab/Hisat2-stringtie-deseq2/deseq2_output","Tumor-vs-CTC_expectedcounts.csv")

# Output table of pvalue files for all genes, but no expected counts for each samples
write.table(resOrdered, file = file.path(out_pwd_DEGtable1) ,sep = " ", quote = FALSE, na = "NA")
write.csv(resOrdered, file = file.path(out_pwd_DEGtable2), quote = FALSE, na = "NA")
# Output table of expected counts for all samples and genes
write.table(exp_counts, file = file.path(out_pwd_ExpCounts1), sep = " ", quote = FALSE, na = "na")
write.csv(exp_counts, file = file.path(out_pwd_ExpCounts2), quote = FALSE, na = "NA")