# Data and packages -------------------------------------------------------

library(tidyverse) #data manipulation
library(here) #dynamic file paths
library(labelled) #variable labels

files = list.files(path = "data-input", pattern = "magistrat_call28_marks_.+.csv", full.names = TRUE) #list of .csv files from with school marks the call 28

df_list = lapply(files, read.csv2, encoding = "UTF-8") #reads in data into single list
names(df_list) = str_replace(files, pattern = "(.+)_(.+).csv$", replacement = "\\2") #extracts names of the data frame from their file paths and applies them to the list

# Fixing variable names ---------------------------------------------------

for (i in seq_along(df_list)) {
  names(df_list[[i]])[1] = "id"
} #Fixes the name of the first variable in each data frame, which came garbled ("X.U.FEFF.project_number")
remove(i) #removes the iterated vector

names(df_list) = str_replace(files, pattern = "(.+)_(.+).csv", replacement = "\\2") #gives data frames recognizable names

# Adding variables labels -------------------------------------------------

marks_labels = list("Identifikační číslo žáka",
                    "Známka z ČJ",
                    "Známka z M",
                    "Průměr známek",
                    "Třída",
                    "Pololetí",
                    "Rok",
                    "Škola")

names(marks_labels) = names(df_list$Hostivar) #sets names for the list of marks labels, because var_label() require a named list

for (i in seq_along(df_list)) {
  var_label(df_list[[i]]) = marks_labels
} #adds labels to variables as attributes
remove(i) #removes the support variable from the loop above

# Saving data -------------------------------------------------------------

output_paths = paste0(here("data-processed"), "/magistrat_call28_marks_", names(df_list), ".rds") #creates path to save files in the data-procesed folder
walk2(df_list, output_paths, ~write_rds(x = .x, file = .y) ) #saves all data frames as .rds into the data-processed folder
