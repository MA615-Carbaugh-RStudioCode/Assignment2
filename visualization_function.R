
library(tidyverse)

build_visual <- function(tib){

  visual <- ggplot(data = tib) +
    geom_point(mapping = aes(x = log(Emissions), y = Life_Expectancy, color = country), show.legend = FALSE)
  
  return(visual)
}

