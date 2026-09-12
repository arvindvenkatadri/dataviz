# Codebook — Group 5 — Heart failure + Asia map (India-facing stand-in)

**Spine:** Who dies after heart failure, who grew up poor in the GSS, and where in Asia is life short?

### Panel A

cardiac_failure recoded 0/1 to yes/no; Quants: age, ejection_fraction, serum_*, platelets, time

*n* = 299 rows, 13 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 47 unique, 0 NA |
| `anaemia` | Qual | 2 unique, 0 NA |
| `creatinine_phosphokinase` | Quant | 208 unique, 0 NA |
| `diabetes` | Qual | 2 unique, 0 NA |
| `ejection_fraction` | Quant | 17 unique, 0 NA |
| `high_blood_pressure` | Qual | 2 unique, 0 NA |
| `platelets` | Quant | 176 unique, 0 NA |
| `serum_creatinine` | Quant | 40 unique, 0 NA |
| `serum_sodium` | Quant | 27 unique, 0 NA |
| `sex` | Qual | 2 unique, 0 NA |
| `smoking` | Qual | 2 unique, 0 NA |
| `time` | Quant | 148 unique, 0 NA |
| `DEATH_EVENT` | Qual | 2 unique, 0 NA |

### Panel B

AER GSS7402 Quals + education-as-years (Quant). Do not average ethnicity.

*n* = 9,120 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `kids` | Quant | 9 unique, 0 NA |
| `education` | Quant | 21 unique, 0 NA |
| `ethnicity` | Qual | 2 unique, 0 NA |
| `city16` | Qual | 2 unique, 0 NA |
| `lowincome16` | Qual | 2 unique, 0 NA |
| `immigrant` | Qual | 2 unique, 0 NA |

### Panel C

gapminder 2007, Asia only — closest frozen stand-in for an NFHS/malaria map. Join to rnaturalearth. India is one row.

*n* = 33 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 33 unique, 0 NA |
| `continent` | Qual | 1 unique, 0 NA |
| `year` | Quant-looking — check levels; may be Qual | 1 unique, 0 NA |
| `lifeExp` | Quant | 33 unique, 0 NA |
| `pop` | Quant | 33 unique, 0 NA |
| `gdpPercap` | Quant | 33 unique, 0 NA |


## Pair card (Day 1 brick)

| Pair | Legal question | First mark | Later test (kit first, campus later) |
| --- | --- | --- | --- |
| Quant + Qual (2 levels) | Does amount differ by kind? | Two violins | Two-sample comparison |
| Quant + Qual (3+ levels) | Do kinds have different amounts? | Grouped violin | ANOVA |
| Qual + Qual | Are kinds entangled? | Mosaic | Chi-square / two proportions |
| One Qual vs “more than half” | Is this share rare? | Bar / waffle | One proportion |
| Quant + Quant | How do two amounts move? | Scatter | Not a Day-7 campus hunch unless they insist |


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
