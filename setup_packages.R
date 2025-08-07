# Package Installation Script for DataViz Website
# Run this script to install all required packages for fonts and themes

cat("Installing required packages for DataViz website...\n")

# List of required packages
required_packages <- c(
  "ggplot2",        # Core plotting
  "showtext",       # Google Fonts integration
  "sysfonts",       # Font system interface  
  "ggtext",         # Enhanced text rendering
  "systemfonts",    # System font access
  "tidyverse",      # Data manipulation and visualization
  "palmerpenguins", # Dataset used in examples
  "scico",          # Color palettes
  "ggforce",        # Additional ggplot2 functionality
  "kableExtra",     # Table formatting
  "magick",         # Image processing
  "patchwork"       # Combining plots
)

# Function to install packages if not already installed
install_if_missing <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing", pkg, "...\n")
      install.packages(pkg, dependencies = TRUE)
    } else {
      cat(pkg, "is already installed.\n")
    }
  }
}

# Install packages
install_if_missing(required_packages)

cat("\nTesting font setup...\n")

# Test the theming
tryCatch({
  source("theming/roboto_theme.R")
  cat("Font and theme setup completed successfully!\n")
}, error = function(e) {
  cat("Warning: There was an issue with font setup:", e$message, "\n")
  cat("Please check your internet connection and try again.\n")
})

cat("\nSetup complete! You can now use the DataViz website modules.\n")