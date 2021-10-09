#Use tidyverse library
library(tidyverse)

#read in co2 csv
co2 <- read_csv("co2_emissions_tonnes_per_person.csv")

#remove string values. Micro symbol means these values will be near 0 anyway
co2 <- type.convert(co2, na.strings = c("", "60Âµ", "70Âµ", "80Âµ", "90Âµ"), as.is = TRUE)
#convert problem columns back to double
co2 <- co2 %>% 
  mutate('1829' = as.double('1829'), '1830' = as.double('1830'), '1831' = as.double('1831'), '1832' = as.double('1832'))

#Pivot longer to make data tidy
co2_clean <- co2 %>%
  pivot_longer(-country, names_to = "year", values_to = "Emissions", values_drop_na = TRUE)

#Change year column to integer to make viz axes easier to read
co2_clean <- co2_clean %>%
  mutate(year = as.integer(year))


#-------------------------

#read in life expectancy csv
life <- read_csv("life_expectancy_years.csv")

#Pivot longer to make data tidy
life_clean <- life %>%
  pivot_longer(-country, names_to = "year", values_to = "Life_Expectancy", values_drop_na = TRUE)

#Change year column to integer to make viz axes easier to read
life_clean <- life_clean %>%
  mutate(year = as.integer(year))


#--------------------------

#Join on country and year to create one combined dataset
joined <- inner_join(co2_clean, life_clean, by = c("country", "year"))

