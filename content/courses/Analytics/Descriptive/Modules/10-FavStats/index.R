library(mosaic) # Our all-in-one package
library(skimr) # Looking at data
library(tinytable) # Printing Tables for our data
library(tidyverse)


library(checkdown)
library(epoxy)
library(explore) # fake data generation
library(grateful)
# library(conflicted)
# conflicts_prefer(dplyr::filter, dplyr::last, dplyr::glimpse, base::max)
library(downloadthis)
#devtools::install_github("mccarthy-m-g/embedr")
library(embedr) # Embed multimedia in HTML files


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
    '%+replace%' <- ggplot2::'%+replace%' # nolint
        
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


literacy <- readxl::read_xlsx("../../../../../materials/Data/US_literacy_SETables.xlsx",sheet = "S1",skip = 3) %>% 
  select(-c(2,3),-contains("S.E.")) %>% 
  rename("Numbers" = `...1`,
         "BelowLevel1" = `Estimate...4`,
         "Level1" = `Estimate...6`,
         "Level2" = `Estimate...8`,
         "Level3" = `Estimate...10`,
         "Level4/5" = `Estimate...12`) %>% 
  filter(str_detect(pattern = "Number",Numbers))

literacy %>% 
  kbl(caption = "US Population: Reading and Numeracy Levels", digits = 2,
      align = "c",centering = T,
      col.names = c("Year", "Below Level #1", "Level #1", "Level #2", "Level #3", "Levels #4 and #5")) %>% 
  kable_paper(full_width = F, html_font = "Noto") %>% 
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), position = "float_right") %>% 
  column_spec(2:4, bold = T) %>%
  row_spec(1:2, bold = T, color = "white", background = "#D7261E") %>% 
    footnote(general = "SOURCE: U.S. Department of Education, National Center for Education Statistics, Program for the International Assessment of Adult Competencies (PIAAC), U.S. PIAAC 2017, U.S. PIAAC 2012/2014.")

read_csv("../../../../../materials/Data/pronouns.csv") %>% 
  #filter(No == "1") %>% 
  kbl() %>%
  kable_paper(c("striped","hover","responsive"), full_width = T)
  

# mpg %>%
#   head(10) %>%
#   tt(theme = c("striped")) %>%
#   setNames(c("Manufacturer", "Model", "Engine\nDisplacement",
#                     "Model\n Year", "Cylinders", "Transmission",
#                     "Drivetrain", "City\n Mileage", "Highway\n Mileage",
#                     "Fuel", "Class\nOf\nVehicle"))
# 

mpg %>% 
  head(10) %>%
  kbl(
    # add Human Readable column names
    col.names = c("Manufacturer", "Model", "Engine\nDisplacement", 
                    "Model\n Year", "Cylinders", "Transmission",
                    "Drivetrain", "City\n Mileage", "Highway\n Mileage",
                    "Fuel", "Class\nOf\nVehicle"), 
    caption = "MPG Dataset") %>%
  kable_styling(bootstrap_options = c("striped", "hover", 
                                      "condensed", "responsive"),
                full_width = F, position = "center")


glimpse(mpg)


skimr::skim(mpg) # explicitly stating package name


inspect(mpg)


# 
# mpg_describe <- inspect(mpg)
# mpg_describe$categorical
# mpg_describe$quantitative
# 

mpg_modified <- mpg %>% 
  dplyr::mutate(cyl = as_factor(cyl),
                fl = as_factor(fl),
                drv = as_factor(drv),
                class = as_factor(class),
                trans = as_factor(trans))
glimpse(mpg_modified)


# From Vincent Arel-Bundock's dataset website
# https://vincentarelbundock.github.io/Rdatasets
# 
# read_csv can read data directly from the net
# Don't use read.csv()
docVisits <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/AER/DoctorVisits.csv")


# docVisits <- read_csv("data/DoctorVisits.csv")
# 

docVisits %>%
  head(10) %>%
  kbl(caption = "Doctor Visits Dataset",
      # Add Human Readable Names if desired
      # col.names(..names that you may want..)
      ) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover",
                          "condensed", "responsive"),
    full_width = F, position = "center")


glimpse(docVisits)

skim(docVisits) %>% kbl()

inspect(docVisits)

docVisits_modified <-  docVisits %>% 
  mutate(gender = as_factor(gender),
         private = as_factor(private),
         freepoor = as_factor(freepoor),
         freerepat = as_factor(freerepat),
         nchronic = as_factor(nchronic),
         lchronic = as_factor(lchronic))
docVisits_modified

mpg_modified %>% dplyr::count(cyl)
mpg_modified %>% mosaic::count(drv) # does the same thing! Counts!
mpg_modified %>% count(fl)

### All combinations of cut, color, clarity
### Overwhelming??
mpg_modified %>% 
  count(across(where(is.factor)))


## Counting by the obvious factor variables
docVisits %>% count(gender)
docVisits %>% count(private)
docVisits %>% count(freepoor)
docVisits %>% count(freerepat)
docVisits %>% count(lchronic)
docVisits %>% count(nchronic)


# Now for all Combinations...
# Maybe too much to digest...
docVisits %>% count(across(where(is.character)))
# Shall we try counting by some variables that might be factors?
# Even if they are labeled as <dbl>?
# 
docVisits %>% count(illness)
docVisits %>% count(health)


mpg_modified %>% 
  group_by(cyl) %>% 
  summarize(average_hwy = mean(hwy), count = n())

mpg_modified %>% 
  group_by(cyl, fl) %>% 
  summarize(average_hwy = mean(hwy), count = n())

# Perhaps the best method for us!
mpg_modified %>% 
  mosaic::favstats(hwy ~ cyl, data = .) # Don't use fav_stats with formula!!!

# Be aware of the first column format here!
mpg_modified %>% 
  mosaic::favstats(hwy ~ cyl + fl, data = .) # Don't use fav_stats with formula!!!


docVisits_modified %>%
  group_by(gender) %>% 
  summarize(average_visits = mean(visits), count = n())
##
docVisits_modified %>%
  group_by(gender) %>% 
  summarize(average_visits = mean(visits), count = n())
##
docVisits_modified %>% 
  group_by(freepoor,nchronic) %>% 
  summarise(mean_income = mean(income),
            average_visits = mean(visits),
            count = n())
##
docVisits_modified %>% 
  mosaic::favstats(income ~ gender, data = .) # Don't use fav_stats with formula!!!
##
docVisits_modified %>% 
  mosaic::favstats(income ~ freepoor + nchronic, data = .) # Don't use fav_stats with formula!!!


mpg %>%
  head(10) %>% 
  tt(theme = c("striped")) %>%
  setNames(c("Manufacturer", "Model", "Engine\nDisplacement", 
                    "Model\n Year", "Cylinders", "Transmission",
                    "Drivetrain", "City\n Mileage", "Highway\n Mileage",
                    "Fuel", "Class\nOf\nVehicle")) 


mpg %>% 
  head(10) %>%
  kbl(col.names = c("Manufacturer", "Model", "Engine\nDisplacement", 
                    "Model\n Year", "Cylinders", "Transmission",
                    "Drivetrain", "City\n Mileage", "Highway\n Mileage",
                    "Fuel", "Class\nOf\nVehicle"), 
      longtable = FALSE, centering = TRUE,
      caption = "MPG Dataset") %>%
    kable_styling(bootstrap_options = c("striped", "hover", 
                                        "condensed", "responsive"),
                  full_width = F, position = "center")



skim(mpg) %>%
  kbl(align = "c", caption = "Skim Output for mpg Dataset") %>%
kable_paper(full_width = F)
  


library(rtrek)
star_trek_books <- stBooks
star_trek_books %>% download_this(output_name = "star_trek_books", output_extension = ".csv", button_label = "Start Trek Book data", button_type = "default", icon = "fa fa-save")



library(resampledata3)
data(MathAnxiety)
MathAnxiety %>% 
 download_this(output_name = "MathAnxiety", output_extension = ".csv", button_label = "Math Anxiety data", button_type = "default", icon = "fa fa-save")


embedr::embed_audio("../../../../../materials/audio/Summaries.wav")

library(usedthese)
used_here()


#scan_packages()
cite_packages(
  output = "table",
  out.dir = ".",
  out.format = "html",
  pkgs = c("mosaic", "palmerpenguins", "skimr")
) %>%
  knitr::kable(format = "simple")

