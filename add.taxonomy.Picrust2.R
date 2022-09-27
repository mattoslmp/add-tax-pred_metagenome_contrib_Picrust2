library(dbplyr)
library(dplyr)
library(readr)
library(openxlsx)

setwd ("D:/ITV/Projeto-Isabelle-Markus/picrust2_out_stratified_min_0.9/KO_metagenome_out/picrust2")

metagenome_contribut <- read_delim("pred_metagenome_contrib.tsv", 
                                         delim = "\t", escape_double = FALSE, 
                                         trim_ws = TRUE)
colnames(metagenome_contribut)
colnames(metagenome_contribut) <- gsub('function', 'funct', colnames(metagenome_contribut))


qiime2_tax <-list.files(path="D:/ITV/Projeto-Isabelle-Markus/picrust2_out_stratified_min_0.9/KO_metagenome_out/picrust2/", pattern="*_otus_tax_assignments.txt", full.names=TRUE) %>% 
  lapply(read_tsv)

qiime2_tax <- data.frame(qiime2_tax)

colnames (qiime2_tax) <- c ("taxon", "taxon classif", "Percent"," Count")

merge_taxfunc <- inner_join(qiime2_tax, metagenome_contribut, by = 'taxon')
write.xlsx(merge_taxfunc, "taxonfunct.picrust2.xlsx")
write.table(merge_taxfunc, "taxonfunct.picrust2.tsv")
