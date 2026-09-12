# Codebook — Group 4 — Youth risk + world wealth/health

**Spine:** What do teenagers’ bodies and habits look like, which habits travel together, and where is life long?

### Panel A

yrbss Quants: height, weight, activity days, sleep

*n* = 13,583 rows, 8 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant-looking — check levels; may be Qual | 7 unique, 77 NA |
| `gender` | Qual | 2 unique, 12 NA |
| `grade` | Qual | 5 unique, 79 NA |
| `height` | Quant | 34 unique, 1004 NA |
| `weight` | Quant | 239 unique, 1004 NA |
| `physically_active_7d` | Quant-looking — check levels; may be Qual | 8 unique, 273 NA |
| `strength_training_7d` | Quant-looking — check levels; may be Qual | 8 unique, 1176 NA |
| `school_night_hours_sleep` | Qual | 7 unique, 1248 NA |

### Panel B

yrbss Quals: helmet, texting, TV, race, gender, grade

*n* = 13,583 rows, 8 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant-looking — check levels; may be Qual | 7 unique, 77 NA |
| `gender` | Qual | 2 unique, 12 NA |
| `grade` | Qual | 5 unique, 79 NA |
| `hispanic` | Qual | 2 unique, 231 NA |
| `race` | Qual | 5 unique, 2805 NA |
| `helmet_12m` | Qual | 6 unique, 311 NA |
| `text_while_driving_30d` | Qual | 8 unique, 918 NA |
| `hours_tv_per_school_day` | Qual | 7 unique, 338 NA |

### Panel C

gapminder 2007 — ask a different question than Group 3 (e.g. gdpPercap vs lifeExp, or a symbol map of pop)

*n* = 142 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 142 unique, 0 NA |
| `continent` | Qual | 5 unique, 0 NA |
| `year` | Quant-looking — check levels; may be Qual | 1 unique, 0 NA |
| `lifeExp` | Quant | 142 unique, 0 NA |
| `pop` | Quant | 142 unique, 0 NA |
| `gdpPercap` | Quant | 142 unique, 0 NA |


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
