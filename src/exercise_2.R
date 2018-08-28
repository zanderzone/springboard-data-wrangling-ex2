# X. Loads libraries ----
library(dplyr)
library(magrittr) # allows for pipelines
library(tidyr)
library(readr)

# 0. Imports data ----
raw <- read_csv("./data/titanic_original.csv")

# Replace all NAs in embarked with an S
raw$embarked[is.na(raw$embarked)] <- "S"

# Calculate age mean
age_mean <- mean(raw$age, na.rm = TRUE)
# Replace all age with missing data with age_mean
raw$age[is.na(raw$age)] <- age_mean

# Think about other ways you could have populated the 
# missing values in the age column. Why would you pick 
# any of those over the mean (or not)?

## You can choose to use the age of the previous row.  
## This would not work if the age is from the first record.
## That record would not have a previous age to use.
## You can also try to interpolate based on last and next 
## age values.  The same problem is encountered as 
## with using the previous age value.  

# You’re interested in looking at the distribution of passengers 
# in different lifeboats, but as we know, many passengers did not make 
# it to a boat :-( This means that there are a lot of missing values 
# in the boat column. Fill these empty slots with a dummy value
# e.g. the string 'None' or 'NA'
raw$boat[is.na(raw$boat)] <- "None"

# Create a new column has_cabin_number which has 1 if there is a cabin number,
# and 0 otherwise.
titanic_clean <- raw %>% 
  mutate(has_cabin_number = ifelse(is.na(cabin), 0, 1))

write.csv(titanic_clean, "./data/titanic_clean.csv")
