# Magistrat calls 28 and 54


<!-- badges: start -->
<!-- badges: end -->

Repository for evaluation of project calls 28 and 54 for the Prague city hall.
The goal is to evaluate the effectiveness of two projects focused on inclusion of children from migrant background (in Czech "Děti s odlišným mateřským jazykem").
The first part of the project is to analyze data provided by Prague city hall (project call no. 28).
The second part is to gather and analyze data on the effectiveness of projects in the continuation of the project (project call no. 54).


## Repository description

`001_retrieve-data.R` - script for downloading data from Schola Empirica cloud.

`002_read-data.R` - import raw data, fixes variable names, adds variable labels and exports as .rds files

`003_check-and-process-data.R` - computes mean scores for both waves

`01_quantitative_report_call_28.Rmd` - report on the quantitative data from the first part of the project, project call no. 28

`shared.R` - custom based function for the project

`build.R` - rebuilds everything from the scratch. Run to reproduce the entire analysis

## Packages needed for this project

Packages need for this project can be installed using:

```
install.packages(c("tidyverse", "here", "labelled"))

remotes::install_github("scholaempirica/reschola") #needs the remote package
```
