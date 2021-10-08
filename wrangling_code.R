library(tidyverse)
co2 <- read_csv("co2_emissions_tonnes_per_person.csv")
co2 <- type.convert(co2, na.strings = c("", "60Âµ", "70Âµ", "80Âµ", "90Âµ"))

co2_clean <- co2 %>%
  pivot_longer(-country, names_to = "year", values_to = "Emissions", values_drop_na = TRUE)

co2_clean <- co2_clean %>%
  mutate(year = as.integer(year))

co2_clean

#-------------------------


life <- read_csv("life_expectancy_years.csv")

life_clean <- life %>%
  pivot_longer(-country, names_to = "year", values_to = "Life_Expectancy", values_drop_na = TRUE)

life_clean <- life_clean %>%
  mutate(year = as.integer(year))

life_clean


#--------------------------

joined <- inner_join(co2_clean, life_clean, by = c("country", "year"))

# small <- filter(joined, country %in% c("Austrailia", "United States", "Germany", "China", "Russia", "Ghana", "Mexico", "France"))
#
# ggplot(data = joined)+
#   geom_line(mapping = aes(x = year, y = Life_Expectancy, color = country), show.legend = FALSE)
# 
# ggplot(data = joined)+
#   geom_point(mapping = aes(x = year, y = log(Emissions_Tonnes_per_Person), color = country), show.legend = FALSE)
# 
# ggplot(data = joined)+
#   geom_point(mapping = aes(x = log(Emissions_Tonnes_per_Person), y = Life_Expectancy, color = year), show.legend = FALSE)

joined_early <- filter(joined, year <1920)
joined_late <- filter(joined, year >=1920)
# joined_new <- mutate(joined, early = year<1920, low = log(Emissions_Tonnes_per_Person)<0)
# joined_low <- filter(joined, log(Emissions_Tonnes_per_Person)<0)
# joined_high <- filter(joined, log(Emissions_Tonnes_per_Person)>=0)
ggplot(data = joined_early)+
  geom_point(mapping = aes(x = log(Emissions), y = Life_Expectancy, color = country), show.legend = FALSE)

