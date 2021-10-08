library(tidyverse)
co2 <- read.csv("co2_emissions_tonnes_per_person.csv", stringsAsFactors = FALSE)
co2 <- type.convert(co2, na.strings = c("", "60Âµ", "70Âµ", "80Âµ", "90Âµ"))

co2_clean <- co2 %>%
  pivot_longer(-ï..country, names_to = "year", values_to = "Emissions_Tonnes_per_Person", values_drop_na = TRUE, )

co2_clean <- co2_clean %>%
  mutate(
    year = as.integer(gsub("X", "", year)),
  )

co2_clean <- rename(co2_clean, country = ï..country)

#-------------------------


life <- read.csv("life_expectancy_years.csv", stringsAsFactors = FALSE)

life_clean <- life %>%
  pivot_longer(-ï..country, names_to = "year", values_to = "Life_Expectancy", values_drop_na = TRUE, )

life_clean <- life_clean %>%
  mutate(
    year = as.integer(gsub("X", "", year)),
  )

life_clean <- rename(life_clean, Country = ï..country)

life_clean


#--------------------------

joined <- inner_join(co2_clean, life_clean, by = c("Country", "Year"))
joined

plot(log(joined$Emissions_Tonnes_per_Person), joined$Life_Expectancy)
plot(joined$Year, log(joined$Emissions_Tonnes_per_Person))
plot(joined$Year, joined$Life_Expectancy)

small <- filter(joined, Country %in% c("Austrailia", "United States", "Germany", "China", "Russia", "Ghana", "Mexico", "France"))

small
ggplot(data = small)+
  geom_point(mapping = aes(x = Year, y = Life_Expectancy, color = Country), show.legend = TRUE)

ggplot(data = small)+
  geom_point(mapping = aes(x = Year, y = log(Emissions_Tonnes_per_Person), color = Country), show.legend = TRUE)

#-------------------------------

lung <- read_csv("lung_cancer_deaths_per_100000_men.csv")
lung_clean <- lung %>% 
  pivot_longer(-country, names_to = "year", values_to = "lung_cancer_deaths", values_drop_na = TRUE)

plot(lung_clean$year, lung_clean$lung_cancer_deaths)
lung_clean <- lung_clean %>%
  mutate(year = as.integer(year))

joined2 <- inner_join(co2_clean, lung_clean, by = c("country", "year"))

small2 <- filter(joined2, country %in% c("Austrailia", "United States", "Germany", "China", "Russia", "Ghana", "Mexico", "France", "Afghanistan"))


ggplot(data = small2)+
  geom_point(mapping = aes(x = year, y = lung_cancer_deaths, color = country), show.legend = FALSE)

ggplot(data = small2)+
  geom_point(mapping = aes(x = year, y = log(Emissions_Tonnes_per_Person), color = country), show.legend = FALSE)

