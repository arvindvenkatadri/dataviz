# Group 3 — Bodies and talk (NHANES-shaped stand-in + GSS)

**Spine sentence** (top of the Quarto site):

> How do bodies measure, how do people talk about mind and school, and how long do countries live?

## What is in this folder

| File | Panel | Role |
| --- | --- | --- |
| `panel-A.csv` | A — body / measure | Histograms, violins, means, two-sample / ANOVA |
| `panel-B.csv` | B — category / talk | Mosaic, stacked bar, chi-square / prop.test |
| `panel-C.csv` | C — place | Join to `rnaturalearth` or `tmap::World` by country name; choropleth or symbol map |
| `codebook-one-pager.md` | — | Types, forbidden list, pair card |

## Pedagogy

Same seven headings every panel: See → Ask → Mark → Predict → Make → Say → Limit.

Kit first (Days 1–4). Matching test beside the matching chart on the kit (Days 3–4). Campus Free Hunch collected later (Day 7) using the **same pair type**, not a new procedure.

Panel C has **no geometry**. In R:

```r
library(sf)
library(rnaturalearth)
world <- ne_countries(scale = "medium", returnclass = "sf")
# join on country name; expect a few unmatched labels — that is a brick
```

## Load

```r
library(readr)
A <- read_csv("panel-A.csv")
B <- read_csv("panel-B.csv")
C <- read_csv("panel-C.csv")
```


## Forbidden list

- Do not histogram a yes/no, a 0/1, a chest-pain type, a grade, or a wealth-like code.
- Do not average Sex, ChestPain, degree, helmet, immigrant, ethnicity.
- Do not choropleth a count when a rate exists (infant mortality, under-5 mortality, lifeExp are rates or expectations — pop is a count).
- Do not run ANOVA on Panel B.
- Do not treat `area` in the Scottish file as a map.
- One AI prompt per panel, after paper, and only for a geom the codebook allows.



## Sources (cite on the Quarto site)

- CardioDataSets (Cáceres Rossi): heartdisease_tbl_df, cardioRiskFactors_df, scottish_CVD_df, cardiac_failure_df
- openintro: infmortrate, sowc_child_mortality, bdims, yrbss, gss2010
- gapminder: gapminder
- AER: GSS7402
- Files pulled via Rdatasets (Arel-Bundock)

NHANES and NFHS-5 / malariaAtlas were the preferred A and India-C objects. They are not in this zip because they need extra packages or an API. Group 3 A is a body-measure stand-in. Group 5 C is Asia-only gapminder, not district NFHS.


Also in this folder: `studio-wall.qmd` (spine, intro to our tables, seven headings per panel, conclusion).
