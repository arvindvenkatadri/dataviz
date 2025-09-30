library(tidyverse)
library(mosaic)
library(ggformula)

#install.packages("remotes")
#library(remotes)
#remotes::install_github("wilkelab/ggridges")
library(ggridges)
library(skimr)
library(palmerpenguins) # Our new favourite dataset
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
library(downloadthis)


library(systemfonts)
library(showtext)
## Clean the slate
systemfonts::clear_local_fonts()
systemfonts::clear_registry()
##
showtext_opts(dpi = 96) #set DPI for showtext
sysfonts::font_add(family = "Alegreya",
  regular = "../../../../../../fonts/Alegreya-Regular.ttf",
  bold = "../../../../../../fonts/Alegreya-Bold.ttf",
  italic = "../../../../../../fonts/Alegreya-Italic.ttf",
  bolditalic = "../../../../../../fonts/Alegreya-BoldItalic.ttf")

sysfonts::font_add(family = "Roboto Condensed", 
  regular = "../../../../../../fonts/RobotoCondensed-Regular.ttf",
  bold = "../../../../../../fonts/RobotoCondensed-Bold.ttf",
  italic = "../../../../../../fonts/RobotoCondensed-Italic.ttf",
  bolditalic = "../../../../../../fonts/RobotoCondensed-BoldItalic.ttf")
showtext_auto(enable = TRUE) #enable showtext
##
theme_custom <- function(){ 
    font <- "Alegreya"   #assign font family up front
    
    theme_classic(base_size = 14, base_family = font) %+replace%    #replace elements we want to change
    
    theme(
      text = element_text(family = font),  #set base font family
      
      #text elements
      plot.title = element_text(                 #title
                   family = font,          #set font family
                   size = 24,                    #set font size
                   face = 'bold',                #bold typeface
                   hjust = 0,                    #left align
                   margin = margin(t = 5, r = 0, b = 5, l = 0)), #margin
      plot.title.position = "plot", 
      
      plot.subtitle = element_text(              #subtitle
                   family = font,          #font family
                   size = 14,                   #font size
                   hjust = 0,                   #left align
                   margin = margin(t = 5, r = 0, b = 10, l = 0)), #margin
      
      plot.caption = element_text(               #caption
                   family = font,          #font family
                   size = 9,                     #font size
                   hjust = 1),                   #right align
      
      plot.caption.position = "plot",            #right align
      
      axis.title = element_text(                 #axis titles
                   family = "Roboto Condensed",  #font family
                   size = 12),                   #font size
      
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
  family = "Roboto Condensed",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)
)

## Set the theme
theme_set(new = theme_custom())


read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  filter(No == "1") %>% 
  tt(theme = "striped")
  


lincoln_weather %>% 
  gf_density_ridges_gradient(Month ~ `Max Temperature [F]`,
                             group = ~ Month) %>% 
  gf_refine(scale_fill_viridis_c(name = "Temperature [F]", 
                                 option = "B")) %>% 
  gf_labs(title = "Weather in Lincoln, Nebraska")


glimpse(penguins)


skim(penguins)


inspect(penguins)

# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# penguins <- penguins %>% drop_na()
# 
# gf_density( ~ body_mass_g, data = penguins) %>%
#   gf_labs(title = "Plot A: Penguin Masses", caption = "ggformula")
# 



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# penguins %>% gf_density( ~ body_mass_g,
#                          fill = ~ species,
#                          color = "black") %>%
#   gf_refine(scale_color_viridis_d(option = "magma",
#                                   aesthetics = c("colour", "fill"))) %>%
#   gf_labs(title = "Plot B: Penguin Body Mass by Species",
#           caption = "ggformula")



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# penguins %>%
#   gf_density(
#     ~ body_mass_g,
#     fill = ~ species,
#     color = "black",
#     alpha = 0.3
#   ) %>%
#   gf_facet_wrap(vars(sex)) %>%
#   gf_labs(title = "Plot C: Penguin Body Mass by Species and facetted by Sex", caption = "ggformula")



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# penguins %>%
#   gf_density( ~ body_mass_g, fill = ~ species, color = "black") %>%
#   gf_facet_wrap(vars(sex), scales = "free_y", nrow = 2) %>%
#   gf_labs(title = "Plot D: Penguin Body Mass by Species and facetted by Sex",
#           subtitle = "Free y-scale",
#           caption = "ggformula") %>%
#   gf_refine(scale_fill_brewer(palette = "Set1")) %>%
#   gf_theme(theme(axis.text.x = element_text(angle = 45,
#                                             hjust = 1)))
# 



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# ## Remove the rows containing NA (11 rows!)
# penguins <- penguins %>% drop_na()
# 
# ggplot(data = penguins) +
#   geom_density(aes(x = body_mass_g)) +
#   labs(title = "Plot A: Penguin Masses",caption = "ggplot")



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# penguins %>%
#   ggplot() +
#   geom_density(aes(x = body_mass_g, fill = species), alpha = 0.3,
#                    color = "black") +
#   scale_color_brewer(palette ="Set1",
#                         aesthetics = c("colour", "fill")) +
#   labs(title = "Plot B: Penguin Body Mass by Species",
#        caption = "ggplot")



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# penguins %>% ggplot() +
#   geom_density(aes(x = body_mass_g, fill = species),
#                    color = "black",
#                    alpha = 0.3) +
#   facet_wrap(vars(sex)) +
#   labs(title = "Plot C: Penguin Body Mass by Species and facetted by Sex",caption = "ggplot")



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# penguins %>% ggplot() +
#   geom_density(aes(x = body_mass_g, fill = species),
#                    alpha = 0.3,
#                    color = "black") +
#   facet_wrap(vars(sex), scales = "free_y", nrow = 2) +
#   labs(title = "Plot D: Penguin Body Mass by Species and facetted by Sex",
#        subtitle = "Free y-scale", caption = "ggplot") +
#   scale_fill_brewer(palette = "Set1") +
#   theme(theme(axis.text.x = element_text(angle = 45,hjust = 1)))
# 



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# gf_density_ridges(drv ~ hwy, fill = ~ drv,
#                   alpha = 0.5, # colour saturation
#                   rel_min_height = 0.005, # separation between plots
#                   data = mpg) %>%
#   gf_refine(scale_y_discrete(expand = c(0.01, 0)),
#             scale_x_continuous(expand = c(0.01, 0)),
#             scale_fill_brewer(name = "Drive Type",
#                               palette = "Spectral")) %>%
#   gf_labs(title = "Ridge Plot", x = "Highway Mileage",
#           y = "Drive Type")
# 



# # ggplot2::theme_set(new = theme_classic(base_family = "Roboto Condensed")) # Set consistent graph theme
# 
# gf_density_ridges(drv ~ hwy, fill = ~ drv,
#                   alpha = 0.5, # colour saturation
#                   rel_min_height = 0.005, data = mpg) %>%
#   gf_refine(scale_y_discrete(expand = c(0.01, 0)),
#             scale_x_continuous(expand = c(0.01, 0)),
#             scale_fill_brewer(name = "Drive Type",
# palette = "Spectral")) %>%
#   gf_labs(title = "Ridge Plot", x = "Highway Mileage",
#           y = "Drive Type")
# 




library(rtrek)
star_trek_books <- stBooks
star_trek_books %>% download_this(output_name = "star_trek_books", output_extension = ".csv", button_label = "Start Trek Book data", button_type = "default", icon = "fa fa-save")



library(resampledata3)
data(MathAnxiety)
MathAnxiety %>% 
 download_this(output_name = "MathAnxiety", output_extension = ".csv", button_label = "Math Anxiety data", button_type = "default", icon = "fa fa-save")


library(usedthese)
used_here()


#scan_packages()
cite_packages(
  output = "table",
  out.dir = ".",
  out.format = "html",
  pkgs = c("ggridges", "NHANES", "TeachHist",
           "TeachingDemos", "visualize", "tinytable", "tinyplot", "tidyplots")
) %>%
  knitr::kable(format = "simple")

