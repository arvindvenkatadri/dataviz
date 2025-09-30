library(tidyverse)
library(mosaic) # Our all-in-one package
library(skimr) # Looking at data
library(janitor) # Clean the data
library(naniar) # Handle missing data
library(visdat) # Visualise missing data
library(tinytable) # Printing Static Tables for our data
library(DT) # Interactive Tables for our data
library(crosstable) # Multiple variable summaries



library(checkdown)
library(epoxy)
library(explore) # fake data generation
library(grateful)
##
library(downloadthis)
##
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

    theme_bw(base_size = 10) + 
    
    theme_sub_axis(title = element_text(family = "Roboto Condensed", 
                                       size = 8),
                   text = element_text(family = "Roboto Condensed", 
                                       size = 6)) + 
    
    theme_sub_legend(text = element_text(family = "Roboto Condensed", 
                                         size = 6),
                     title = element_text(family = "Alegreya", 
                                          size = 8)) + 
    
    theme_sub_plot(title = element_text(family = "Alegreya", 
                                        size = 14, face = "bold"),
                   title.position = "plot",
                   subtitle = element_text(family = "Alegreya", 
                                           size = 10),
                   caption = element_text(family = "Alegreya", 
                                          size = 6),
                   caption.position = "plot")
    
}

## Use available fonts in ggplot text geoms too!
ggplot2::update_geom_defaults(geom = "text", new = list(
  family = "Roboto Condensed",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)
)
ggplot2::update_geom_defaults(geom = "label", new = list(
  family = "Roboto Condensed",
  face = "plain",
  size = 3.5,
  color = "#2b2b2b"
)
)

## Set the theme
ggplot2::theme_set(new = theme_custom())

## tinytable options
options("tinytable_tt_digits" = 2)
options("tinytable_format_num_fmt" = "significant_cell")
options(tinytable_html_mathjax = TRUE)


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
  tt(notes = "SOURCE: U.S. Department of Education, National Center for Education Statistics, Program for the International Assessment of Adult Competencies (PIAAC), U.S. PIAAC 2017, U.S. PIAAC 2012/2014.", 
     width = c(5,1,1,1,1,1), digits = 3) %>% 
  theme_html(class = "table table-hover table-striped table-condensed") %>% 
  setNames(c("Year", "Below Level #1", "Level #1", "Level #2", "Level #3", "Levels #4 and #5")) %>% 
  style_tt(i = 1:2,background = "red", color = "white")


docVisits <- read_csv("https://vincentarelbundock.github.io/Rdatasets/csv/AER/DoctorVisits.csv")
glimpse(docVisits)


docVisits_modified <- docVisits %>%
  
  # Replace common NA strings and numbers with actual NA
  naniar::replace_with_na_all(condition = ~.x %in% common_na_strings) %>% 
  naniar::replace_with_na_all(condition = ~.x %in% common_na_numbers) %>% 
  
  # Clean variable names
  janitor::clean_names(case = "snake") %>% # clean names
  
  # Convert character variables to factors
  mutate(gender = as_factor(gender),
         private = as_factor(private),
         freepoor = as_factor(freepoor),
         freerepat = as_factor(freerepat),
         nchronic = as_factor(nchronic),
         lchronic = as_factor(lchronic)) %>%
  
  # arrange the character variables first
  dplyr::relocate(where(is.factor), .after = rownames)


docVisits_modified %>% glimpse()


docVisits_modified %>%
  DT::datatable(
    caption = htmltools::tags$caption(
      style = 'caption-side: top; text-align: left; color: black; font-size: 150%;',
      'Doctor Visits Dataset (Clean)'
    ),
    options = list(pageLength = 10, autoWidth = TRUE)
  ) %>%
  DT::formatStyle(
    columns = names(docVisits_modified),
    fontFamily = 'Roboto Condensed',
    fontSize = '12px'
  )


docVisits_modified %>% dplyr::glimpse() 



docVisits_modified %>% skimr::skim()


inspect_output <- docVisits_modified %>% mosaic::inspect()
inspect_output[[1]] %>% tt()
inspect_output[[2]] %>% tt()


## Counting by the obvious factor variables
docVisits_modified %>% dplyr::count(gender) %>% tt()


docVisits_modified %>% dplyr::count(freepoor) %>% tt()


docVisits_modified %>% 
  dplyr::count(across(.cols = c(freepoor, lchronic))) %>% tt()



docVisits %>% count(across(where(is.character))) %>% tt()


# Single Variable, Single Summary
docVisits %>% 
  dplyr::summarise(mean_income = mean(income, na.rm = T))



# Single Variable, Multiple Summaries
docVisits_modified %>% 
  dplyr::summarise(mean_visits = mean(visits, na.rm = T),
                   sd_visits = sd(visits, na.rm = T),
                   min_visits = min(visits, na.rm = T),
                   max_visits = max(visits, na.rm = T)
                   )

# Multiple Variables, Multiple Summaries
docVisits_modified %>% 
  dplyr::summarise(across(.cols = c(visits, income), # select columns
                          
      .fns = list(mean = ~ mean(., na.rm = T), 
                  sd = sd, 
                  min = min, 
                  max = max)
                          )
                   )



docVisits_modified %>%
  group_by(gender) %>% 
  summarize(average_visits = mean(visits), count = n())
##
docVisits_modified %>% 
  group_by(freepoor,nchronic) %>% 
  summarise(mean_income = mean(income),
            average_visits = mean(visits),
            count = n())


#library(crosstable)
crosstable(visits + income ~ gender + freepoor, 
           data = docVisits_modified) %>% 
  crosstable::as_flextable()



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
  pkgs = c("janitor", "mosaic", "skimr", "CardioDataSets", "NeuroDataSets", "crosstable", "Lock5withR", "Lock5Data")
) %>%
  knitr::kable(format = "simple")

