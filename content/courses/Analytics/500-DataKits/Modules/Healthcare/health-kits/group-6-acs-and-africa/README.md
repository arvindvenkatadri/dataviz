# Group 6 — Acute coronary syndrome and Africa

**Spine sentence** (top of the Quarto site):

> Who arrives in acute coronary crisis, which habits travel with that crisis, and where in Africa is life short?

## What is in this folder

| File | Panel | Role |
| --- | --- | --- |
| `panel-A.csv` | A — body / measure | Histograms, violins, means, two-sample / ANOVA |
| `panel-B.csv` | B — category / talk | Mosaic, stacked bar, chi-square / prop.test |
| `panel-C.csv` | C — place | Join to `rnaturalearth` by country name |
| `codebook-one-pager.md` | — | Column types, pair card, sources |
| `studio-wall.qmd` | — | Quarto shell: spine, intro, panel headings, conclusion |

## Pedagogy

Same seven headings every panel: See → Ask → Mark → Predict → Make → Say → Limit.

Kit first (Days 1–4). Matching test beside the matching chart on the kit (Days 3–4). Campus Free Hunch collected later (Day 7) using the **same pair type**.

Panel C has **no geometry**. In R:

```r
library(sf)
library(rnaturalearth)
world <- ne_countries(scale = "medium", returnclass = "sf")
```

## Load

```r
library(readr)
A <- read_csv("panel-A.csv")
B <- read_csv("panel-B.csv")
C <- read_csv("panel-C.csv")
```


## Forbidden list

- Do not histogram a yes/no, a 0/1, a diagnosis label, or a smoking status.
- Do not average Sex, Dx, smoking, obesity.
- Do not choropleth a count when a rate exists (lifeExp is not a count; pop is).
- Do not run ANOVA on Panel B.
- One AI prompt per panel, after paper, and only for a geom the codebook allows.



## Sources (cite on the Quarto site)

- CardioDataSets: acs_patients_df
- gapminder: gapminder (2007, Africa)
- Files pulled via Rdatasets (Arel-Bundock)

