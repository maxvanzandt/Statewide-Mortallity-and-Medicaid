library(dplyr)
library(tibble)
library(stringr)

Medicare <- read.csv("data/raw/Copy of CPS MDCR ENROLL AB 1-8 2021.csv")
Overdose <- read.csv("data/raw/raw_data.csv")
Obesity <- read.csv("data/raw/2022-overall-prevalence.csv")
TotalDeath <- read.csv("data/raw/raw_data.csv")

colnames(TotalDeath)[1] <- "State"
Data <- merge(TotalDeath, Obesity, by = "State")

colnames(Overdose)[1] <- "State"
Data <- merge(Data, Overdose, by = "State")

colnames(Medicare)[1] <- "State"
Data <- merge(Data, Medicare, by = "State")

Medicaid <- read.csv("data/raw/raw_data (4).csv")
colnames(Medicaid)[1] <- "State"
Data <- merge(Data, Medicaid, by = "State")

COVID <- read.csv("data/raw/Book1.csv")
Data <- merge(Data, COVID, by = "State")

Senior <- read.csv("data/raw/ACSDP1Y2021.DP05-2023-10-09T164045.csv")
row_number_to_extract <- 25
Senior <- Senior %>% slice(row_number_to_extract)
Senior <- Senior %>%
  select(-Puerto.Rico..Percent, -Puerto.Rico..Estimate,
         -District.of.Columbia..Percent, -District.of.Columbia..Estimate)
Senior <- as.data.frame(t(Senior))
Senior <- Senior %>% rownames_to_column(var = "Row")
Senior <- Senior %>% filter(str_detect(Row, "Percent"))
colnames(Senior)[1] <- "State"
Senior$State <- gsub("\\.\\.Percent", "", Senior$State)
Senior$State <- gsub("\\.", " ", Senior$State)

Data <- merge(Data, Senior, by = "State")
colnames(Data)[19] <- "SeniorPop%"

Data <- Data %>%
  select(-Prevalence, -X95..CI, -Total.Medicare.Enrollment,
         -Original.Medicare.Enrollment, -Medicare.Advantage.and.Other.Health.Plan.Enrollment,
         -Total.Enrollment.Metropolitan.Residence, -Total.Enrollment.Micropolitan.Residence,
         -Total.Enrollment.Non.Core.Based.Statistical.Area, -Number.of.Deaths)

Data$State.Population <- gsub("\\,", "", Data$State.Population)
Data$Total.Medicaid.Spending <- gsub("\\$", "", Data$Total.Medicaid.Spending)
Data$Total.Medicaid.Spending <- gsub("\\,", "", Data$Total.Medicaid.Spending)
Data$State.Population <- as.numeric(Data$State.Population)
Data$Total.Medicaid.Spending <- as.numeric(Data$Total.Medicaid.Spending)

colnames(Data)[10] <- "SeniorPop"
Data$SeniorPop <- gsub("\\%", "", Data$SeniorPop)
Data$SeniorPop <- as.numeric(Data$SeniorPop)

Data <- Data %>%
  mutate(SeniorPop1 = cut_number(Data$SeniorPop, 3))
Data$SeniorPop <- ifelse(Data$SeniorPop <= 21.7 & Data$SeniorPop > 17.9, "High",
                         ifelse(Data$SeniorPop <= 17.9 & Data$SeniorPop > 16.6, "Medium", "Low"))

dir.create("data/processed", showWarnings = FALSE)
write.csv(Data, "data/processed/merged_data.csv", row.names = FALSE)
