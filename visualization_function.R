



joined_early <- filter(joined, year <1920)
joined_late <- filter(joined, year >=1920)

ggplot(data = joined_early)+
  geom_point(mapping = aes(x = log(Emissions), y = Life_Expectancy, color = country), show.legend = FALSE)
