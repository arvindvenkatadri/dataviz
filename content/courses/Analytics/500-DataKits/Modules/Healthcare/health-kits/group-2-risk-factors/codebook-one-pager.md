# Codebook — Group 2 — Risk factors

**Spine:** How do bodies carry risk, how do class and smoke talk, and where do children still die young?

### Panel A

cardioRiskFactors recoded: sex and smok are factors, not numbers

*n* = 998 rows, 14 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 40 unique, 0 NA |
| `bmi` | Quant | 229 unique, 0 NA |
| `waisthip` | Quant | 561 unique, 0 NA |
| `smok` | Qual | 2 unique, 0 NA |
| `choles` | Quant | 71 unique, 0 NA |
| `trig` | Quant | 255 unique, 0 NA |
| `hdl` | Quant | 204 unique, 0 NA |
| `ldl` | Quant | 422 unique, 0 NA |
| `sys` | Quant | 115 unique, 0 NA |
| `dia` | Quant | 79 unique, 0 NA |
| `Uric` | Quant | 380 unique, 0 NA |
| `sex` | Qual | 2 unique, 0 NA |
| `alco` | Quant | 207 unique, 0 NA |
| `apoa` | Quant | 134 unique, 0 NA |

### Panel B

Scottish Health Survey 1998; area is a code — not a map

*n* = 8,804 rows, 7 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 57 unique, 0 NA |
| `sex` | Qual | 2 unique, 0 NA |
| `sc` | Quant-looking — check levels; may be Qual | 3 unique, 0 NA |
| `carstair` | Quant | 274 unique, 0 NA |
| `smoke` | Qual | 5 unique, 0 NA |
| `area` | Quant | 312 unique, 0 NA |
| `cvd` | Qual | 2 unique, 0 NA |

### Panel C

SOWC child mortality 2018 by country; join by country name

*n* = 195 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 195 unique, 0 NA |
| `under5_mortality_2018` | Quant | 73 unique, 0 NA |
| `infant_mortality_2018` | Quant | 64 unique, 0 NA |
| `neonatal_mortality_2018` | Quant | 41 unique, 0 NA |
| `under5_mortality_2018_male` | Quant | 73 unique, 0 NA |
| `under5_mortality_2018_female` | Quant | 70 unique, 0 NA |


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
