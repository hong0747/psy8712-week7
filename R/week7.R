# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)




# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE, col_types = cols(timeStart = col_datetime("%F %h:%M:%S")), show_col_types = TRUE) %>%
  mutate(gender = c("M" = "Male", "F" = "Female")[gender]) %>%
  mutate(condition = c("A" = "Block A", "B" = "Block B", "C" = "Control")[condition]) %>%
  filter(q6 == 1) %>%
  mutate(q6 = NULL) %>%
  mutate(timeSpent = as.numeric(timeEnd - timeStart, units = "mins"))






# Visualization