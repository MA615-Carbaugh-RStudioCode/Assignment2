#use tidyverse library
library(tidyverse)

#function will build the specified visual when given a tibble
build_visual <- function(tib){

  #ggplot for a scatterplot graphing log emissions v. life expectancy
  visual <- ggplot(data = tib) +
    geom_point(mapping = aes(x = log(Emissions), y = Life_Expectancy, color = country), show.legend = FALSE)
  
  return(visual)
}

#This part you did is amazing.