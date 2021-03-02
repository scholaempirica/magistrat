# Data and packages -------------------------------------------------------

library(tidyverse)
library(here)

source("shared.R", local = TRUE)

files = list.files(path = "data-processed", pattern = "(magistrat_call28_)*.rds", full.names = TRUE) #list of processed .rds files from the call 28
df_list = lapply(files, readRDS) #reads in data into single list

names(df_list) = str_replace(files, pattern = "(.+)_(.+).rds$", replacement = "\\2") #extracts names of the data frame from their file paths and applies them to the list

# Compute mean scores -----------------------------------------------------

#computes mean scores for both waves, so that the results are more comparable
#(as kindergarten questionnaire has less items, sum scores are not ideal).
#The compute_row_score() function is defined in shared.R

df_list = lapply(df_list, function(x) compute_row_score(data = x,
                                                        regex_match = "(cul|cond|pract|rel)(.+)_w1$",
                                                        output_var = mean_score_w1) )

df_list = lapply(df_list, function(x) compute_row_score(data = x,
                                                        regex_match = "(cul|cond|pract|rel)(.+)_w2$",
                                                        output_var = mean_score_w2) )

df_list = lapply(df_list, relocate, "mean_score_w1", .after = "total_score_w1") #moves mean_score_w1 closer to total_score_w1

# Saving data -------------------------------------------------------------

walk2(df_list, files, ~write_rds(x = .x, file = .y) ) #saves all data frames as .rds into the data-processed folder

