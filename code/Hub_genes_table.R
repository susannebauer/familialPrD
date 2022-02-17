library(dplyr)
library(stringr)

dir <- "~/Documents/DataAnalysis_Ribotag/Prion_project/result_files/Network/SST_2021-10-25/"
nodes_annot <- read.csv("~/Documents/DataAnalysis_Ribotag/Prion_project/result_files/Network/SST_2021-10-25/pos_w_nodes_annot_SST_2021-10-25.csv")

hub_dgr <- nodes_annot %>%
  filter(!is.na(degree))%>%
  dplyr::select(name, module, disease, lfc_FFI, fdr_FFI)

#Get attributes for hub genes
library(biomaRt)
mouse_mart = useMart(biomart = "ensembl", dataset = "mmusculus_gene_ensembl")
genes <- hub_dgr$name

attr <- getBM(attributes = c("external_gene_name", "description", "ensembl_gene_id", "entrezgene_id"),
                   filters = "external_gene_name",
                   values = genes,
                   mart = mouse_mart)

hub_dgr <- merge(hub_dgr, attr, by.x="name", by.y= "external_gene_name")

hub_dgr <- hub_dgr %>%
  arrange(module, disease)%>%
  mutate(lfc_FFI = round(lfc_FFI, 4))%>%
  mutate(fdr_FFI = round(fdr_FFI, 4))%>%
  mutate(description = str_remove(description, pattern = "\\[.*\\]"))%>%
  dplyr::select(Name = "name",
                Module = "module",
                "DEG in disease" = "disease",
                "Description" = "description",
                "Ensembl ID" = "ensembl_gene_id",
                "Entrez ID" = "entrezgene_id",
                "log2FC" = "lfc_FFI",
                "adj. p-value (FDR)" = "fdr_FFI")

library(kableExtra)
library(knitr)
hub_tbl <- kbl(hub_dgr,
    format = "html",
    align = "lclllrrr",
    caption = "Hub genes by module")%>%
  kable_classic(font_size = 12,
                  full_width = T,
                  bootstrap_options = "striped")%>%
  row_spec(1:3, background = "lightgrey")
hub_tbl
save_kable(hub_tbl, file = paste0(dir,"hub_genes_table3.png"))
