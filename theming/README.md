# Font and Theme Setup for DataViz Website

This directory contains the theming configuration for the DataViz website to ensure consistent fonts and ggplot2 themes across all modules.

## Requirements

To use the custom fonts and themes, you need to install the following R packages:

```r
# Install required packages
install.packages(c(
  "ggplot2",
  "showtext", 
  "sysfonts",
  "ggtext",
  "systemfonts"
))
```

## How It Works

1. The `roboto_theme.R` file is automatically sourced when you start R (via `.Rprofile`)
2. It downloads and configures Google Fonts to match the website's CSS
3. Sets up a consistent ggplot2 theme using these fonts
4. Handles graceful fallbacks when packages or fonts aren't available

## Fonts Used

- **Roboto Condensed**: Main text, axes, legends
- **Vollkorn**: Plot titles  
- **Fraunces**: Decorative elements
- **Fira Code**: Code blocks and monospace text
- **Open Sans**: General text

## Troubleshooting

### Fonts Not Loading
If you see "Required font packages not available" messages:
1. Install the packages listed above
2. Restart your R session
3. Check internet connectivity (fonts are downloaded from Google)

### Column Name Errors
If you see errors about missing columns like `bill_len` or `bill_dep`:
- Use the correct Palmer Penguins column names:
  - `bill_length_mm` (not `bill_len`)
  - `bill_depth_mm` (not `bill_dep`) 
  - `body_mass_g` (not `body_mass`)

### Theme Not Applied
If plots don't use the custom theme:
1. Ensure ggplot2 is installed and loaded
2. Check that the theme was loaded without errors
3. Try manually applying: `+ roboto_theme()`

## Manual Setup

If automatic loading doesn't work, you can manually source the theme:

```r
source("theming/roboto_theme.R")
```