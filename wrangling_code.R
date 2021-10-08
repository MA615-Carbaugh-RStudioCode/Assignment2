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

life_clean <- rename(life_clean, country = ï..country)

life_clean


#--------------------------

joined <- inner_join(co2_clean, life_clean, by = c("country", "year"))
joined

plot(log(joined$Emissions_Tonnes_per_Person), joined$Life_Expectancy)
plot(joined$year, log(joined$Emissions_Tonnes_per_Person))
plot(joined$year, joined$Life_Expectancy)

small <- filter(joined, country %in% c("Austrailia", "United States", "Germany", "China", "Russia", "Ghana", "Mexico", "France"))

small
ggplot(data = joined)+
  geom_line(mapping = aes(x = year, y = Life_Expectancy, color = country), show.legend = FALSE)

ggplot(data = joined)+
  geom_point(mapping = aes(x = year, y = log(Emissions_Tonnes_per_Person), color = country), show.legend = FALSE)

ggplot(data = joined)+
  geom_point(mapping = aes(x = log(Emissions_Tonnes_per_Person), y = Life_Expectancy, color = year), show.legend = FALSE)

joined_early <- filter(joined, year <1920)
joined_late <- filter(joined, year >=1920)
joined_new <- mutate(joined, early = year<1920, low = log(Emissions_Tonnes_per_Person)<0)
joined_low <- filter(joined, log(Emissions_Tonnes_per_Person)<0)
joined_high <- filter(joined, log(Emissions_Tonnes_per_Person)>=0)
ggplot(data = joined_late)+
  geom_point(mapping = aes(x = log(Emissions_Tonnes_per_Person), y = Life_Expectancy, color = country), show.legend = FALSE)


#-------------------------------

lung <- read_csv("lung_cancer_new_cases_per_100000_men.csv")
lung_clean <- lung %>% 
  pivot_longer(-country, names_to = "year", values_to = "new_cases", values_drop_na = TRUE)

plot(lung_clean$year, lung_clean$new_cases)
lung_clean <- lung_clean %>%
  mutate(year = as.integer(year))

joined2 <- inner_join(co2_clean, lung_clean, by = c("country", "year"))

small2 <- filter(joined2, country %in% c("Austrailia", "United States", "Germany", "China", "Russia", "Ghana", "Mexico", "France", "Afghanistan"))


ggplot(data = joined2)+
  geom_line(mapping = aes(x = year, y = new_cases, color = country), show.legend = FALSE)

ggplot(data = joined2)+
  geom_line(mapping = aes(x = year, y = log(Emissions_Tonnes_per_Person), color = country), show.legend = FALSE)

ggplot(data = joined2)+
  geom_point(mapping = aes(x =log(Emissions_Tonnes_per_Person), y = new_cases, color = year), show.legend = TRUE)

joined2_early <- filter(joined2, year <1990)
joined2_late <- filter(joined2, year >=1990)
joined2_new <- mutate(joined2, early = year<1990)

ggplot(data = joined2_new)+
  geom_point(mapping = aes(x =log(Emissions_Tonnes_per_Person), y = new_cases, color = early), show.legend = FALSE)


