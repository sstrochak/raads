
library(tidyverse)

# read in survey responses ------------------------------------------------

data <- read_csv("data/grad-school-survey.csv",
                 col_types = cols(.default = col_character()))

names(data) <- c("timestamp",
                 "degree",
                 "field",
                 "process",
                 "other")



# all preset options for each question

degrees <- c("PhD", "Master's degree", "Law school", "Business school")
fields <- c("Public policy or public administration", "Economics",
            "Sociology", "Health or public health", "Business", 
            "Law", "Criminology", "Social work", "Math or statistics",
            "Data science")
processes <- c("Picking a program",
               "GRE/standardized testing",
               "Personal statement",
               "Getting funding")

# clean up responses ------------------------------------------------------


count_degrees <- function(question_asked, degree_option) {
  
  
  data_long <- data %>% 
    gather(key = "question", value = "response", -timestamp) %>% 
    filter(question == question_asked)
  
  selected <- data_long %>% 
    filter(str_detect(response, degree_option)) %>% 
    nrow()
  
  tibble(response = degree_option,
         n = selected) %>% 
    mutate(question = question_asked,
           total = nrow(data))
  
}


response_data <- map2_df("degree", degrees, count_degrees) %>% 
  rbind(map2_df("field", fields, count_degrees)) %>% 
  rbind(map2_df("process", processes, count_degrees))
