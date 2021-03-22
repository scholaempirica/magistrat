# Data and packages -------------------------------------------------------

library(tidyverse)
library(here)
library(labelled)

files = list.files(path = "data-processed", pattern = "magistrat_call28_marks_.+.rds", full.names = TRUE) #list of .csv files from with school marks the call 28
df_list = lapply(files, read_rds) #reads in data into single list

df_list[[2]]$id = as.character(df_list[[2]]$id) #changes ids in Kvetneho vitezstvi to characters, so that they can be merged with the rest

marks = bind_rows(df_list)

# Adding variables labels -------------------------------------------------

marks_labels = list("Identifikační číslo žáka",
                    "Známka z ČJ",
                    "Známka z M",
                    "Průměr známek",
                    "Třída",
                    "Pololetí",
                    "Rok",
                    "Škola")

names(marks_labels) = names(marks) #sets names for the list of marks labels, because var_label() require a named list

var_label(marks) = marks_labels

# Export data -------------------------------------------------------------

write_rds(marks, here("data-processed", "magistrat_call28_marks_merged.rds"))
