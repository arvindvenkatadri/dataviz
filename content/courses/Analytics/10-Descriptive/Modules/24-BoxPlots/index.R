options(paged.print = TRUE)
library(tidyverse)
library(mosaic)
library(ggformula)
library(palmerpenguins) # Our new favourite dataset


library(checkdown)
library(epoxy)
library(grateful)
library(MKdescr)
library(shinylive) # To create a Shiny app in a Quarto HTML doc
# Will not work if webr is also used in the SAME Quarto doc!
library(sysfonts)
library(gfonts)
library(kableExtra)
# library(conflicted)
# conflicted::conflicts_prefer(dplyr::filter, dplyr::count, dplyr::last, dplyr::glimpse, base::max)
library(downloadthis)


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

read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  filter(No == "1" | No == "4") %>% 
  kbl() %>%
  kable_paper("hover", full_width = T)
  

set.seed(123)
MKdescr::illustrate.boxplot(rt(150, df = 10))


wages <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/stevedata/gss_wages.csv")


glimpse(wages)


skim(wages)


inspect(wages)

wages_clean <- 
  wages %>% 
  tidyr::drop_na(realrinc) # choose column or leave blank to choose all


# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  gf_boxplot(realrinc ~ "Income") %>% # Dummy X-axis "variable"
  gf_labs(title = "Plot 1A: Income has a skewed distribution",
          subtitle = "Many outliers on the high side")



# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(y = realrinc, x = "Income")) +  # Dummy X-axis "variable"
  labs(title = "Plot 1A: Income has a skewed distribution",
          subtitle = "Many outliers on the high side")

# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  gf_boxplot(gender ~ realrinc) %>% 
  gf_labs(title = "Plot 2A: Income by Gender")
##
wages_clean %>% 
  gf_boxplot(gender ~ log10(realrinc)) %>% 
  gf_labs(title = "Plot 2B: Log(Income) by Gender")
##
wages_clean %>% 
  gf_boxplot(gender ~ realrinc, fill = ~ gender) %>% 
  gf_refine(scale_x_log10()) %>% 
  gf_labs(title = "Plot 2C: Income filled by Gender, log scale")


# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(y = gender, x = realrinc)) +
  labs(title = "Plot 2A: Income by Gender")
##
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(y = gender, x = log10(realrinc))) + 
  labs(title = "Plot 2B: Log(Income) by Gender")
##
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(y = gender, x = realrinc, fill = gender)) +
  gf_refine(scale_x_log10()) +
  labs(title = "Plot 2C: Income filled by Gender, log scale")


# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  gf_boxplot(educcat ~ realrinc) %>% 
  gf_labs(title = "Plot 3A: Income by Education Category")
##
wages_clean %>% 
  gf_boxplot(educcat ~ log10(realrinc)) %>% 
  gf_labs(title = "Plot 3B: Log(Income) by Education Category")
##
wages_clean %>% 
  gf_boxplot(reorder(educcat, realrinc, FUN = median) ~ log(realrinc), 
             fill = ~ educcat,
             alpha = 0.3) %>% 
  gf_labs(title = "Plot 3C: Log(Income) by Education Category, sorted") %>% gf_labs(x = "Log Income", y = "Education Category")
##
wages_clean %>% 
  gf_boxplot(reorder(educcat, realrinc, FUN = median) ~ realrinc, 
             fill = ~ educcat,
             alpha = 0.5) %>% 
  gf_refine(scale_x_log10()) %>% 
  gf_labs(title = "Plot 3D: Income by Education Category, sorted",
          subtitle = "Log Income Scale") %>% 
  gf_labs(x = "Income", y = "Education Category")


# Set graph theme
theme_set(new = theme_custom())
#
wages_clean %>% 
  ggplot() +
  geom_boxplot(aes(realrinc, educcat)) + # (x,y) format
  labs(title = "Plot 3A: Income by Education Category")
##
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(log10(realrinc), educcat)) + 
  labs(title = "Plot 3B: Log(Income) by Education Category")
##
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(log(realrinc), 
                   reorder(educcat, realrinc, FUN = median), 
                   fill = educcat),
               alpha = 0.3) + 
  labs(title = "Plot 3C: Log(Income) by Education Category, sorted",
       x = "Log Income", y = "Education Category")
##
wages_clean %>% 
  ggplot() + 
  geom_boxplot(aes(realrinc, 
                   reorder(educcat, realrinc, FUN = median), 
                   fill = educcat),
               alpha = 0.3)+ 
  scale_x_log10() + 
  labs(title = "Plot 3D: Income by Education Category, sorted",
       subtitle = "Log Income Scale",
       x = "Income", y = "Education Category")


# Set graph theme
theme_set(new = theme_custom())
#
wages %>% 
  drop_na() %>% 
  gf_boxplot(reorder(educcat, realrinc) ~ log10(realrinc),
             fill = ~ educcat, 
             alpha = 0.5) %>% 
  gf_facet_wrap(vars(childs)) %>% 
  gf_refine(scale_fill_brewer(type = "qual", palette = "Dark2")) %>% 
  gf_labs(title = "Plot 4A: Log Income by Education Category and Family Size", x = "Log income", y = "No. of Children")
##
wages %>% 
  drop_na() %>% 
  mutate(childs = as_factor(childs)) %>% 
  gf_boxplot(childs ~ log10(realrinc),
             group = ~ childs,
             fill = ~ childs, 
             alpha = 0.5) %>% 
  gf_facet_wrap(~ gender) %>% 
  gf_refine(scale_fill_brewer(type = "qual", palette = "Set3")) %>% 
  gf_labs(title = "Plot 4B: Log Income by Gender and Family Size",
          x = "Log income",
          y = "No. of Children")


# Set graph theme
theme_set(new = theme_custom())
#
wages %>% 
  drop_na() %>%
  ggplot() + 
  geom_boxplot(aes(log10(realrinc), reorder(educcat, realrinc),
                   fill = educcat), # aes() closes here
               alpha = 0.5) + 
  facet_wrap(vars(childs)) +
  scale_fill_brewer(type = "qual", palette = "Dark2") + 
  labs(title = "Plot 4A: Log Income by Education Category and Family Size", x = "Log income", y = "No. of Children")
##
wages %>% 
  drop_na() %>% 
  mutate(childs = as_factor(childs)) %>% 
  ggplot() + 
  geom_boxplot(aes(log10(realrinc),childs,
                 group = childs,
                 fill = childs), # aes() closes here
             alpha = 0.5) +
  facet_wrap(vars(gender)) +
  scale_fill_brewer(type = "qual", palette = "Set3") + 
  labs(title = "Plot 4B: Log Income by Gender and Family Size",
          x = "Log income",
          y = "No. of Children")


ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")

ufo_sightings %>% download_this(output_name = "UFO", output_extension = ".csv", button_label = "UFO Sighting data", button_type = "default", icon = "fa fa-save")

detectors <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-07-18/detectors.csv")

detectors %>% download_this(output_name = "AI_Dectectors", output_extension = ".csv", button_label = "AI Dectector data", button_type = "default", icon = "fa fa-save")


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

