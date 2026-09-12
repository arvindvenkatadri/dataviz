---
title: "My 10-Day Studio Index"
subtitle: "Brick by Brick — The Mad Hatter’s Guide"
author: "Arvind V."
date-modified: today
format:
  html:
    toc: true
    toc-depth: 3
---
# Introduction

This R-based Studio is 10 FULL days of studio work. Herein I describe how I will conduct the Studio and use the content on this webpage, and what performance I would like to see from the students. 

# Another Brick in the Wall
I intend to use a "Brick by Brick" approach, where a new concept, or a piece of code, are introduced for say 15 minutes max, and the students get to play while I walk around the class to meet them at individual group tables to clarify doubts. 
Any discovery made by the students is immediately announced and broadcast to all groups. 
My website here is a *catalog of bricks*: I will *not* cover everything in there, but just a chosen set of bricks described below. 
The students use these "bricks" to create their own metaphorical R based Analysis / Viz Wall, complete with creepers and Rick-Morty colour palettes, all using RStudio and Quarto + Github and Netlify.

# What is this Wall, anyhow?

The Wall represents their full productive output in this course: classwork, discoveries, demonstrated usage of bricks, commentary, and the assignments. The Wall they build will have a few *panels*: each panel will hold one dataset and will be used to perform a few EDA visualizations, some analysis, and interpretations as detailed below. 

The Wall and by extension, the panels, will also have an overarching domain/theme, called a *spine* ( of a book, peasants), so that all datasets belong in a certain area of human endeavour. This is to mimic their Y4 Projects, where they typically work in one domain and use the vocabulary from that one domain consistently through that project semester. Some sample spines are e.g.

  - Healthcare (FOSEDA 2026-2027 S1C2)
  - Ecology, Plants, Animals; Migration
  - Business, Trade, and Finance
  - Cuisine, Food and Drink, and Nutrition
  - Sports
  - Travel and Transportation
  - Natural Resources and Usage
  - ??

# What is a Panel?

A panel is a short PRIMM cycle with its own data, its own marks /geoms, and its own claim — same brick grammar every time:

1. **See the table** — what is a case, which columns are Qual / Quant
2. **Ask** — one question that this table can answer
3. **Choose a mark** — geom / map mark / test that matches the question
4. **Predict** — what they think they will see
5. **Make** — [human-made brick, then optional one AI prompt]{style="background-color:yellow;"}
6. **Say** — caption + one sentence they will stand behind
7. **Limit** — what this panel cannot do (often: “no Quant here, so no histogram”)

Peasants learn that the chart is not a costume you put on any spreadsheet.

# Method in Class

Each **brick** is at most **15 minutes of introduction** from me. Then they play. While I walk around the tables.

A discovery at one table is announced to the room and becomes a brick for everyone.

By the end of Day 10, **each group** has one Quarto site on GitHub + Netlify: an analysis / viz wall, with creepers, a colour palette that is *theirs*, and at least one claim they can defend.

**Rule of the wall:** a brick that does not appear in *their* question, *their* data, or *their* map does not count.

My Literary asides and calling them “peasants” stay. They are part of my rhythm. So there. 

---

Each panel is a different cut of that spine. Example spine: How do people use this campus?









































PanelData shapeMark / testWhy it cannot be the other panelA — How long is a thingOne QuantHistogram / violin / favstatsNo groups requiredB — Who vs whoQuant + QualBox / grouped violin; two-sample or ANOVAHistogram alone hides the splitC — Share of a wholeOne or two QualsWaffle / stacked / mosaicNo honest histogramD — Are two categories entangledTwo Quals, countsMosaic + chi-squareMeans would be a category errorE — WherePoints / lines / polygonsStatic map + leafletCampus-as-drawing, not a bar


# Day-wise plan

- Days 1–2: Panel A (one Quant, look and summarise) — learn the panel template
- Days 3–4: Panel B or C (groups or shares) — same template, new table
- Day 5: dress both panels (type, colour, annotate) so the wall looks like one object
- Day 6: Panel E only if space is on the spine; otherwise skip
- Day 7: Panel D or a mean-comparison panel — the card chooses the test from that table
- Days 8–10: compose, do not add a fifth panel unless a table is hungry

*Introducing a new chart type means opening a new panel* with an appropriate dataset, not adding a geom to the wrong table. Need to say that out loud: “This brick needs a different *quarry* ( target to pursue ).”


# Day 1 — What data even is

**Wall by evening:** one Quarto page, one dataset they chose or were handed, variables named as Quant / Qual.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Tools on the bench | RStudio + Quarto file opens, one chunk runs, they know ⌘/Ctrl + Enter | Render `hello.qmd` with their names as the title |
| Sushi groups | A “characteristic” reorganises the room; they can say what *moved* | Write 5 lines: what grouped you, what would have grouped you differently |
| Kandinsky nouns | Concrete vs abstract; which abstracts are measurable | List 8 abstract nouns from the room; circle the ones that could become variables |
| Nature of data | Experiment vs observation; a row is a case | On their dataset, point to one row and say what the *case* is |
| Variable types | How many / what kind / who → Ratio, Interval, Ordinal, Nominal | Tag every column in their table as Quant or Qual (and subtype) |
| Tidy data | Column = variable, row = case, cell = value | Sketch the tidy shape of a messy table from their phones (timetable, expenses, Swiggy) |

**Steal-this cue:** first peasant who notices that a number (BirthOrder, Year, PIN) is still Qual from the dataset `StudentSurvey`.

---

# Day 2 — Look, then summarise

**Wall by evening:** two plots + one summary table on the Quarto page. Git repo exists, even if ugly.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Inspect | `glimpse`, `head`, missingness, “what would I ask this table?” | Three questions the data *could* answer; one it cannot |
| Grammar of a graph | Aesthetic ↔ variable; geom as metaphor | Same two variables, two different geoms; say which metaphor is honest |
| First scatter / bar | One working `gf_` / `ggplot` from their data | Plot that answers *one* of yesterday’s questions |
| Favstats | Mean, median, sd as *descriptions*, not verdicts | One sentence: “typical X is …, but …” |
| Counts | Tables of Qual variables; a bar that is a count | A count bar with readable labels, not default `Var1` |
| Git born | `git init` / GitHub repo / first commit | Push the Quarto page. Broken is allowed. |

**Steal-this cue:** first group that puts units in the axis title without being told.

---

# Day 3 — Groups, amounts, and “compared to what?”

**Wall by evening:** a grouped comparison. Netlify URL live (can be ugly).

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Quantities | A number that means amount; a plot that respects scale | One plot of a Quant vs a Qual they care about |
| Groups | Split-apply-combine as a design move, not a slogan | Same plot, faceted or filled by a group that changes the story |
| Colour = Qual | Default qualitative scale; legend that can be read | Recolour yesterday’s plot by a *categorical* variable |
| Colour = Quant | Sequential vs diverging; when a midpoint matters | Recolour the *same* plot by a continuous variable; caption why the scale type changed |
| Netlify | Drag-and-drop or Git-connected deploy | Paste the live URL at the top of the Quarto page |
| Caption as claim | Title + subtitle + caption do rhetorical work | Rewrite the title so it is a sentence, not a variable name |

**Steal-this cue:** first peasant who refuses a rainbow scale on ordered data.

---

# Day 4 — Shape, change, share

**Wall by evening:** one distribution, one change-over-time *or* one part-to-whole. Palette decision written down.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Distributions | Histogram / density / box as different lies | Two distribution geoms of the same variable; which lie do they prefer and why |
| Violins & groups | Shape *and* group on one canvas | A grouped violin or box that would survive a critique |
| Change | Time is not a category by accident | One line or area that makes a *when* visible |
| Proportions | Stack, dodge, waffle, mosaic — pick one on purpose | A part-to-whole of a Qual they collected or found |
| Surveys | Likert as ordinal, not a fake mean unless they argue | One survey-style plot; defend or refuse the mean |
| Palette contract | Name the palette and why it belongs on *this* wall | Apply one non-default palette (Wes, Dutch Masters, GoT, Rick & Morty, their own) and write two lines of justification |

**Steal-this cue:** first group that annotates a single peak instead of colouring everything.

---

# Day 5 — Artful stuff (the creepers)

**Wall by evening:** the page looks designed: type, annotation, highlight, scale. Creepers allowed.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Colour with intent | Brewer / paletteer; qual vs seq vs div again, now as craft | Swap palette; keep accessibility in the caption (can a colour-blind peasant read this?) |
| Fonts in ggplot | One display face, one text face; `showtext` if needed | Title in one family, axis in another — no ransom-note third font |
| Annotate | `annotate`, labels, a box around the thing that matters | One sentence *on the plot*, not only in the Quarto prose |
| Highlight | Grey the field, colour the point of argument | A “this, not that” version of an earlier chart |
| Scales | Axis limits, log or not, % and ₹ | Fix one dishonest default scale from Days 2–4 |
| Patchwork | Two plots as one argument | A two-panel figure with a shared title that is the claim |

**Steal-this cue:** first peasant who uses annotation instead of a third colour.

---

# Day 6 — Space (the city is a drawing)

**Wall by evening:** one static map and one leaflet of *their* place. Listing times on the site are a lie; the labs are the quarry.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Map as mark | Choropleth vs cartogram vs symbol — what is the mark doing? | Point at an example and name the mark |
| Bounding box | Klokan *or* `getbb("…, Bangalore")` | A bbox for a place they can walk to |
| OSM tags | One key–value family (amenity *or* highway *or* natural) | Download *one* layer; write `.gpkg`; do not hammer OSM |
| Points / lines / polygons | `pluck` the geometry they actually need | Plot that one layer; caption the geometry type |
| Grammar of a static map | `ggplot` + `geom_sf` *or* `tmap` — roads + one more layer | A dressed static map (no default grey soup) |
| Leaflet brick | Marker vs popup vs label; pixel radius vs metres | Interactive map with *their* points and one honest popup |

**Optional late brick (only if a table asks):** contours, or Rapid Editor so they add a missing bench to OSM.

**Steal-this cue:** first group that maps something they verified with their feet.

---

# Day 7 — No free hunch (morning field, afternoon claim)

**Wall by evening:** a written hunch, a sample, a plot, a test that matches the question, a sentence they will stand behind.

## Morning — design the hunt (bricks)

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Hunch as a sentence | Not a vibe. A claim that could be false | Write the hunch on the wall in one line |
| Question type | Mean difference / several means / proportion / association | Circle the type; do not pick the test yet |
| Sample | Who, how many, how they will not cheat the sample | A 6-line protocol: population, sample, question, recording sheet |
| Ethics brick | Consent, no names on the site, subgroups large enough | One line in the Quarto: how people were asked |

Then they collect. You walk. You do not lecture.

## Afternoon — the card (do not repeat ANOVA at every table)

**Hunch → question type → test**

| If the hunch is… | Question type | Reach for |
| --- | --- | --- |
| Group A’s typical value differs from Group B | Two means | Two-sample test + a plot of both distributions |
| Three or more groups differ (B.Des / B.Voc / B.Cra, three shows, …) | Several means | ANOVA + a grouped plot; then “which pairs?” only if they ask |
| More than half of peasants think X | One proportion | `prop.test` against 0.5 (or the rate they named) |
| Two groups have different *rates* (Art vs Design, tattoo yes/no by gender) | Two proportions | `prop.test` on a 2×2 |
| Category vs category (pronouns × college, …) | Association | Chi-square + a mosaic or stacked bar |
| “Looks bigger” with no group | Stop | That is EDA. Do not p-value a vibe |

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Match the card | They can point at the row of the card that is theirs | Write “we used ___ because the question was ___” |
| Plot before p | The figure should make the test unsurprising | The comparison plot *above* the p-value |
| Uncertainty | A interval or a plain-language “this could still be noise” | One sentence that a parent could read |
| Broadcast | First correct *mismatch* (“wrong test”) is announced | The mismatch becomes a sticky note on the card |

**Steal-this cue:** first peasant who changes the hunch after seeing the sample, and says so.

---

# Day 8 — Workflow as craft

**Wall by evening:** the site has a structure: Welcome, Data, Viz, Claim, Map. Commits that a stranger could follow.

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Quarto as document | YAML, sections, `embed` of figures, one bibliography item | A contents list that is the wall’s rooms |
| Code that can be replayed | Seed, data path, “run from here” notes (especially OSM) | A chunk a classmate can run without you |
| Git as history | Commit messages that say *why* | Five commits that are not all `update` |
| AI as apprentice | Prompt in English (or Kannada, Tamil, …) for *one* stuck brick | Paste the prompt and the chunk they kept; they must understand it |
| Refactor | Kill one duplicate plot; keep the one that argues | Before / after in the repo |

**Steal-this cue:** first group whose commit message is a claim, not a file name.

---

# Day 9 — Compose the wall

**No new concept unless a table is stuck.** You introduce a brick only on demand (facets, `ggrepel`, a better map tile, a pairwise test).

| Brick | 15-minute target | Make |
| --- | --- | --- |
| The question, again | One question at the top of the site | Delete pages that do not serve it |
| Argument order | Data → see → claim → map or test as needed | Reorder sections so a critic can walk them |
| Creepers | Ornament that still points | One decorative layer that would be missed if removed — or remove it |
| Accessibility pass | Contrast, alt text, colour not the only channel | A version that works in greyscale *or* a second encoding |
| Critique brick | 10 minutes per group, claim first, syntax last | Three notes from another group, one of which they accept |

**Steal-this cue:** a palette, annotation, or OSM tag from another table, credited on the page.

---

# Day 10 — Publish and stand behind it

| Brick | 15-minute target | Make |
| --- | --- | --- |
| Netlify final | Custom name, working links, rendered Quarto | Live URL on the board |
| The 90-second defence | Hunch or question, what they did, what they will not claim | Spoken, no slides required |
| Known limits | Sample, missingness, the test they did *not* run | A Limits section of 5–8 lines |
| Gift to the next batch | One steal-this | A palette snippet, a map tag, or an annotation trick, with their names |
| Close | What brick they will reuse in a studio that is not this one | One line in the README |

---

# Steal-this strip

*(Pin discoveries here as the days happen. Previous batches seed the first row.)*

| Day | Who | Brick they invented | Where it lives |
| --- | --- | --- | --- |
| 3 | — | — | — |
| 5 | — | — | — |
| 6 | — | — | — |
| 7 | — | — | — |

---

# Honest times for Space

The course listing understates the quarry. Use these as *studio* times, not reading times:

| Page | What it is | Studio use |
| --- | --- | --- |
| Space (hub) | Door, not a lesson | 2 minutes: “we are going in here” |
| Introduction to Maps | Marks: choropleth / cartogram / symbol | 1 brick |
| What is Vector Data? | Slides + CRS pointers | 1 brick or homework |
| The Grammar of Maps | The quarry | 4–5 bricks across Day 6, not one sitting |
| Interactive Maps with leaflet | Second quarry | 2 bricks |
| Contour Maps | Optional ledge | Only if a table walks up to it |

---

# End-of-studio checklist (the wall)

- [ ] Live Netlify site  
- [ ] Named question or hunch  
- [ ] Tidy data documented  
- [ ] At least three plots that argue, one of them annotated  
- [ ] A palette contract  
- [ ] A map of a place they could walk to **or** a clear reason there is no map  
- [ ] A test that matches the card, or an explicit “EDA only”  
- [ ] Limits  
- [ ] One gift in the steal-this strip  
