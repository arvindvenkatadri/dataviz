# Codebook — Group 1 — Clinic bodies

**Spine:** Who is well in the clinic, who is labelled ill, and where does infant death still sit on the map?

### Panel A

heartdisease clinic Quants + Sex/HeartDisease for grouping

*n* = 303 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `Age` | Quant | 41 unique, 0 NA |
| `Sex` | Qual | 2 unique, 0 NA |
| `BP` | Quant | 50 unique, 0 NA |
| `Cholesterol` | Quant | 152 unique, 0 NA |
| `MaximumHR` | Quant | 91 unique, 0 NA |
| `HeartDisease` | Qual | 2 unique, 0 NA |

### Panel B

same people, Quals only

*n* = 303 rows, 5 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `Sex` | Qual | 2 unique, 0 NA |
| `ChestPain` | Qual | 4 unique, 0 NA |
| `BloodSugar` | Quant-looking — check levels; may be Qual | 2 unique, 0 NA |
| `ExerciseInducedAngina` | Qual | 2 unique, 0 NA |
| `HeartDisease` | Qual | 2 unique, 0 NA |

### Panel C

openintro infmortrate — country infant mortality; join to rnaturalearth by country name

*n* = 222 rows, 2 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 222 unique, 0 NA |
| `inf_mort_rate` | Quant | 218 unique, 0 NA |


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
