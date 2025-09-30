options(paged.print = TRUE)
library(tidyverse)
library(mosaic)
library(ggformula)

#install.packages("remotes")
#library(remotes)
#remotes::install_github("wilkelab/ggridges")
library(ggridges)
library(skimr)

library(palmerpenguins) # Our new favourite dataset


library(checkdown)
library(epoxy)
library(TeachHist)
library(TeachingDemos)
library(visualize) # Plot Densities, Histograms and Probabilities as areas under the curve
library(grateful)
library(MKdescr)
library(shinylive) # To create a Shiny app in a Quarto HTML doc
# Will not work if webr is also used in the SAME Quarto doc!
library(sysfonts)
library(gfonts)
library(kableExtra)
# library(conflicted)
# conflicted::conflicts_prefer(dplyr::filter, dplyr::count, dplyr::last, dplyr::glimpse, base::max)


# https://stackoverflow.com/questions/74491138/ggplot-custom-fonts-not-working-in-quarto

# Chunk options
knitr::opts_chunk$set(
 fig.width = 7,
 fig.asp = 0.618, # Golden Ratio
 #out.width = "80%",
 fig.align = "center"
)
### Ggplot Theme
### https://rpubs.com/mclaire19/ggplot2-custom-themes

theme_custom <- function(){ 
    font <- "Roboto Condensed"   #assign font family up front
    
    theme_classic(base_size = 14) %+replace%    #replace elements we want to change
    
    theme(
      panel.grid.minor = element_blank(),    #strip minor gridlines
      text = element_text(family = font),
      #text elements
      plot.title = element_text(             #title
                   family = font,            #set font family
                   #size = 20,               #set font size
                   face = 'bold',            #bold typeface
                   hjust = 0,                #left align
                   #vjust = 2                #raise slightly
                   margin=margin(0,0,10,0)
),               
      
      plot.subtitle = element_text(          #subtitle
                   family = font,            #font family
                   #size = 14,                #font size
                   hjust = 0,
                   margin=margin(2,0,5,0)
),               
      
      plot.caption = element_text(           #caption
                   family = font,            #font family
                   size = 8,                 #font size
                   hjust = 1),               #right align
      
      axis.title = element_text(             #axis titles
                   family = font,            #font family
                   size = 10                 #font size
),
      
      axis.text = element_text(              #axis text
                   family = font,            #axis family
                   size = 8)               #font size
    )
}

# Set graph theme
theme_set(new = theme_custom())
#

# webr::install("tidyverse")
# webr::install("mosaic")
# webr::install("palmerpenguins")
# webr::install("ggformula")
# webr::install("ggridges")
# webr::install("skimr")
# library(tidyverse)
# library(mosaic)
# library(palmerpenguins)
# library(ggformula)
# library(ggridges)
# library(skimr)
# 
# download.file(
#   url = 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/race.csv', 
# destfile = 'race_df.csv')
# 
# download.file(
#   url = "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/ultra_rankings.csv", 
#   destfile = "rank_df.csv")
# 
# # Read the data
# race_df <- read_csv("race_df.csv")
# rank_df <- read_csv("rank_df.csv")


read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  filter(No == "1") %>% 
  kbl() %>%
  kable_paper("hover", full_width = T)
  

glimpse(diamonds)


skim(diamonds)


## Set graph theme
theme_set(new = theme_custom())
##
gf_histogram(~ price, data = diamonds) %>%
  gf_labs(title = "Plot A: Diamond Prices",caption = "ggformula") 

###
diamonds %>% 
  gf_histogram(~ price, 
               fill = ~ cut, 
               alpha = 0.3) %>%
  gf_labs(title = "Plot B: Prices by Cut",
          caption = "ggformula")

###
diamonds %>% 
  gf_histogram(~ price, 
               fill = ~ cut) %>%
  gf_facet_wrap(~ cut) %>%
  gf_labs(title = "Plot C: Prices by Filled and Facetted by Cut",
          caption = "ggformula") %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45, hjust = 1)))

###
diamonds %>% 
  gf_histogram(~ price,
                          fill = ~ cut, 
                          color = "black") %>% 
  gf_facet_wrap(~ cut, scales = "free_y", nrow = 2) %>%
  gf_labs(title = "Plot D: Prices Filled and Facetted by Cut", 
          subtitle = "Free y-scale",
          caption = "ggformula") %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45, hjust = 1)))


## Set graph theme
theme_set(new = theme_custom())
##

ggplot(data = diamonds) + 
  geom_histogram(aes(x = price)) +
  labs(title = "Plot A: Diamond Prices",
       caption = "ggplot")

###
diamonds %>% ggplot() + 
  geom_histogram(aes(x = price, 
                     fill = cut), 
                     alpha = 0.3) + 
  labs(title = "Plot B: Prices by Cut",
       caption = "ggplot")

###
diamonds  %>% ggplot() + 
  geom_histogram(aes(price, fill = cut)) +
  facet_wrap(facets = vars(cut)) + 
  labs(title = "Plot C: Prices by Filled and Facetted by Cut",
       caption = "ggplot") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###
diamonds  %>% ggplot() + 
  geom_histogram(aes(price, fill = cut), color = "black") +
  facet_wrap(facets = vars(cut), scales = "free_y") +
  labs(title = "Plot D: Prices by Filled and Facetted by Cut",
       subtitle = "Free y-scale",
       caption = "ggplot") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


install.packages("shiny")
library(shiny)
runExample("01_hello")      # an interactive histogram


## Set graph theme
theme_set(new = theme_custom())
##

gf_bar(~ cut, data = diamonds) %>%
  gf_labs(title = "Plot A: Diamonds Counts of different Cuts")


###
diamonds %>% 
  gf_bar( ~ cut, 
          fill = ~ cut) %>%
  gf_labs(title = "Plot B: Diamonds Counts filled by Cut")


###
diamonds %>% 
  gf_bar( ~ cut, 
          fill = ~ clarity, 
          position = "stack",
          alpha = 0.3) %>%
  gf_labs(title = "Plot C: Diamonds Counts by Cut filled by Clarity",
          subtitle = "Stacked Bar Chart")

###
diamonds %>% 
  gf_bar( ~ cut, 
          fill = ~ clarity, 
          position = "dodge",
          color = "black") %>%
  gf_refine(scale_fill_viridis_d(option = "turbo")) %>% # inferno, magma, cividis...etc
  gf_labs(title = "Plot D: Diamonds Counts by Cut filled by Clarity",
          subtitle = "Dodged Bar Chart",
          caption = "Turbo Palette from Viridis set")


## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% gf_bar( ~ cut, 
                     fill = ~ clarity, 
                     position = "dodge", 
                     colour = "black") %>%
  gf_facet_wrap(vars(color),scales = "free_y") %>%
  gf_refine(scale_fill_viridis_d(option = "turbo")) %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45,hjust = 1))) %>%
  gf_labs(title = "Plot E: Diamonds Counts by Cut filled by Clarity",
          subtitle = "Dodged Bar Chart Facetted by Color",
          caption = "Turbo Palette from Viridis set")

## Set graph theme
theme_set(new = theme_custom())
##

ggplot(diamonds)  + 
  geom_bar(aes(cut)) + 
  labs(title = "Plot A: Diamonds Counts of different Cuts")


###
diamonds %>% 
  ggplot() + 
  geom_bar(aes(cut, fill = cut) ) + 
  labs(title = "Plot B: Diamonds Counts filled by Cut")


###
diamonds %>% 
  ggplot() + 
  geom_bar(aes(cut, fill = clarity), 
               position = "stack",
               alpha = 0.3) + 
  labs(title = "Plot C: Diamonds Counts by Cut filled by Clarity",
       subtitle = "Stacked Bar Chart")

###
diamonds %>% 
  ggplot() + 
  geom_bar(aes(cut, fill = clarity), 
               position = "dodge",
               color = "black") + 
  scale_fill_viridis_d(option = "turbo") +  # inferno, magma, cividis...etc
  labs(title = "Plot D: Diamonds Counts by Cut filled by Clarity",
       subtitle = "Dodged Bar Chart",
       caption = "Turbo Palette from Viridis set")



## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% 
  ggplot() + 
  geom_bar(aes(cut, fill = clarity), 
               position = "dodge", 
               colour = "black") +
  facet_wrap(vars(color), scales = "free_y") + 
  scale_fill_viridis_d(option = "turbo") +
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) + 
  labs(title = "Plot E: Diamonds Counts by Cut filled by Clarity",
       subtitle = "Dodged Bar Chart Facetted by Color",
       caption = "Turbo Palette from Viridis set")


## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% 
  gf_bar(~ cut) %>% # performs counts based on `cut` (Qual variable)
                # default y-axis labelling is "count"
                
  gf_labs(title = "Bar Plot Counts internally")
###

diamonds %>% 
  # count gives a default variable called `n`
  # We rename it to "counts". 
  # Note the quotation marks in the naming ceremony below
  count(cut, name = "How_Many") %>% 
  
  # gf_col needs counted data
  # we use the (re)named variable counts vs cut
  gf_col(How_Many ~ cut) %>% 
  gf_labs(title = "Column Plot needs pre-counted data")



## Set graph theme
theme_set(new = theme_custom())
##

gf_props(~ substance,
  data = mosaicData::HELPrct, fill = ~ sex,
  position = "dodge"
) %>%
  gf_labs(title = "Plotting Proportions using gf_props")
###
gf_percents(~ substance,
  data = mosaicData::HELPrct, fill = ~ sex,
  position = "dodge"
)%>%
  gf_labs(title = "Plotting Percentages using gf_percents")

## Set graph theme
theme_set(new = theme_custom())
##


gf_density(~ price, data = diamonds) %>%
  gf_labs(title = "Plot A: Diamond Prices",caption = "ggformula")

###
diamonds %>% gf_density(~ price, 
                          fill = ~ cut, 
                          color = ~ cut,
                          alpha = 0.3) %>%
  gf_refine(scale_color_viridis_d(option = "magma",
                                  aesthetics = c("colour", "fill"))) %>%
  gf_labs(title = "Plot B: Prices by Cut",caption = "ggformula")

###
diamonds %>% gf_density(~ price,
                          fill = ~ cut) %>%
  gf_facet_wrap(vars(cut)) %>%
  gf_labs(title = "Plot C: Prices by Filled and Facetted by Cut",caption = "ggformula") 

###
diamonds %>% gf_density(~ price,
                          fill = ~ cut, 
                        color = "black") %>% 
  gf_facet_wrap(vars(cut), scales = "free_y", nrow = 2) %>%
  gf_labs(title = "Plot D: Prices Filled and Facetted by Cut", 
          subtitle = "Free y-scale", caption = "ggformula") %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45,hjust = 1)))



## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% ggplot() + 
  geom_density(aes(price)) +
  labs(title = "Plot A: Diamond Prices",caption = "ggplot")

###
diamonds %>% ggplot() + 
  geom_density(aes(price, 
                   fill = cut, 
                   color = cut),
                   alpha = 0.3) +
  scale_color_viridis_d(option = "magma",
                        aesthetics = c("colour", "fill")) + 
  labs(title = "Plot B: Prices by Cut",caption = "ggplot")

###
diamonds %>% ggplot() + 
  geom_density(aes(price,
                   fill = cut)) + 
  facet_wrap(vars(cut)) + 
  labs(title = "Plot C: Prices by Filled and Facetted by Cut",
      caption = "ggplot") 

###
diamonds %>% ggplot() + 
  geom_density(aes(price,
                   fill = cut), 
                   color = "black") + 
  facet_wrap(vars(cut), scales = "free_y", nrow = 2) + 
  labs(title = "Plot D: Prices Filled and Facetted by Cut", 
          subtitle = "Free y-scale", caption = "ggplot") + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1))



set.seed(2020)
MKdescr::illustrate.boxplot(rnorm(50, mean = 3, sd = 2))


## Set graph theme
theme_set(new = theme_custom())
##

gf_boxplot(price ~ "All Diamonds", data = diamonds) %>% 
  gf_labs(title = "Plot A: Boxplot for Diamond Prices")

###
diamonds %>% 
  gf_boxplot(price ~ cut) %>% 
  gf_labs(title = "Plot B: Price by Cut")

###
diamonds %>% 
  gf_boxplot(price ~ cut, 
             fill = ~ cut, 
             color = ~ cut,
             alpha = 0.3) %>% 
  gf_labs(title = "Plot C: Price by Cut")

###
diamonds %>% 
  gf_boxplot(price ~ cut, 
             fill = ~ cut, 
             colour = ~ cut,             
             alpha = 0.3) %>% 
  gf_facet_wrap(vars(clarity)) %>%
  gf_labs(title = "Plot D: Price by Cut facetted by Clarity") %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45,hjust = 1)))


## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% ggplot() + 
  geom_boxplot(aes(y = price)) + # note: y, not x
  labs(title = "Plot A: Boxplot for Diamond Prices")

###
diamonds %>% ggplot() + 
  geom_boxplot(aes(cut, price)) + 
  labs(title = "Plot B: Price by Cut")

###
diamonds %>% ggplot() + 
  geom_boxplot(aes(cut, 
                   price, 
                   color = cut, fill = cut), alpha = 0.4) +
  labs(title = "Plot C: Price by Cut")

###
diamonds %>% ggplot() + 
  geom_boxplot(aes(cut, 
                   price, 
                   color = cut, fill = cut), alpha = 0.4)  +  
  facet_wrap(vars(clarity)) +
  labs(title = "Plot D: Price by Cut facetted by Clarity") +
  theme(axis.text.x = element_text(angle = 45,hjust = 1))


## Set graph theme
theme_set(new = theme_custom())
##


gf_density_ridges(drv ~ hwy, fill = ~ drv, 
                  alpha = 0.3, 
                  rel_min_height = 0.005, data = mpg) %>% 
  gf_refine(scale_y_discrete(expand = c(0.01, 0)),
            scale_x_continuous(expand = c(0.01, 0))) %>% 
  gf_labs(title = "Ridge Plot")


## Set graph theme
theme_set(new = theme_custom())
##


gf_violin(price ~ "All Diamonds", data = diamonds, 
          draw_quantiles = c(0,.25,.50,.75)) %>%
  gf_labs(title = "Plot A: Violin plot for Diamond Prices")

###
diamonds %>% 
  gf_violin(price ~ cut,
            draw_quantiles = c(0,.25,.50,.75)) %>% 
  gf_labs(title = "Plot B: Price by Cut")

###
diamonds %>% 
  gf_violin(price ~ cut, 
             fill = ~ cut, 
             color = ~ cut,
             alpha = 0.3,
            draw_quantiles = c(0,.25,.50,.75)) %>% 
  gf_labs(title = "Plot C: Price by Cut")

###
diamonds %>% 
  gf_violin(price ~ cut, 
             fill = ~ cut, 
             colour = ~ cut,             
             alpha = 0.3,draw_quantiles = c(0,.25,.50,.75)) %>% 
  gf_facet_wrap(vars(clarity)) %>%
  gf_labs(title = "Plot D: Price by Cut facetted by Clarity") %>%
  gf_theme(theme(axis.text.x = element_text(angle = 45,hjust = 1)))


## Set graph theme
theme_set(new = theme_custom())
##

diamonds %>% ggplot() + 
  geom_violin(aes(y = price, x = ""),
              draw_quantiles = c(0,.25,.50,.75)) + # note: y, not x
  labs(title = "Plot A: violin for Diamond Prices")

###
diamonds %>% ggplot() + 
  geom_violin(aes(cut, price),
              draw_quantiles = c(0,.25,.50,.75)) + 
  labs(title = "Plot B: Price by Cut")

###
diamonds %>% ggplot() + 
  geom_violin(aes(cut, price, 
                  color = cut, fill = cut),
              draw_quantiles = c(0,.25,.50,.75),
              alpha = 0.4) +
  labs(title = "Plot C: Price by Cut")

###
diamonds %>% ggplot() + 
  geom_violin(aes(cut, 
                   price, 
                   color = cut, fill = cut), 
              draw_quantiles = c(0,.25,.50,.75),
              alpha = 0.4)  +  
  facet_wrap(vars(clarity)) +
  labs(title = "Plot D: Price by Cut facetted by Clarity") +
  theme(axis.text.x = element_text(angle = 45,hjust = 1))


race_df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/race.csv")
rank_df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/ultra_rankings.csv")


glimpse(race_df)
glimpse(rank_df)


skim(race_df)


skim(rank_df)


# inspect(race_df) # does not work with hms and difftime variables
inspect(rank_df)


race_df %>% count(country) %>% arrange(desc(n))
rank_df %>% count(nationality) %>% arrange(desc(n))


rank_df %>% 
  filter(rank %in% c(1,2,3)) %>%
  count(nationality) %>% arrange(desc(n))


longest_races <- race_df %>%
  slice_max(n = 5, order_by = distance) # Longest distance races
longest_races

longest_races %>%
  left_join(., rank_df, by  = "race_year_id") %>% # total participants in longest 4 races
  filter(rank %in% c(1:10)) %>% # Top 10 ranks
  count(nationality) %>% arrange(desc(n))



## Set graph theme
theme_set(new = theme_custom())
##

rank_df %>%
  gf_histogram(~ time_in_seconds, bins = 75) %>%
  gf_labs(title = "Histogram of Race Times")



## Set graph theme
theme_set(new = theme_custom())
##

race_df %>%
  gf_histogram(~ distance, bins =  50) %>%
  gf_labs(title = "Histogram of Race Distances")


race_df %>%
  filter(distance == 0)


race_times <- race_df %>%
  count(start_time) %>% arrange(desc(n))
race_times


# Demo purposes only!

## Set graph theme
theme_set(new = theme_custom())
##

race_start_factor <- race_df %>%
  mutate(
    start_day_time =
      case_when(
        start_time > hms("02:00:00") &
          start_time <= hms("06:00:00") ~ "early_morning",
        
        start_time > hms("06:00:01") &
          start_time <= hms("10:00:00") ~ "late_morning",
        
        start_time > hms("10:00:01") &
          start_time <= hms("14:00:00") ~ "mid_day",
        
        start_time > hms("14:00:01") &
          start_time <= hms("18:00:00") ~ "afternoon",
        
        start_time > hms("18:00:01") &
          start_time <= hms("22:00:00") ~ "evening",
        
        start_time > hms("22:00:01") &
          start_time <= hms("23:59:59") ~ "night",
        
        start_time >= hms("00:00:00") &
          start_time <= hms("02:00:00") ~ "postmidnight",
        
        .default =  "other"
      )
  ) %>%
  mutate(start_day_time = 
           as_factor(start_day_time) %>%
           fct_collapse(.f = ., 
               night = c("night", "postmidnight")))
##
# Join with rank_df
race_start_factor %>%
  left_join(rank_df, by = "race_year_id") %>%
  drop_na(time_in_seconds) %>%
  gf_histogram(
    ~ time_in_seconds,
    bins = 75,
    fill = ~ start_day_time,
    color = ~ start_day_time,
    alpha = 0.5
  ) %>%
  gf_facet_wrap(vars(start_day_time), ncol = 2, scales = "free_y") %>%
  gf_labs(title = "Race Times by Start-Time")


pop <- read_csv("data/populations.csv")
pop
inspect(pop)


## Set graph theme
theme_set(new = theme_custom())
##

##
gf_histogram(~ value, data = pop, title = "Long Tailed Histogram") 
##
gf_density(~ value, data = pop, title = "Long Tailed Density")


## Set graph theme
theme_set(new = theme_custom())
##

gf_histogram(~ log10(value), data = pop, title = "Histogram with Log transformed x-variable") 
##
gf_density(~ log10(value), data = pop, title = "Density with Log transformed x-variable")


library(TeachHist)

## Set graph theme
theme_set(new = theme_custom())
##

p1 <- TeachHistDens(Mean = 60, Sd = 5)
p3 <- TeachHistDens(Mean = 10, Sd = 5)
p2 <- TeachHistDens(Mean = 60, Sd = 15)
p4 <- TeachHistDens(Mean = 10, Sd = 15)



library(usedthese)
used_here()


#scan_packages()
cite_packages(
  output = "table",
  out.dir = ".",
  out.format = "html",
  pkgs = c("ggridges", "NHANES", "TeachHist",
           "TeachingDemos", "visualize")
) %>%
  knitr::kable(format = "simple")

