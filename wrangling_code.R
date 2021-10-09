library(tidyverse)

co2 <- read_csv("co2_emissions_tonnes_per_person.csv")
co2 <- type.convert(co2, na.strings = c("", "60Âµ", "70Âµ", "80Âµ", "90Âµ"), as.is = TRUE)
co2 <- co2 %>% 
  mutate('1829' = as.double('1829'), '1830' = as.double('1830'), '1831' = as.double('1831'), '1832' = as.double('1832'))
co2_clean <- co2 %>%
  pivot_longer(-country, names_to = "year", values_to = "Emissions", values_drop_na = TRUE)

co2_clean <- co2_clean %>%
  mutate(year = as.integer(year))


#-------------------------


life <- read_csv("life_expectancy_years.csv")

life_clean <- life %>%
  pivot_longer(-country, names_to = "year", values_to = "Life_Expectancy", values_drop_na = TRUE)

life_clean <- life_clean %>%
  mutate(year = as.integer(year))


#--------------------------

joined <- inner_join(co2_clean, life_clean, by = c("country", "year"))

