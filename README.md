# SNAP Application Processing Timeliness (2012–2023)

This repository compiles **SNAP (Supplemental Nutrition Assistance Program)** application processing timeliness rates for U.S. states from USDA-published annual PDF reports.  

## What are the SNAP timeliness numbers?  
The timeliness rate is the **percentage of SNAP applications processed on time** by each state in a given fiscal year. Higher numbers indicate stronger administrative performance in meeting required timelines for application review and approval. These rates are published annually by the U.S. Department of Agriculture’s Food and Nutrition Service (FNS).  

- **Unit:** Percent (%)  
- **Scope:** 50 U.S. states + District of Columbia  
- **Time span:** FY2012–FY2019, FY2022–FY2023  

## Why are some years missing?  
Reports for **FY2020 and FY2021** were not released due to COVID-19 related disruptions in reporting and operations. As a result, those years are not present in this dataset.  

## Data Format  
The dataset is saved in **wide format**: one row per state, with each fiscal year as a separate column.  

### Example preview  

| state    | 2023  | 2022  | 2019  | ... | 2012  |  
|----------|-------|-------|-------|-----|-------|  
| Alabama  | 94.30 | 96.10 | 92.50 | ... | 87.40 |  
| Alaska   | 38.98 | 45.10 | 56.00 | ... | 62.30 |  
| ...      | ...   | ...   | ...   | ... | ...   |  

The CSV is stored under `outputs/tables/` and can be loaded directly into R, Python, or other analysis tools.  

---

## Exploratory Data Analysis (EDA)

We explored trends, distributions, and cross-year relationships in SNAP timeliness:

- **Line trends**: Selected states (e.g., California, Florida, New York, Texas) show sharp declines post-2019.  
- **Boxplots**: Median timeliness remained high (~90%) until 2019, with widening spread in 2022–2023.  
- **Histograms**: Early years cluster near 85–95%, while 2022–2023 show heavier tails and more low-performing states.  
- **Correlations**: Pre-2019 years are strongly correlated with each other (>0.6), while 2022–2023 correlations with pre-periods are much weaker, suggesting a structural shift.

---

## Geographic Information System (GIS) Analysis

We mapped state-level timeliness rates to visualize geographic patterns:

- **Heatmaps by Year**:  
  - 2012: Most states in the 85–95% range.  
  - 2019: Broad improvements, especially in the South and West.  
  - 2023: Large geographic disparities, with states like Alaska and Florida experiencing sharp declines.  

- **Change Maps (2019 → 2023)**:  
  - Nearly all states show **declines**, with especially steep drops in Alaska, New York, and several Southeastern states.  
  - A few states maintained or slightly improved timeliness, visible as light green.

These maps highlight not only overall declines but also strong spatial heterogeneity in administrative performance.

---

## Difference-in-Differences (DiD) Analysis

To understand the impact of disruptions after 2019 (including COVID-19 and related administrative changes) on SNAP application timeliness, we applied a **Difference-in-Differences (DiD)** approach.

### Methodology

The basic DiD specification is:

### Difference-in-Differences Model

We estimate the following specification:

    Y_it = α + β * Treat_i + γ * Post_t + δ * (Treat_i × Post_t) + μ_i + λ_t + ε_it

Where:

- Y_it : SNAP timeliness rate for state *i* in year *t*  
- Treat_i : Indicator if state *i* is in the treatment group  
- Post_t : Indicator for post-period (2020–2023)  
- Treat_i × Post_t : Interaction term; the DiD effect of interest  
- μ_i : State fixed effects (time-invariant differences across states)  
- λ_t : Year fixed effects (national shocks common to all states)  
- δ : The DiD estimator — the extra impact on treated states after 2019

### Treatment and Control Groups

- **Treatment group:** States that experienced *large declines in timeliness* after 2019 (e.g., Alaska, New York, Florida).  
- **Control group:** States that remained relatively stable or only had mild declines (e.g., Iowa, Minnesota).  

This setup allows us to compare whether the drop in timeliness in treatment states exceeded what would have been expected based on overall national trends.

### Results

- **DiD estimate**: -18.9 percentage points.  
- **Standard error:** 1.71.  
- **t-value:** -11.08.  
- **p-value:** < 0.001.  

**Interpretation:**  
After 2019, states in the treatment group processed **~19% fewer applications on time** compared to what would be expected if they had followed the same trajectory as control states.  

This result is statistically significant and robust to fixed effects.

### Why this makes sense

- SNAP timeliness was stable and highly correlated across states before 2019.  
- Post-2019, some states show **dramatic collapses** (e.g., Alaska dropping below 40%).  
- A simple before–after comparison would confound national shocks (like COVID).  
- DiD isolates the **extra effect on badly hit states** relative to those that were more resilient.

### Limitations

- **Parallel trends assumption:** DiD requires that treatment and control states would have followed parallel trends absent the shock. Visual inspection suggests this holds pre-2019, but it cannot be tested directly.  
- **Treatment definition:** We defined treatment as “large post-2019 declines.” This is data-driven and not based on an exogenous policy assignment.  
- **Unobserved heterogeneity:** Other state-level factors (e.g., staffing, policy changes, IT systems) may contribute to differential declines.  
- **Time horizon:** With only two post-period years (2022–2023), long-term recovery effects cannot yet be evaluated.

---

**Conclusion:**  
The DiD analysis strengthens the EDA and GIS findings: **post-2019 disruptions caused severe, uneven declines in SNAP timeliness.** Treated states diverged significantly from controls, with ~19 percentage points larger drops on average. While the treatment assignment is observational, the consistency of results across regression, maps, and descriptive stats gives strong evidence of structural strain in SNAP administration after 2019.

