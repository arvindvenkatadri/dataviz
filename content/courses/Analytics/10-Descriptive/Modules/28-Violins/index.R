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

read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  filter(No == "1") %>% 
  kbl() %>%
  kable_paper("hover", full_width = T)
  

library(hrbrthemes)
data <- read.table("https://raw.githubusercontent.com/zonination/perceptions/master/probly.csv", header=TRUE, sep=",")

# Data is at wide format, we need to make it 'tidy' or 'long'
data <- data %>% 
  gather(key="text", value="value") %>%
  mutate(text = gsub("\\.", " ",text)) %>%
  mutate(value = round(as.numeric(value),0)) 

# %>%
#   filter(text %in% c("Almost Certainly","Very Good Chance","We Believe","Likely","About Even", "Little Chance", "Chances Are Slight", "Almost No Chance"))

# Plot
p <- data %>%
  mutate(text = fct_reorder(text, value)) %>% # Reorder data
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
    geom_violin(width=2.1, size=0.2) +
    scale_fill_viridis_d(aesthetics = c("colour", "fill")) +
    theme_ipsum() +
    theme(
      legend.position="none"
    ) +
    coord_flip() + # This switch X and Y axis and allows to get the horizontal version
    xlab("") +
    ylab("Assigned Probability (%)")
p

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

