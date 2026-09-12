---
title: "Notes to Myself"
subtitle: "10-day R studio — bricks, panels, AI pausing, data kits"
order: 500
date-modified: today
draft: true
format:
  html:
    toc: true
    toc-depth: 3
---

These notes (co-created with Grok) are a working brief for running *The Mad Hatter’s Guide* as a **10-full-day studio**, not as a self-paced textbook. Need to keep this page off the public nav (`draft: true`, or a private repo / unpublished Quarto project). Voice, peasants, and literary asides stay. They are rhythm.

---

# 1. How to read the site

Long pages are **quarries**, not lessons.

A *lesson* is a path you finish. A *quarry* (the stone pit, not the hunted animal) is a face you cut a block from. Take one brick — a bounding box, one OSM tag, one palette, one test — set it in the wall, leave the rest of the hillside standing. The risk is treating *The Grammar of Maps* or a colour chapter as something to “complete” in one sitting.

**PRIMM is the floor loop:** 
  - Predict → Run → Infer → Modify → Make. Broadcast any discovery immediately. 
  - A brick that does not appear in *their* panel does not count.

---

# 2. The wall is a polyptych

One dataset cannot carry every mark. A mosaic + chi-square wants two Quals. A histogram wants a Quant. A leaflet wants coordinates. Forcing one CSV to wear every geom is a category error.

**One site, several panels, one spine.**

A **panel** is a short PRIMM cycle with its own table:

1. See the table — case, Qual / Quant
2. Ask — one question *this* table can answer
3. Choose a mark — geom / map mark / test
4. Predict
5. Make — human brick, then optional one AI prompt
6. Say — caption + a sentence they will stand behind
7. Limit — what this panel cannot do

The **spine** is not “one dataset.” It is a place, a theme, or a role. Health works: *Who is well, who says they are well, and where does that show up?*

| Panel | Data shape | Mark / test |
| --- | --- | --- |
| A — Body / measure | Person-level Quant | Histogram, violin, means, two-sample / ANOVA |
| B — Opinion / category | Two+ Quals | Mosaic, stacked bar, chi-square / `prop.test` |
| C — Place | Area or points + geometry | Choropleth, symbol map, leaflet |

Quota for ten days: **three panels well**, plus a map if it earns its place. Do not open a fifth panel unless a table is hungry.

House rules:

- Same seven headings every panel, or PRIMM dissolves.
- Name the mismatch out loud when someone wants a histogram on a mosaic table.
- One spine sentence at the top of the site.
- Reuse people, not columns — two protocols can share a morning.
- One AI prompt per panel, after paper.

`BirthOrder` / student `Year` as Qual-that-looks-Quant: `StudentSurvey` in `Lock5withR` (own Data page). `PIN` is the local analogue, not that table.

---

# 3. AI: do not run Shark Tank live-coding

Shark Tank live-coding rewards a closed demo and, with Copilot / Claude, **who pastes a prompt fastest**. That selects nerve and fluency, not a pause.

Keep theatre. Change the scarce resource from the keyboard to **the prompt**.

## 25-minute “No Free Prompt”

1. **Constraint on the board** (2 min) — two variables, or one OSM layer, or one row of the Day 7 card.
2. **Paper** (5 min) — no AI, no R. Question, geom/mark/test, aesthetic map, what would make them wrong. If it is not on the sheet, they may not ask the model for it.
3. **Human brick** (8 min) — R on, AI off. Something that runs from a brick they already have. Ugly required.
4. **One prompt** (5 min) — paste under `## Prompt we actually used`. Chunk `ai_draft`, then `ours`. One line: it did / did not match the sheet because…
5. **Broadcast** (5 min) — predicted / human brick / what we accepted from the machine. One question only: *Point to the line you could explain to a first-year.* If they cannot, it comes out before Netlify.

Investment, if any, is a **steal-this**, not a score.

Variants: prompt quarantine (one oracle machine), translator pair (B rewrites what A reads aloud), broken AI output prepared before class, closed-screen predict.

Day 10 may wear shark costumes. The pitch is the **claim**, not the syntax.

---

# 4. Ten-day brick index

Each brick ≤ 15 minutes of introduction. Then play. Then walk.

Git/Netlify early and ugly (Day 2–3). If first publish is Day 9, the wall is a slideshow.

## Day 1 — What data even is

Evening: Quarto page + dataset + every column tagged Quant / Qual.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Tools on the bench | Chunk runs; ⌘/Ctrl + Enter | Render `hello.qmd` with their names |
| Sushi groups | A characteristic reorganises the room | 5 lines: what grouped you |
| Kandinsky nouns | Which abstracts are measurable | 8 nouns from the room; circle the variables |
| Nature of data | Row = case | Point at one row; name the case |
| Variable types | How many / what kind / who | Tag every column |
| Tidy data | Column / row / cell | Sketch a tidy version of a messy phone table |

**Steal-this cue:** first peasant who notices that a number (`BirthOrder`, `Year`, PIN) is still Qual.

## Day 2 — Look, then summarise

Evening: two plots + one summary. Git exists.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Inspect | Three questions the table can answer; one it cannot | Write them on the page |
| Grammar of a graph | Aesthetic ↔ variable; geom as metaphor | Same two variables, two geoms |
| First scatter / bar | One working plot from *their* Panel A table | Answers one question from Day 1 |
| Favstats | Mean / median / sd as description | “Typical X is …, but …” |
| Counts | A bar that is a count | Readable labels, not `Var1` |
| Git born | First commit | Push. Broken is allowed. |

**Steal-this cue:** first group that puts units in the axis title without being told.

## Day 3 — Groups and “compared to what?”

Evening: a grouped comparison. Netlify URL live.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Quantities | Amount with a scale | Quant vs Qual they care about |
| Groups | Split-apply as a design move | Same plot, faceted or filled so the story changes |
| Colour = Qual | Legend readable | Recolour by a category |
| Colour = Quant | Sequential vs diverging | Same plot, continuous colour; caption why |
| Netlify | Live URL | Paste it at the top of the page |
| Caption as claim | Title is a sentence | Rewrite the default variable-name title |

**Steal-this cue:** first peasant who refuses a rainbow scale on ordered data.

## Day 4 — Shape, change, share

Evening: one distribution + one change *or* part-to-whole. Palette named. Panel B may open here if the mark needs two Quals.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Distributions | Two geoms of the same Quant | Which lie do they prefer |
| Violins & groups | Shape and group together | A grouped violin/box that survives critique |
| Change | Time is not an accident | One line/area that makes *when* visible |
| Proportions | Stack / dodge / waffle / mosaic — on purpose | One part-to-whole on a table that has shares |
| Surveys | Likert as ordinal | Defend or refuse the mean |
| Palette contract | Why *this* palette on *this* wall | Wes / Dutch Masters / GoT / Rick & Morty / their own + two lines |

**Steal-this cue:** first group that annotates a single peak instead of colouring everything.

## Day 5 — Artful stuff (creepers)

Evening: type, annotation, highlight, scale on the panels they already have. No new dataset unless a table is stuck.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Colour with intent | Qual vs seq vs div as craft | Caption whether a colour-blind peasant can read it |
| Fonts | One display, one text | No third font |
| Annotate | A sentence *on the plot* | Not only in the prose |
| Highlight | Grey the field, colour the argument | A “this, not that” chart |
| Scales | Limits, log, %, ₹ | Fix one dishonest default from Days 2–4 |
| Patchwork | Two plots, one claim | Shared title that is the claim |

**Steal-this cue:** first peasant who uses annotation instead of a third colour.

## Day 6 — Space

Evening: one static map + one leaflet of a place they can walk to, **or** the health-kit county/country choropleth (Panel C).

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Map as mark | Choropleth vs cartogram vs symbol | Name the mark on an example |
| Bounding box | Klokan or `getbb` | A bbox for their neighbourhood *or* skip if Panel C is pre-joined `sf` |
| OSM tags | *One* key–value family | One layer, write `.gpkg`, do not hammer OSM |
| Points / lines / polygons | Pluck what they need | Plot it; caption the geometry |
| Static grammar | Roads + one more layer, or a rate choropleth | No default grey soup |
| Leaflet | Marker vs popup vs label; px vs metres | Their points + one honest popup |

Contours / Rapid Editor only if a table walks up to that ledge.

Space is a **section**, not a stub. Listing times lie; the labs are the quarry.

| Page | What it is | Studio use |
| --- | --- | --- |
| Space (hub) | Door | 2 minutes: we are going in here |
| Introduction to Maps | Marks: choropleth / cartogram / symbol | 1 brick |
| What is Vector Data? | Slides + CRS | 1 brick or homework |
| The Grammar of Maps | The quarry | 4–5 bricks on Day 6, not one sitting |
| Interactive Maps with leaflet | Second quarry | 2 bricks |
| Contour Maps | Optional ledge | Only if a table walks up to it |

**Steal-this cue:** first group that maps something they verified with their feet — or that refuses to choropleth a count.

## Day 7 — No free hunch

Projects are **same-day design research**: hunch in the morning, means / ANOVA / prop.test / chi-square in the afternoon. The project pages are prompts, not the method. I am in the room to stop cargo-cult *p*-values.

Ethics brick when the first campus survey starts: consent, no names on the Netlify site, subgroups large enough.

Morning: hunch, question type, sample, ethics, then collect **or** use the kit table that matches the card. Afternoon: the card, so ANOVA is not recited at every table.

**Hunch → question type → test**

| If the hunch is… | Type | Reach for |
| --- | --- | --- |
| A’s typical value ≠ B’s | Two means | Two-sample + both distributions |
| Three+ groups differ | Several means | ANOVA + grouped plot |
| More than half think X | One proportion | `prop.test` vs 0.5 (or their rate) |
| Two groups, different *rates* | Two proportions | `prop.test` on a 2×2 |
| Category vs category | Association | Chi-square + mosaic or stacked bar |
| “Looks bigger,” no group | Stop | EDA. No *p*-value on a vibe |

The card hangs on **only the panel that has the right variable types**.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Hunch as a sentence | A claim that could be false | One line on the wall |
| Question type | Mean / several means / proportion / association | Circle the type; do not pick the test yet |
| Sample | Who, how many, how they will not cheat | 6-line protocol |
| Ethics | Consent, no names, subgroups | One line in the Quarto |
| Match the card | Point at their row | “We used ___ because the question was ___” |
| Plot before *p* | Figure makes the test unsurprising | Comparison plot *above* the *p*-value |
| Uncertainty | Interval or plain language | A sentence a parent could read |

**Steal-this cue:** first peasant who changes the hunch after seeing the sample, and says so. First correct *mismatch* (wrong test) is announced and pinned on the card.

## Day 8 — Workflow as craft

Evening: Welcome / Data / Viz / Claim / Map. Commits a stranger could follow.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Quarto as document | YAML, sections, one reference | Contents = rooms of the wall |
| Replayable code | Paths, “run from here” (esp. OSM) | A classmate can run a chunk |
| Git as history | Messages that say *why* | Five commits that are not all `update` |
| AI as apprentice | One stuck brick, prompt kept | They must explain the chunk |
| Refactor | Kill the duplicate plot | Keep the one that argues |

**Steal-this cue:** first group whose commit message is a claim, not a file name.

## Day 9 — Compose

No new concept unless a table is stuck.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| The question, again | One spine sentence at the top | Delete pages that do not serve it |
| Argument order | Data → see → claim | A critic can walk the site |
| Creepers | Ornament that still points | Keep it only if it would be missed |
| Accessibility | Contrast; colour not the only channel | Greyscale *or* a second encoding |
| Critique | Claim first, syntax last | Three notes from another group; accept one |

**Steal-this cue:** a palette, annotation, or OSM tag from another table, credited on the page.

## Day 10 — Publish and stand behind it

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Netlify final | Working links | URL on the board |
| 90-second defence | Question, method, what they will *not* claim | Spoken |
| Limits | Sample, missingness, test not run | 5–8 lines |
| Gift | One steal-this | Palette / tag / annotation, with names |
| Close | Brick they will reuse outside this studio | One line in the README |

---

# 5. Health as spine — kits to distribute

NHANES will not grow a mosaic; GSS will not grow a BMI histogram; neither is a map. That is the point.

Say on Day 1: NHANES and GSS are **American** bodies and opinions. Panel C is where the world or India can enter.

Do not hand raw portals. Each group gets a folder: three `.rds` files, one-page codebook, 1,000–2,000 rows, NAs left in, **no survey weights** on Days 1–4 (footnote: not national estimates), Panel C pre-joined to `sf` or one-line `geoid` merge, a **forbidden list** (“do not histogram column X; it is Qual”).

## Sources

| Role | Object | Why |
| --- | --- | --- |
| Panel A | `NHANES` (CRAN) or `HDSinRdata::NHANESsample` | BMI, BP, cholesterol, diabetes, age, sex — English names, classroom-sized |
| Panel B | `gssr` one-year slice: `health`, `happy`, `sex`, `degree`, `race`, binned income, smoke | Mosaic quarry |
| Panel B alt | NHANES Qual-only cut: `HealthGen` × `Diabetes` × `SmokeNow` × `Education` | Same people as A, different columns; still no histogram of `HealthGen` |
| Panel C (US) | `countyhealthR` + county polygons | Obesity, smoking, uninsured, premature death as *rates* |
| Panel C (world) | `WDI` + `rnaturalearth` | Life expectancy, health spend, overweight |
| Panel C (tropics / India) | `malariaAtlas` points, pre-cached | Leaflet of surveys, not a US county |
| Panel C (India honest) | Pre-built NFHS-5 state table + India-state `sf` (`rdhs` is an API, not a Day-1 tool) | Stunting, anaemia, insurance, tobacco |

Optional light A: `openintro` / Lock5 birth-weight tables if a group must not touch NHANES.

## Group kits (same trajectory, different objects)

| Folder | A | B | C |
| --- | --- | --- | --- |
| `group-1-clinic-bodies` | heartdisease Quants (303) | same people, Quals | infant mortality by country |
| `group-2-risk-factors` | cardioRiskFactors, `sex`/`smok` recoded (998) | Scottish CVD, `cvd` as yes/no (8,804) | SOWC under-5 / infant mortality |
| `group-3-bodies-and-talk` | `bdims` body measures (NHANES stand-in, 507) | `gss2010` (degree × grass; `mntlhlth` is Quant) | gapminder 2007 world |
| `group-4-youth-risk` | yrbss Quants (13,583) | yrbss Quals | gapminder 2007 world |
| `group-5-failure-and-asia` | cardiac_failure, 0/1 recoded (299) | GSS7402 Quals + years of education | gapminder 2007 **Asia only** |

| File | Panel | Role |
| --- | --- | --- |
| `panel-A.csv` | A — body / measure | Histograms, violins, means, two-sample / ANOVA |
| `panel-B.csv` | B — category / talk | Mosaic, stacked bar, chi-square / prop.test |
| `panel-C.csv` | C — place | Join to `rnaturalearth` by country name; choropleth or symbol map |
| `README.md` | — | Spine, load code, forbidden list |
| `codebook-one-pager.md` | — | Column types, pair card, sources |

---

# 6. Steal-this strip (fill live)

| Day | Who | Brick they invented | Where it lives |
| --- | --- | --- | --- |
| 3 | | | |
| 5 | | | |
| 6 | | | |
| 7 | | | |

---

# 7. End-of-studio checklist

- [ ] Live Netlify site
- [ ] Spine sentence at the top
- [ ] At least two panels with fitted datasets (not one table in costume)
- [ ] Tidy data documented per panel
- [ ] Plots that argue; at least one annotated
- [ ] Palette contract
- [ ] A map **or** a written reason there is no map
- [ ] A test that matches the card, or explicit “EDA only”
- [ ] Limits
- [ ] Prompt log where AI was used
- [ ] One gift in the steal-this strip

---

# 8. Site chores (when there is time)

- A public-facing 10-day page is optional; this file can stay private.
- Honest times on the Space listing.
- Pin the hunch → type → test card next to Projects.
- Steal-this from previous batches on the public site, if I want broadcast to outlive the day.
- Fix the broken `cite_packages` chunk on What is Vector Data?
- Raster when I mean it, not as a running joke only.

Literary asides and “peasants” stay.
