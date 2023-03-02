# Bind monthly VBP results to one aggregate table

library(tidyverse)

VBP_2022_12_16 <- read.csv("./data/output/2023-01-01_Tab_PercentCompliant.csv")
VBP_2023_01_30 <- read.csv("./data/output/2023-03-01_Tab_PercentCompliant.csv")

VBP_Aggregate_Monthly <- rbind(
  VBP_2022_12_16,
  VBP_2023_01_30
)

write.csv(VBP_Aggregate_Monthly, "./data/output/CY22-23_VBP_Aggregate_Monthly.csv")
