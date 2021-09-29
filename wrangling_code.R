library(tidyverse)
co2 <- read.csv("co2_emissions_tonnes_per_person.csv", stringsAsFactors = FALSE)
co2 <- type.convert(co2, na.strings = c("", "60Âµ", "70Âµ", "80Âµ", "90Âµ"))

co2_clean <- co2 %>%
  pivot_longer(-ï..country, names_to = "Year", values_to = "Emissions_Tonnes_per_Person", values_drop_na = TRUE, )

co2_clean <- co2_clean %>%
  mutate(
    Year = as.integer(gsub("X", "", Year)),
  )

co2_clean <- rename(co2_clean, Country = ï..country)

#-------------------------


life <- read.csv("life_expectancy_years.csv", stringsAsFactors = FALSE)

life_clean <- life %>%
  pivot_longer(-ï..country, names_to = "Year", values_to = "Life_Expectancy", values_drop_na = TRUE, )

life_clean <- life_clean %>%
  mutate(
    Year = as.integer(gsub("X", "", Year)),
  )

life_clean <- rename(life_clean, Country = ï..country)

life_clean


#--------------------------

joined <- inner_join(co2_clean, life_clean, by = c("Country", "Year"))
joined
