# Data and packages -------------------------------------------------------

library(tidyverse) #data manipulation
library(here) #dynamic file paths
library(labelled) #variable labels

files = list.files(path = "data-input", pattern = "(magistrat_call28_)*.csv", full.names = TRUE) #list of .csv files from the call 28

df_list = lapply(files, read.csv2, encoding = "UTF-8") #reads in data into single list
names(df_list) = str_replace(files, pattern = "(.+)_(.+).csv$", replacement = "\\2") #extracts names of the data frame from their file paths and applies them to the list

# Fixing variable names ---------------------------------------------------

for (i in 1:3) {
  names(df_list[[i]])[1] = "project_number"
} #Fixes the name of the first variable in each data frame, which came garbled ("X.U.FEFF.project_number")
remove(i) #removes the iterated vector

names(df_list) = str_replace(files, pattern = "(.+)_(.+).csv", replacement = "\\2") #gives data frames recognizable names

# Adding variables labels -------------------------------------------------

#THe code on lines 26 to 96 is just variable labels for the questionnaire, so that we know which variable is which

kindergarten_labels = list("Číslo projektu",
                        "Žadatel",
                        "Název projektu",
                        "Škola přijímá všechny děti (ze spádové oblasti).",
                        "Každé dítě je důležité.",
                        "Pokud dítě s OMJ v zapojení se do programu MŠ nebo v zapojení se do kolektivu třídy není úspěšné, řešení se hledá v úpravě prostředí a v podpůrných opatřeních.",
                        "Škola zajišťuje průběžné vzdělávání všech svých zaměstnanců v oblastech efektivní práce s dětmi s OMJ.",
                        "Škola zajišťuje průběžné vzdělávání všech svých zaměstnanců v oblasti rozvoje osobních, sociálních a občanských kompetencí dětí.",
                        "Škola disponuje pomůckami, rozvíjí personální obsazení a podpůrná opatření pro efektivní zvládnutí práce s dětmi s OMJ.",
                        "Školní i volnočasové aktivity/ akce jsou přístupné všem dětem bez ohledu na jejich rodinné zázemí, možné sociokulturní znevýhodnění či jazykovou bariéru.",
                        "Individuální vzdělávací strategie je tvořena pro všechny děti s OMJ.",
                        "Posun v kompetencích dítěte s OMJ je sledován s ohledem na změnu jejich předchozího stavu.",
                        "Jsou převážně využívány rozmanité didaktické metody.",
                        "Školu lze charakterizovat jako „komunitní centrum“ dané lokality.",
                        "Učitelé si pravidelně vzájemně hospitují.",
                        "Vztah učitele a rodiče lze na škole charakterizovat jako partnerský.",
                        "Vedení školy pravidelně sdílí a konzultuje s učiteli svá rozhodnutí i vize.",
                        "Celkový počet bodů - vstupní dotazník",
                        "Škola přijímá všechny žáky (ze spádové oblasti).",
                        "Každý žák je důležitý.",
                        "Pokud dítě s OMJ v zapojení se do výuky nebo v zapojení se do kolektivu třídy není úspěšné, řešení se hledá v úpravě prostředí a v podpůrných opatřeních.",
                        "Škola zajišťuje průběžné vzdělávání všech svých zaměstnanců v oblastech efektivní práce s žáky s OMJ.",
                        "Škola mi zajišťuje průběžné vzdělávání v oblasti rozvoje osobních, sociálních a občanských kompetencí žáků.",
                        "Škola disponuje pomůckami, rozvíjí personální obsazení a podpůrná opatření pro efektivní zvládnutí práce s dětmi s OMJ.",
                        "Školní i volnočasové aktivity/ akce jsou přístupné všem dětem bez ohledu na jejich rodinné zázemí, možné sociokulturní znevýhodnění či jazykovou bariéru.",
                        "Individuální vzdělávací strategie je tvořena pro všechny žáky s OMJ.",
                        "Posun žáka s OMJ, tedy změna oproti předchozímu stavu, tvoří jádro hodnocení, klasifikace.",
                        "Jsou převážně využívány rozmanité didaktické metody.",
                        "Školu lze charakterizovat jako „komunitní centrum“ dané lokality.",
                        "Učitelé si pravidelně vzájemně hospitují ve výuce.",
                        "Vztah učitele a rodiče lze na škole charakterizovat jako partnerský.",
                        "Vedení školy pravidelně sdílí a konzultuje s učiteli svá rozhodnutí i vize.",
                        "Celkový počet bodů - výstupní dotazník")

elem_high_labels  = list("Číslo projektu",
                         "Žadatel",
                         "Název projektu",
                         "Škola přijímá všechny žáky (ze spádové oblasti).",
                         "Každý žák je důležitý.",
                         "Pokud dítě s OMJ v zapojení se do výuky nebo v zapojení se do kolektivu třídy není úspěšné, řešení se hledá v úpravě prostředí a v podpůrných opatřeních.",
                         "Všechny školní třídy jsou heterogenní.",
                         "Škola zajišťuje průběžné vzdělávání všech svých zaměstnanců v oblastech efektivní práce s žáky s OMJ.",
                         "Škola mi zajišťuje průběžné vzdělávání v oblasti rozvoje osobních, sociálních a občanských kompetencí žáků.",
                         "Škola disponuje pomůckami, rozvíjí personální obsazení a podpůrná opatření pro efektivní zvládnutí práce s dětmi s OMJ.",
                         "Školní i volnočasové aktivity/ akce jsou přístupné všem dětem bez ohledu na jejich rodinné zázemí, možné sociokulturní znevýhodnění či jazykovou bariéru.",
                         "Individuální vzdělávací strategie je tvořena pro všechny žáky s OMJ.",
                         "Posun žáka s OMJ, tedy změna oproti předchozímu stavu, tvoří jádro hodnocení, klasifikace.",
                         "Škola organizuje možnost efektivního doučování přímo ve škole.",
                         "Jsou převážně využívány rozmanité didaktické metody.",
                         "Školu lze charakterizovat jako „komunitní centrum“ dané lokality.",
                         "Učitelé si pravidelně vzájemně hospitují ve výuce.",
                         "Vztah učitele a rodiče lze na škole charakterizovat jako partnerský.",
                         "Vedení školy pravidelně sdílí a konzultuje s učiteli svá rozhodnutí i vize.",
                         "Celkový počet bodů - vstupní dotazník",
                         "Škola přijímá všechny žáky (ze spádové oblasti).",
                         "Každý žák je důležitý.",
                         "Pokud dítě s OMJ v zapojení se do výuky nebo v zapojení se do kolektivu třídy není úspěšné, řešení se hledá v úpravě prostředí a v podpůrných opatřeních.",
                         "Všechny školní třídy jsou heterogenní.",
                         "Škola zajišťuje průběžné vzdělávání všech svých zaměstnanců v oblastech efektivní práce s žáky s OMJ.",
                         "Škola mi zajišťuje průběžné vzdělávání v oblasti rozvoje osobních, sociálních a občanských kompetencí žáků.",
                         "Škola disponuje pomůckami, rozvíjí personální obsazení a podpůrná opatření pro efektivní zvládnutí práce s dětmi s OMJ.",
                         "Školní i volnočasové aktivity/ akce jsou přístupné všem dětem bez ohledu na jejich rodinné zázemí, možné sociokulturní znevýhodnění či jazykovou bariéru.",
                         "Individuální vzdělávací strategie je tvořena pro všechny žáky s OMJ.",
                         "Posun žáka s OMJ, tedy změna oproti předchozímu stavu, tvoří jádro hodnocení, klasifikace.",
                         "Škola organizuje možnost efektivního doučování přímo ve škole.",
                         "Jsou převážně využívány rozmanité didaktické metody.",
                         "Školu lze charakterizovat jako „komunitní centrum“ dané lokality.",
                         "Učitelé si pravidelně vzájemně hospitují ve výuce.",
                         "Vztah učitele a rodiče lze na škole charakterizovat jako partnerský.",
                         "Vedení školy pravidelně sdílí a konzultuje s učiteli svá rozhodnutí i vize.",
                         "Celkový počet bodů - výstupní dotazník")



names(kindergarten_labels) = names(df_list$kindergarten) #sets names for the list of kindergarten labels, because var_label() require a named list
names(elem_high_labels) = names(df_list$elementary) #sets names for the elem/high school labels, because var_label() require a named list

var_label(df_list$kindergarten) = kindergarten_labels #sets labels for the kindergarten data frame visible with View()
var_label(df_list$elementary) = elem_high_labels #sets labels for the elementary data frame visible with View()
var_label(df_list$high) = elem_high_labels #sets labels for the high data frame visible with View()

# Saving data -------------------------------------------------------------

output_paths = paste0(here("data-processed"), "/magistrat_call28_", names(df_list), ".rds") #creates path to save files in the data-procesed folder
walk2(df_list, output_paths, ~write_rds(x = .x, file = .y) ) #saves all data frames as .rds into the data-processed folder



