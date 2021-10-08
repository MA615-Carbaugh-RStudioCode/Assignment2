
library(tidyverse)

bulild_visual <- function(tib){
  # 
  # tib_early <- filter(tib, year <1920)
  # tib_late <- filter(tib, year >=1920)
  # 
  visual <- ggplot(data = tib) +
    geom_point(mapping = aes(x = log(Emissions), y = Life_Expectancy, color = country), show.legend = FALSE)
  
  return(visual)
}

