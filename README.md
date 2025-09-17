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

To quantify the impact of post-2019 disruptions, we conducted a **DiD regression**:

- **Treatment group**: States with large drops in timeliness after 2019.  
- **Control group**: States with relatively stable performance.  
- **Post period**: 2020–2023.  
- **Fixed effects**: State and year.  

### Regression Results
- **DiD coefficient (treat × post): -18.9 percentage points**  
  - Treatment states processed SNAP applications ~19% fewer on time after 2019, relative to controls.  
- **Statistical significance**: ***p < 0.001***.  
- **Model fit**: Adj. R² ~ 0.44; RMSE ~ 6.0.  

### Interpretation
The analysis confirms a **large, statistically significant decline** in timeliness post-2019 for the treatment states. The divergence between treated and control states aligns with both the **GIS maps** and **EDA findings**, reinforcing the evidence of administrative strain in the SNAP system post-COVID.
## Repository Structure

