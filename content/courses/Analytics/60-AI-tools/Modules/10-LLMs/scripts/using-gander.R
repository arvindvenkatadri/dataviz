library(gander)
library(tidyverse)
library(ggformula)
data("stackoverflow", package = "modeldata")

## Use gander to get me my code

data(penguins)

penguins %>%
  ggplot(aes(x = bill_len, y = body_mass, color = species)) +
  geom_smooth(method = "lm", se = FALSE) + 
  geom_point() + 
  facet_wrap(~ island) + 
labs(title = 'Penguin Traits', x = 'Bill Length (mm)', 
     y = 'Body Mass (g)') + 
scale_color_discrete(name = "") + theme_classic()




