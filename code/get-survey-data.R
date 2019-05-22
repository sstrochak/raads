
library(tidyverse)
library(googlesheets)

gs_ls()

gradschool <- gs_url("https://docs.google.com/spreadsheets/d/13f48MICmqYNxkrEajNeE2Ai-TKuoJBVDzvGFcFeP37s/edit#gid=744445016")

gs_read(gradschool)


