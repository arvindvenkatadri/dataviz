# Codebook — Group 7 — ERCP trial and the Americas

**Spine:** Does a simple pill change post-procedure pancreatitis, who is in that trial, and where in the Americas is life long?

### Panel A

age and risk are Quant. gender, rx, outcome are Quals for split.

*n* = 602 rows, 5 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 62 unique, 0 NA |
| `risk` | Quant | 10 unique, 0 NA |
| `gender` | Qual | 2 unique, 0 NA |
| `rx` | Qual | 2 unique, 0 NA |
| `outcome` | Qual | 2 unique, 0 NA |

### Panel B

rx × outcome is the trial mosaic. site × outcome. Do not average rx.

*n* = 602 rows, 7 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `gender` | Qual | 2 unique, 0 NA |
| `rx` | Qual | 2 unique, 0 NA |
| `outcome` | Qual | 2 unique, 0 NA |
| `pep` | Qual | 2 unique, 0 NA |
| `status` | Qual | 2 unique, 0 NA |
| `type` | Qual | 4 unique, 0 NA |
| `site` | Qual | 4 unique, 0 NA |

### Panel C

Americas-only lifeExp / gdpPercap / pop. Same join brick as other map panels.

*n* = 25 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 25 unique, 0 NA |
| `continent` | Qual | 1 unique, 0 NA |
| `year` | Quant-looking — check levels; may be Qual | 1 unique, 0 NA |
| `lifeExp` | Quant | 25 unique, 0 NA |
| `pop` | Quant | 25 unique, 0 NA |
| `gdpPercap` | Quant | 25 unique, 0 NA |


## Pair card (Day 1 brick)

| Pair | Legal question | First mark | Later test (kit first, campus later) |
| --- | --- | --- | --- |
| Quant + Qual (2 levels) | Does amount differ by kind? | Two violins | Two-sample comparison |
| Quant + Qual (3+ levels) | Do kinds have different amounts? | Grouped violin | ANOVA |
| Qual + Qual | Are kinds entangled? | Mosaic | Chi-square / two proportions |
| One Qual vs “more than half” | Is this share rare? | Bar / waffle | One proportion |
| Same people, several conditions | Do shows / conditions differ *within* a person? | Paired boxes | Repeated-measures / Friedman — not ordinary ANOVA |


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
