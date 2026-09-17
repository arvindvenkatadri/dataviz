# Group 7 — ERCP trial and the Americas

**Spine sentence** (top of the Quarto site):

> Does a simple pill change post-procedure pancreatitis, who is in that trial, and where in the Americas is life long?

## What is in this folder

| File | Panel | Role |
| --- | --- | --- |
| `panel-A.csv` | A — body / measure | Histograms, violins, means, two-sample / ANOVA |
| `panel-B.csv` | B — category / talk | Mosaic, stacked bar, chi-square / prop.test |
| `panel-C.csv` | C — place | Join to `rnaturalearth` by country name |
| `codebook-one-pager.md` | — | Types, pair card, sources |
| `studio-wall.qmd` | — | Quarto shell |

## Load

```r
library(readr)
A <- read_csv("panel-A.csv")
B <- read_csv("panel-B.csv")
C <- read_csv("panel-C.csv")
```


## Forbidden list

- Do not histogram `rx`, `outcome`, or `site`.
- Do not average treatment or gender.
- Do not treat this RCT like an observational smoke-and-BMI table.
- Do not choropleth population counts.
- Do not run ANOVA on Panel B.
- One AI prompt per panel, after paper.



## Sources

- `medicaldata::indo_rct` — Elmunzer et al., RCT of rectal indomethacin for post-ERCP pancreatitis
- gapminder 2007, Americas subset
- Via Rdatasets (Arel-Bundock)

