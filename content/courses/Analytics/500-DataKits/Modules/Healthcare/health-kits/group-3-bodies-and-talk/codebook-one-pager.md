# Codebook — Group 3 — Bodies and talk (NHANES-shaped stand-in + GSS)

**Spine:** How do bodies measure, how do people talk about mind and school, and how long do countries live?

### Panel A

openintro bdims — body measures. Stand-in for NHANES if the NHANES package is not on the machine. sex recoded.

*n* = 507 rows, 7 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 44 unique, 0 NA |
| `weight_kg` | Quant | 245 unique, 0 NA |
| `height_cm` | Quant | 147 unique, 0 NA |
| `sex` | Qual | 2 unique, 0 NA |
| `waist_cm` | Quant | 274 unique, 0 NA |
| `hip_cm` | Quant | 209 unique, 0 NA |
| `chest_cm` | Quant | 263 unique, 0 NA |

### Panel B

openintro gss2010: degree × grass; mntlhlth is days of poor mental health (Quant) — do not mosaic it

*n* = 2,044 rows, 5 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `hrsrelax` | Quant | 18 unique, 890 NA |
| `mntlhlth` | Quant | 22 unique, 893 NA |
| `hrs1` | Quant | 72 unique, 872 NA |
| `degree` | Qual | 5 unique, 0 NA |
| `grass` | Qual | 2 unique, 785 NA |

### Panel C

gapminder 2007: lifeExp, gdpPercap, pop by country; join to rnaturalearth

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
