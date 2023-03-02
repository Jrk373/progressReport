library(tidyverse)
library(readxl)
library(scales)

# Import the unaltered VBP report, Detail sheet, as received from HCA
vbp_cbi <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_94-2880847_Community_Bridges_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_cpih <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0215065_Change_Point_Integrated_Health_HCA_BHH_VBP.xlsx", sheet = "Detail")
vbp_lcbhc <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0250938_Little_Colorado_Behavioral_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_mmhc <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0214457_Mohave_Mental_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_ph <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0206928_Polara_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_sbhs <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0290033_Southwest_Behavioral_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_shg <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0207499_Spectrum_Health_Group_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_tgc <- read_xlsx("C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/Quality/vbpbhh_report_2023-01-30_86-0223720_The_Guidance_Center_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")

# Bind the Details sheet from all providers into one table
Master_VBP_Rep_Comb <- rbind(
  vbp_cbi,
  vbp_cpih,
  vbp_lcbhc,
  vbp_mmhc,
  vbp_ph,
  vbp_sbhs,
  vbp_shg,
  vbp_tgc
)
# create a safe copy of the original data
VBP_Rep_Comb <- Master_VBP_Rep_Comb
# Set column names to headers, which get imported on row 6
colnames(VBP_Rep_Comb) <- VBP_Rep_Comb [6,] 
# Filter out superfluous rows of nonsense data
VBP_Rep_Comb <- VBP_Rep_Comb %>%  
  filter(LOB == "HCA")
# set date format for report date
VBP_Rep_Comb$`Data Period` <- as.numeric(VBP_Rep_Comb$`Data Period`)
VBP_Rep_Comb$`Data Period` <- as.Date(VBP_Rep_Comb$`Data Period`, origin = "1899-12-30")
VBP_Rep_Comb$Numerator <- as.numeric(VBP_Rep_Comb$Numerator)
VBP_Rep_Comb$TotalEligible <- as.numeric(VBP_Rep_Comb$Denominator)

# Construct data model
VBP_Rep_Comb <- VBP_Rep_Comb %>% 
  data.frame(do.call('rbind', strsplit(as.character(VBP_Rep_Comb$`Member Name`),',',fixed=TRUE))) %>% 
  mutate(code1 = str_sub(VBP_Rep_Comb$`Member ID`, start = -4)) %>% 
  mutate(code2 = substr(X1,1,2)) %>% 
  mutate(code3 = substr(X2,1,2)) %>% 
  mutate(RandomID = paste(code1, code2, code3, sep = "")) %>% 
  mutate(Provider_Shortname = ifelse(Health.Home.Name == "COMMUNITY BRIDGES", "CBI",
            ifelse(Health.Home.Name == "CHANGE POINT INTEGRATED HEALTH", "CPIH", 
                   ifelse(Health.Home.Name == "LITTLE COLORADO BEHAVIORAL HEALTH", "LCBHC", 
                          ifelse(Health.Home.Name == "MOHAVE MENTAL HEALTH", "MMHC", 
                                 ifelse(Health.Home.Name == "POLARA HEALTH", "PH", 
                                        ifelse(Health.Home.Name == "SOUTHWEST BEHAVIORAL HEALTH", "SBHS", 
                                               ifelse(Health.Home.Name == "SPECTRUM HEALTH GROUP", "SHG",
                                                      ifelse(Health.Home.Name == "THE GUIDANCE CENTER", "TGC", NA
        ))))))))) %>% 
  drop_na(Provider_Shortname) %>% 
  mutate(AdaptedCompliant = if_else((SubMeasure.ID == "HDO" & Numerator == 0), 1, Numerator)) %>% 
  mutate(AdaptedNCQAMean = ifelse(SubMeasure.ID == "AMM2", .5729,
                                     ifelse(SubMeasure.ID == "FUH7", .3936, 
                                            ifelse(SubMeasure.ID == "HDO", .9300, NA)
                                     ))) %>%
  select(Data.Period,
         Provider_Shortname,
         Health.Home.Name,
         Health.Home.TIN,
         SubMeasure.ID,
         SubMeasure.Description,
         RandomID,
         AdaptedCompliant,
         TotalEligible,
         AdaptedNCQAMean,
         Member.Age
         )
#export new data model table to csv
write.csv(VBP_Rep_Comb, "C:/Users/KGLtd/OneDrive - The NARBHA Institute/ACO/Data and Reports/BCBS-HCA Reports/VBP Reports/data_original_vbpbhh_2023-01-30_allProvidersCombined.csv")
write.csv(VBP_Rep_Comb, "C:/Users/KGLtd/OneDrive/R_Studio/progressReport/data/datadata_original_vbpbhh_2023-01-30_allProvidersCombined.csv")

