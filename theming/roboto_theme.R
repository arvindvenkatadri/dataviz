# Roboto Theme for ggplot2 and fonts setup
# This file sets up consistent theming across the dataviz website

# Function to safely load packages
safe_library <- function(package_name, quietly = TRUE) {
  if (requireNamespace(package_name, quietly = quietly)) {
    library(package_name, character.only = TRUE, quietly = quietly)
    return(TRUE)
  } else {
    message(paste("Package", package_name, "not found - some features may not work"))
    return(FALSE)
  }
}

# Load required libraries for theming
showtext_available <- safe_library("showtext")
ggplot2_available <- safe_library("ggplot2")
sysfonts_available <- safe_library("sysfonts")

# Add Google Fonts that are used throughout the site
# These should match the fonts referenced in the CSS files
if (sysfonts_available && showtext_available) {
  tryCatch({
    sysfonts::font_add_google("Roboto Condensed", "roboto-condensed")
    sysfonts::font_add_google("Vollkorn", "vollkorn")
    sysfonts::font_add_google("Fraunces", "fraunces")
    sysfonts::font_add_google("Fira Code", "fira-code")
    sysfonts::font_add_google("Open Sans", "open-sans")
    
    # Enable showtext for automatic font rendering
    showtext::showtext_auto()
    
    message("Fonts loaded successfully!")
    
  }, error = function(e) {
    message("Font loading failed: ", e$message)
    message("This may be due to internet connectivity or Google Fonts API issues")
    message("Plots will use default fonts instead")
  })
} else {
  message("Required font packages not available - using default fonts")
}

# Set up a consistent ggplot2 theme using Roboto Condensed
roboto_theme <- function(base_size = 12, base_family = "roboto-condensed") {
  if (!ggplot2_available) {
    message("ggplot2 not available - theme function defined but not usable")
    return(function() NULL)
  }
  
  # Use fallback font if roboto-condensed not available
  available_families <- if (sysfonts_available) sysfonts::font_families() else c("sans")
  theme_family <- if (base_family %in% available_families) base_family else "sans"
  title_family <- if ("vollkorn" %in% available_families) "vollkorn" else theme_family
  
  theme_minimal(base_size = base_size, base_family = theme_family) +
    theme(
      # Text elements
      plot.title = element_text(family = title_family, size = base_size * 1.5, 
                               face = "bold", color = "#204a87"),
      plot.subtitle = element_text(family = theme_family, size = base_size * 1.1, 
                                  color = "grey30"),
      plot.caption = element_text(family = theme_family, size = base_size * 0.8, 
                                 color = "grey30", margin = margin(t = 15)),
      
      # Axis elements
      axis.title = element_text(family = theme_family, size = base_size),
      axis.text = element_text(family = theme_family, size = base_size * 0.9),
      axis.ticks = element_line(color = "grey92"),
      axis.ticks.length = unit(.5, "lines"),
      
      # Legend elements
      legend.title = element_text(family = theme_family, size = base_size),
      legend.text = element_text(family = theme_family, 
                                size = base_size * 0.9, color = "grey30"),
      
      # Panel elements
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey95", linewidth = 0.2),
      
      # Strip text for facets
      strip.text = element_text(family = theme_family, size = base_size, 
                               face = "bold")
    )
}

# Set the theme as default if ggplot2 is available
if (ggplot2_available) {
  theme_set(roboto_theme())
  
  # Update geom defaults to use appropriate fonts for text geoms
  available_families <- if (sysfonts_available) sysfonts::font_families() else c("sans")
  text_family <- if ("roboto-condensed" %in% available_families) "roboto-condensed" else "sans"
  
  update_geom_defaults("text", list(family = text_family))
  update_geom_defaults("label", list(family = text_family))
  
  message("ggplot2 theme set successfully!")
}

# Print available font families for debugging
if (sysfonts_available) {
  message("Available font families: ", paste(sysfonts::font_families(), collapse = ", "))
} else {
  message("Using system default fonts")
}