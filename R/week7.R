# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE, col_types = cols(timeStart = col_datetime("%F %h:%M:%S")), show_col_types = TRUE) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  filter(q6 == 1) %>%
  mutate(q6 = NULL) %>%
  mutate(timeSpent = as.numeric(timeEnd - timeStart, units = "mins"))






# Visualization
ggpairs(data = week7_tbl, columns = 5:13, lower = list(continuous = "points"), upper = list(continuous = "cor"), diag = list(continuous = "densityDiag")) %>%
ggsave(filename = "../figs/scatter_corr_mat.png", plot = ., height = 10, width = 10, units = "in", dpi = 600)

ggplot(data = week7_tbl, mapping = aes(x = timeStart, y = q1)) + 
  geom_point() + 
  labs(x = "Date of Experiment", y = "Q1 Score")
ggsave(filename = "../figs/fig1.png", height = 5, width = 8, units = "in", dpi = 600)


ggplot(data = week7_tbl, mapping = aes(x = q1, y = q2, color = gender)) + 
  geom_point() +
  geom_jitter() +
  labs(color = "Participant Gender")
ggsave("../figs/fig2.png", height = 3, width = 5, units = "in", dpi = 600)
ggplot(data = week7_tbl, mapping = aes(x = q1, y = q2)) +
  geom_point() +
  geom_jitter() +
  labs(x = "Score on Q1", y = "Score on Q2") +
  facet_grid(cols = vars(gender))
ggsave("../figs/fig3.png", height = 4, width = 8.5, units = "in", dpi = 600)

ggplot(data = week7_tbl, mapping = aes(x = gender, y = timeSpent)) +
  geom_boxplot() +
  labs(x = "Gender", y = "Time Elapsed (mins)")
ggsave("../figs/fig4.png", height = 3, width = 5, units = "in", dpi = 600)


ggplot(data = week7_tbl, mapping = aes(x = q5, y = q7, color = condition)) + 
  geom_smooth(method = "lm", se = FALSE) +
  geom_jitter() +
  theme(legend.position = "bottom", legend.background = element_rect(fill = gray(0.875))) +
  labs(color = "Experimental Condition", x = "Score on Q5", y = "Score on Q7")
ggsave("../figs/fig5.png", height = 4, width = 8, units = "in", dpi = 600)