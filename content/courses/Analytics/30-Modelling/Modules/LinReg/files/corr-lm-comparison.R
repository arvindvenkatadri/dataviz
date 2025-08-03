library(tidyverse)
library(mosaic)
library(broom)
library(ggformula)

## Using mpg data
## Comparing correlation coefficients with Regression Coefficients
mpg_cty_corr <- mpg %>% 
  select(where(is.numeric), - cty) %>% 
  map(., cor.test, y = mpg $cty) %>% 
  map_dfr(tidy, .id = "term")
mpg_cty_corr

mpg_cty_lm <- lm(data = mpg, cty ~ displ + cyl + hwy + year)
mpg_cty_lm %>% 
  tidy() %>% 
  filter(term != "(Intercept)") %>% 
  gf_col(estimate ~ term, fill = ~ term) %>% 

  gf_col(data = mpg_cty_corr, estimate ~ term, colour = "black", alpha = 0.2)

# Using diamonds data
diamonds_price_corr <- diamonds %>% 
  select(where(is.numeric), -price) %>% 
  map(., cor.test, y = diamonds$price) %>% 
  map_dfr(tidy, .id = "term")
diamonds_price_corr

diamonds_price_lm <- lm(data = diamonds, price ~ carat + depth + table)
diamonds_price_lm %>% 
  tidy() %>% 
  filter(term != "(Intercept)") %>% 
  gf_col(estimate ~ term, fill = ~ term)

  gf_col(data = diamonds_price_corr, estimate ~ term, colour = "black", alpha = 0.2)

  
  ## Diagnostic Plots
  
  diamonds_augmented <- diamonds_price_lm %>% augment()
  
  diamonds_augmented %>% 
    gf_point(.hat ~ .resid, color = ~ .cooksd * 10000)
  
  diamonds_augmented %>% gf_point(.resid ~ .fitted)
  
