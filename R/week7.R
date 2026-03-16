# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)
library(ggplot2)


# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE, col_types = cols(timeStart = col_datetime("%F %h:%M:%S")), show_col_types = TRUE) %>%
  mutate(gender = c("M" = "Male", "F" = "Female")[gender]) %>%
  mutate(condition = c("A" = "Block A", "B" = "Block B", "C" = "Control")[condition]) %>%
  filter(q6 == 1) %>%
  mutate(q6 = NULL) %>%
  mutate(timeSpent = as.numeric(timeEnd - timeStart, units = "mins"))






# Visualization
ggpairs(data = week7_tbl, columns = 5:13, lower = list(continuous = "points"), upper = list(continuous = "cor"), diag = list(continuous = "densityDiag")) %>%
ggsave(filename = "../figs/scatter_corr_mat.png", plot = .)

ggplot(data = week7_tbl, mapping = aes(x = timeStart, y = q1)) + 
  geom_point() + 
  labs(x = "Date of Experiment", y = "Q1 Score")
ggsave(filename = "../figs/fig1.png", height = 5, width = 8, units = "in", dpi = 600)


ggplot(data = week7_tbl, mapping = aes(x = q1, y = q2, color = gender)) + 
  geom_point() +
  geom_jitter() +
  labs(color = "Participant Gender")
ggsave("../figs/fig2.png", height = 3, width = 5, units = "in", dpi = 600)