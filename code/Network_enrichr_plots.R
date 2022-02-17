#enrichment plots 

get_top15_BP_combsc <- function(i){
  require(stringr)
  
  BP <- input[[i]]$GO_Biological_Process_2021%>%  
    arrange(desc(Combined.Score)) %>%
    slice_max(Combined.Score, n = 15) %>% 
    mutate(gs_name = str_remove(Term, pattern = ".(GO:d*.*)")) %>%
    mutate(Gene_count = as.numeric(str_extract(Overlap, "^[^/]+"))) %>%
    mutate(ratio = as.numeric(str_extract(Overlap, "^[^/]+"))/as.numeric(str_extract(Overlap, "[^/]+$")))%>%
    mutate(Module = paste("Module",i))
  
  return(BP)
  
}
BP1 <- get_top15_BP_combsc(1)
BP2 <- get_top15_BP_combsc(2)
BP3 <- get_top15_BP_combsc(3)
BP4 <- get_top15_BP_combsc(4)
BP5 <- get_top15_BP_combsc(5)
BP <- rbind(BP1, BP2, BP3, BP4, BP5)

  plot <- ggplot(BP, aes(y = reorder(gs_name, -log10(Adjusted.P.value)), 
                         x = -log10(Adjusted.P.value), 
                         size = Gene_count,
                         color = ratio))+
    geom_segment(aes(y = reorder(gs_name, -log10(Adjusted.P.value)),
                     yend = reorder(gs_name, -log10(Adjusted.P.value)),
                     x = 0, xend = -log10(Adjusted.P.value)),
                 size = .3, color = "grey72")+
    scale_color_gradient(trans = "reverse")+
    geom_point()+
    theme_bw()+
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 10),
          axis.title.y = element_text(size = 12))+
    labs(y = "Top 15 enriched Biological Processes (Combined Score) by Module",
         x = "-log10(Adjusted p-value)",
         color = "Gene ratio",
         size = "Gene count")+
    facet_wrap(~Module, shrink = F, scales = "free", drop = T, nrow = 5, ncol = 1, strip.position = "right")
  
  plot
  ggsave(plot, filename = paste0(outdir, "/figures/Top15_BP_SSTNet.png"), width = 25, height = 30, units = "cm") 
  

M1 <- get_top15_BP_combsc(1)
M1
ggsave(M1, filename = paste0(outdir, "/figures/Top15_BP_M1.png"), width = 22, height = 10, units = "cm") 

M2 <- get_top15_BP_combsc(2)
M2
ggsave(M2, filename = paste0(outdir, "/figures/Top15_BP_M2.png"), width = 22, height = 10, units = "cm") 

M3 <- get_top15_BP_combsc(3)
M3
ggsave(M3, filename = paste0(outdir, "/figures/Top15_BP_M3.png"), width = 22, height = 10, units = "cm") 

M4 <- get_top15_BP_combsc(4)
M4
ggsave(M4, filename = paste0(outdir, "/figures/Top15_BP_M4.png"), width = 22, height = 10, units = "cm") 

M5 <- get_top15_BP_combsc(5)
M5
ggsave(M5, filename = paste0(outdir, "/figures/Top15_BP_M5.png"), width = 22, height = 10, units = "cm") 

