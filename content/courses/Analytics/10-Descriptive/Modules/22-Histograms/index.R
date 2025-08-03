library(tidyverse)
library(mosaic)
library(ggformula)
library(skimr)
##
library(crosstable) # Fast stats for multiple variables in table form
##
library(tidyplots) # Easily Produced Publication-Ready Plots
library(tinyplot) # Plots with Base R
library(tinytable) # Elegant Tables for our data

## ggplot theme
# library(hrbrthemes)
# hrbrthemes::import_roboto_condensed() # Import Roboto Condensed font for use in charts
# hrbrthemes::update_geom_font_defaults() #Update matching font defaults for text geoms
# ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme

library(checkdown)
library(epoxy)
library(TeachHist)
library(TeachingDemos)
library(visualize) # Plot Densities, Histograms and Probabilities as areas under the curve
library(grateful)
library(MKdescr)
library(shinylive) # To create a Shiny app in a Quarto HTML doc
# Will not work if webr is also used in the SAME Quarto doc!

library(downloadthis)
#devtools::install_github("mccarthy-m-g/embedr")
library(embedr) # Embed multimedia in HTML files

## Import all fonts from project "fonts" directory
systemfonts::add_fonts("../../../../../../fonts/")

theme_av <- function(){ 
    font <- "Alegreya"   #assign font family up front
    
    theme_classic(base_size = 20, base_family = "Alegreya") %+replace%    #replace elements we want to change
    
    theme(
      
      #text elements
      plot.title = element_text(                 #title
                   family = "Alegreya",          #set font family
                   size = 18,                    #set font size
                   face = 'bold',                #bold typeface
                   hjust = 0,                    #left align
                   vjust = 2),                   #raise slightly
      
      plot.title.position = "plot", 
      
      plot.subtitle = element_text(              #subtitle
                   family = "Alegreya",          #font family
                   size = 14),                   #font size
      
      plot.caption = element_text(               #caption
                   family = "Alegreya",          #font family
                   size = 9,                     #font size
                   hjust = 1),                   #right align
      
      plot.caption.position = "plot",            #right align
      
      axis.title = element_text(                 #axis titles
                   family = "Roboto Condensed",  #font family
                   size = 10),                   #font size
      
      axis.text = element_text(                  #axis text
                   family = "Roboto Condensed",  #font family
                   size = 9),                    #font size
      
      axis.text.x = element_text(                #margin for axis text
                    margin = margin(5, b = 10))
      
      #since the legend often requires manual tweaking 
      #based on plot content, don't define it here
    )
}

## Use available fonts in ggplot text geoms too!
update_geom_defaults(geom = "text",new = list(
  family = "Alegreya",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)
)

## Set the theme
theme_set(new = theme_av())

read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  filter(No == "1") %>% 
  tt(theme = "striped")
  

glimpse(diamonds)


skim(diamonds)


inspect(diamonds)


# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# gf_histogram(~ price, data = diamonds) %>%
#   gf_labs(title = "Plot 1A: Diamond Prices",
#           caption = "ggformula")



# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# ## More bins
# gf_histogram(~ price, data = diamonds,
#              bins = 100) %>%
#   gf_labs(title = "Plot 1B: Diamond Prices",
#           caption = "ggformula")
# 



#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


ggplot(data = diamonds) + 
  geom_histogram(aes(x = price)) +
  labs(title = "Plot 1A: Diamond Prices",
       caption = "ggplot")
## More bins
ggplot(data = diamonds) + 
  geom_histogram(aes(x = price), bins = 100) +
  labs(title = "Plot 1B: Diamond Prices",
       caption = "ggplot")


# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# diamonds %>%
#   gf_histogram(~ carat) %>%
#   gf_labs(title = "Plot 2A: Carats of Diamonds",
#           caption = "ggformula")



# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# ## More bins
# diamonds %>%
#   gf_histogram(~ carat,
#   bins = 100) %>%
#   gf_labs(title = "Plot 2B: Carats of Diamonds",
#           caption = "ggformula")



#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme

diamonds %>% 
  ggplot() + 
  geom_histogram(aes(x = carat)) + 
  labs(title = "Plot 2A: Carats of Diamonds",
          caption = "ggplot")
## More bins
diamonds %>% 
  ggplot() + 
  geom_histogram(aes(x = carat), bins = 100) + 
  labs(title = "Plot 2A: Carats of Diamonds",
          caption = "ggplot")


# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# ##
# gf_histogram(~ price, fill = ~ cut, data = diamonds) %>%
#   gf_labs(title = "Plot 3A: Diamond Prices",caption = "ggformula")



# ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# diamonds %>%
#   gf_histogram(~ price, fill = ~ cut, color = "black", alpha = 0.3) %>%
#   gf_labs(title = "Plot 3B: Prices by Cut",
#           caption = "ggformula")



# 
# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# diamonds %>%
#   gf_histogram(~ price, fill = ~ cut, color = "black", alpha = 0.3) %>%
#   gf_facet_wrap(~ cut) %>%
#   gf_labs(title = "Plot 3C: Prices by Filled and Facetted by Cut",
#           caption = "ggformula") %>%
#   gf_theme(theme(
#            axis.text.x = element_text(angle = 45,
#            hjust = 1)))



# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# diamonds %>%
#   gf_histogram(~ price, fill = ~ cut, color = "black", alpha = 0.3) %>%
#   gf_facet_wrap(~ cut, scales = "free_y", nrow = 2) %>%
#   gf_labs(title = "Plot 3D: Prices Filled and Facetted by Cut",
#           subtitle = "Free y-scale",
#           caption = "ggformula") %>%
#   gf_theme(theme(axis.text.x =
#            element_text(angle = 45,
#            hjust = 1)))



#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme

diamonds %>% ggplot() + 
  geom_histogram(aes(x = price, fill = cut), alpha = 0.3) + 
  labs(title = "Plot 3A: Prices by Cut", caption = "ggplot")
##
diamonds %>% 
  ggplot() + 
  geom_histogram(aes(x = price, fill = cut), 
                 colour = "black", alpha = 0.3) + 
  labs(title = "Plot 3B: Prices filled by Cut", caption = "ggplot")
##
diamonds  %>% ggplot() + 
  geom_histogram(aes(price, fill = cut),
                 colour = "black", alpha = 0.3) +
  facet_wrap(facets = vars(cut)) + 
  labs(title = "Plot 3C: Prices by Filled and Facetted by Cut",
       caption = "ggplot") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
##
diamonds  %>% ggplot() + 
  geom_histogram(aes(price, fill = cut), 
                 colour = "black", alpha = 0.3) +
  facet_wrap(facets = vars(cut), scales = "free_y") +
  labs(title = "Plot D: Prices by Filled and Facetted by Cut",
       subtitle = "Free y-scale",
       caption = "ggplot") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# install.packages("shiny")
# library(shiny)
# runExample("01_hello")      # an interactive histogram
# 

race_df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/race.csv")
rank_df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/ultra_rankings.csv")


glimpse(race_df)
glimpse(rank_df)


skim(race_df)


skim(rank_df)


# inspect(race_df) # does not work with hms and difftime variables
inspect(rank_df)


race_df %>% 
  favstats(~ distance, data = .)
##
race_df %>% 
  favstats(~ participants, data = .)
##
rank_df %>% 
  drop_na() %>% 
  favstats(time_in_seconds ~ gender, data = .)


## library(crosstable)
crosstable(time_in_seconds + age ~ gender, data = rank_df) %>% 
  crosstable::as_flextable()

race_df %>% count(country) %>% arrange(desc(n)) %>% top_n(3, n)
rank_df %>% count(nationality) %>% arrange(desc(n)) %>% top_n(6, n)


rank_df %>% 
  filter(rank %in% c(1,2,3)) %>%
  count(nationality) %>% arrange(desc(n)) %>% top_n(6, n)


longest_races <- race_df %>%
  slice_max(n = 5, order_by = distance) %>%  # Longest distance races
  select (race_year_id, country, distance) # Select only relevant columns)
longest_races

### Now join this with the `rank_df` dataset
longest_races %>%
  left_join(., rank_df, by  = "race_year_id") %>% # total participants in longest 4 races
  filter(rank %in% c(1:10)) %>% # Top 10 ranks
  count(nationality) %>% arrange(desc(n))


# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# ##
# 
# rank_df %>%
#   gf_histogram(~ time_in_seconds, bins = 75) %>%
#   gf_labs(title = "Histogram of Race Times")
# 



# #ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# race_df %>%
#   gf_histogram(~ distance, bins =  50) %>%
#   gf_labs(title = "Histogram of Race Distances")
# 

#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme

race_df %>%
  gf_histogram(~ distance, bins =  50) %>%
  gf_labs(title = "Histogram of Race Distances")


race_df %>%
  filter(distance == 0)


race_times <- race_df %>%
  count(start_time) %>% arrange(desc(n))
race_times


# Demo purposes only!

#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


race_start_factor <- race_df %>%
  filter(distance == 0) %>%  # Races that actually took place
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


#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


##
gf_histogram(~ value, data = pop, title = "Long Tailed Histogram") 
##
gf_density(~ value, data = pop, title = "Long Tailed Density")


#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


gf_histogram(~ log10(value), data = pop, title = "Histogram with Log transformed x-variable") 
##
gf_density(~ log10(value), data = pop, title = "Density with Log transformed x-variable")


# Build dataset with different distributions
library(hrbrthemes)

#ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme

data <- data.frame(
  type = c( rep("edge peak", 1000), rep("comb", 1000), rep("normal", 1000), rep("uniform", 1000), rep("bimodal", 1000), rep("skewed", 1000) ),
  value = c( rnorm(900), rep(3, 100), rnorm(360, sd=0.5), rep(c(-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75), 80), rnorm(1000), runif(1000), rnorm(500, mean=-2), rnorm(500, mean=2), abs(log(rnorm(1000))) )
)

# Represent it
data %>%
  ggplot( aes(x=value)) +
    geom_histogram(fill="#69b3a2", color="#e9ecef", alpha=0.9) +
    facet_wrap(~type, scale="free_x") +
    theme_ipsum() +
    theme(
      panel.spacing = unit(0.1, "lines"),
      axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank()
    )

library(TeachHist)

ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


p1 <- TeachHistDens(Mean = 60, Sd = 5, VLine1 = 70, AxisFontSize = 14)
xpnorm(mean = 60, sd = 5, q = 70)
# p3 <- TeachHistDens(Mean = 10, Sd = 5)
# p2 <- TeachHistDens(Mean = 60, Sd = 15)
# xpnorm(mean = 60, sd = 15, q = 70)
# # p4 <- TeachHistDens(Mean = 10, Sd = 15)



library(TeachHist)

ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme


# p1 <- TeachHistDens(Mean = 60, Sd = 5,VLine1 = 70)
# xpnorm(mean = 60, sd = 5, q = 70)
# p3 <- TeachHistDens(Mean = 10, Sd = 5)
p2 <- TeachHistDens(Mean = 60, Sd = 15, VLine1 = 70,AxisFontSize = 14)
xpnorm(mean = 60, sd = 15, q = 70)
# # p4 <- TeachHistDens(Mean = 10, Sd = 15)



library(usedthese)
used_here()


embedr::embed_audio("../../../../../materials/audio/Quantities.wav")

#scan_packages()
cite_packages(
  output = "table",
  out.dir = ".",
  out.format = "html",
  pkgs = c("crosstable","ggridges", "NHANES", "TeachHist",
           "TeachingDemos", "visualize")
) %>%
  knitr::kable(format = "simple")

