# Health kits for the 10-day studio

Seven groups. Same spine grammar, different objects.

| Folder | Spine cut | Panel A | Panel B | Panel C |
| --- | --- | --- | --- | --- |
| group-1-clinic-bodies | Clinic bodies — who is labelled ill | heartdisease Quants (303) | heartdisease Quals | infant mortality by country |
| group-2-risk-factors | Risk and class — smoke, lipids, deprivation | cardioRiskFactors, `sex`/`smok` recoded (998) | Scottish CVD, `cvd` as yes/no (8,804) | SOWC under-5 / infant mortality |
| group-3-bodies-and-talk | Measured bodies and survey talk | `bdims` body measures (NHANES stand-in, 507) | `gss2010` (degree × grass; `mntlhlth` is Quant) | gapminder 2007 world |
| group-4-youth-risk | Teen habits and risk | yrbss Quants (13,583) | yrbss Quals | gapminder 2007 world |
| group-5-failure-and-asia | Heart failure and Asia (India-facing stand-in) | cardiac_failure, 0/1 recoded (299) | GSS7402 Quals + years of education | gapminder 2007 **Asia only** |
| group-6-acs-and-africa | Acute coronary crisis and Africa | ACS Quants (857) | ACS Quals (smoking, DM, HBP, Dx) | gapminder 2007 **Africa only** |
| group-7-ercp-and-americas | ERCP trial and the Americas | indo_rct age/risk (602) | indo_rct Quals (rx × outcome) | gapminder 2007 **Americas only** |

Read `README.md` inside each folder before opening R. Each folder has `studio-wall.qmd`.

Campus hunches are a **made** panel, not an eighth kit. Invent the sentence on Day 1; collect on Day 7.
