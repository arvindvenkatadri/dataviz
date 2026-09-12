# Codebook — Group 6 — Acute coronary syndrome and Africa

**Spine:** Who arrives in acute coronary crisis, which habits travel with that crisis, and where in Africa is life short?

### Panel A

age, BMI, EF, TC, LDLC, HDLC, TG are Quant. obesity and sex are Quals for split.

*n* = 857 rows, 11 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `age` | Quant | 59 unique, 0 NA |
| `sex` | Qual | 2 unique, 0 NA |
| `height` | Quant | 50 unique, 93 NA |
| `weight` | Quant | 75 unique, 91 NA |
| `BMI` | Quant | 467 unique, 93 NA |
| `EF` | Quant | 285 unique, 134 NA |
| `TC` | Quant | 198 unique, 23 NA |
| `LDLC` | Quant | 183 unique, 24 NA |
| `HDLC` | Quant | 68 unique, 23 NA |
| `TG` | Quant | 253 unique, 15 NA |
| `obesity` | Qual | 2 unique, 0 NA |

### Panel B

smoking × sex, DM × HBP, Dx × cardiogenicShock. Do not histogram smoking.

*n* = 857 rows, 8 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `sex` | Qual | 2 unique, 0 NA |
| `cardiogenicShock` | Qual | 2 unique, 0 NA |
| `entry` | Qual | 2 unique, 0 NA |
| `Dx` | Qual | 3 unique, 0 NA |
| `obesity` | Qual | 2 unique, 0 NA |
| `DM` | Qual | 2 unique, 0 NA |
| `HBP` | Qual | 2 unique, 0 NA |
| `smoking` | Qual | 3 unique, 0 NA |

### Panel C

Africa-only lifeExp / gdpPercap / pop. Same join brick as other map panels.

*n* = 52 rows, 6 columns.

| Column | Inferred type | Notes |
| --- | --- | --- |
| `country` | Qual | 52 unique, 0 NA |
| `continent` | Qual | 1 unique, 0 NA |
| `year` | Quant-looking — check levels; may be Qual | 1 unique, 0 NA |
| `lifeExp` | Quant | 52 unique, 0 NA |
| `pop` | Quant | 52 unique, 0 NA |
| `gdpPercap` | Quant | 52 unique, 0 NA |


## Pair card (Day 1 brick)

| Pair | Legal question | First mark | Later test (kit first, campus later) |
| --- | --- | --- | --- |
| Quant + Qual (2 levels) | Does amount differ by kind? | Two violins | Two-sample comparison |
| Quant + Qual (3+ levels) | Do kinds have different amounts? | Grouped violin | ANOVA |
| Qual + Qual | Are kinds entangled? | Mosaic | Chi-square / two proportions |
| One Qual vs “more than half” | Is this share rare? | Bar / waffle | One proportion |
| Quant + Quant | How do two amounts move? | Scatter | Not a Day-7 campus hunch unless they insist |


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
