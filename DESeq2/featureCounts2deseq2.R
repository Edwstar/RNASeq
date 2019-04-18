# R version 3.5.2
# Compile in the container
# Call the DESeq2 library
options(warn=-1)
suppressMessages(library(DESeq2))

# Input
Tumor1 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample8", sep="\t", col.names = c("gene_id","Tumor1"))
Tumor2 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample9", sep="\t", col.names = c("gene_id","Tumor2"))
Tumor3 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample10", sep="\t", col.names = c("gene_id","Tumor3"))
CTC1 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample5", sep="\t", col.names = c("gene_id","CTC1"))
CTC2 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample6", sep="\t", col.names = c("gene_id","CTC2"))
CTC3 <- read.table("/seqslab/hisat2-featureCounts-deseq2/featureCounts2cat_output/cat-featureCounts-sample7", sep="\t", col.names = c("gene_id","CTC3"))


# Merge all samples into a table
allsample <- Reduce(function(x, y) merge (x, y, all=TRUE), list(Tumor1, Tumor2, Tumor3, CTC1, CTC2, CTC3))


# Exclude the gene_id column
countMatrix <- as.matrix(allsample[2:7])

rownames(countMatrix) <-allsample$gene_id
head(countMatrix)
colData <- data.frame(name = c("Tumor_1","Tumor_2","Tumor_3","CTC_1","CTC_2","CTC_3"),celltype = c("Tumor","Tumor","Tumor","CTC","CTC","CTC"))

dds <- DESeqDataSetFromMatrix(countMatrix, colData=colData, design= ~ celltype)

# DE analysis
suppressMessages(dds2 <- DESeq(dds))
res <- results(dds2, contrast=c("celltype","Tumor","CTC"))
resOrdered <- res[order(res$padj),]
resOrdered=as.data.frame(resOrdered)
head(resOrdered)

# Extracting transformed values, another transformed models
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)

# Get the expected counts
exp_counts <- counts(dds, normalized = TRUE)

# Establish output file pathway, edit your own output pathway and output file name this line!
# Usage: file.path("your-output-pathway","your-output-file-name")
out_pwd_DEGtable1 <- file.path("/seqslab/hisat2-featureCounts-deseq2/deseq2output","Tumor-vs-CTC.txt")
out_pwd_DEGtable2 <- file.path("/seqslab/hisat2-featureCounts-deseq2/deseq2output","Tumor-vs-CTC.csv")
out_pwd_ExpCounts1 <- file.path("/seqslab/hisat2-featureCounts-deseq2/deseq2output","Tumor-vs-CTC_expectedcounts.txt")
out_pwd_ExpCounts2 <- file.path("/seqslab/hisat2-featureCounts-deseq2/deseq2output","Tumor-vs-CTC_expectedcounts.csv")

# Output table of pvalue files for all genes, but no expected counts for each samples
write.table(resOrdered, file = file.path(out_pwd_DEGtable1) ,sep = " ", quote = FALSE, na = "NA")
write.csv(resOrdered, file = file.path(out_pwd_DEGtable2), quote = FALSE, na = "NA")
# Output table of expected counts for all samples and genes
write.table(exp_counts, file = file.path(out_pwd_ExpCounts1), sep = " ", quote = FALSE, na = "na")
write.csv(exp_counts, file = file.path(out_pwd_ExpCounts2), quote = FALSE, na = "NA")