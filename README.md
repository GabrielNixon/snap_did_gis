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
The dataset is saved in **wide format** : one row per state, with each fiscal year as a separate column.  

### Example preview  

| state    | 2023  | 2022  | 2019  | ... | 2012  |  
|----------|-------|-------|-------|-----|-------|  
| Alabama  | 94.30 | 96.10 | 92.50 | ... | 87.40 |  
| Alaska   | 38.98 | 45.10 | 56.00 | ... | 62.30 |  
| ...      | ...   | ...   | ...   | ... | ...   |  

The CSV is stored under `outputs/tables/` and can be loaded directly into R, Python, or other analysis tools.  

Exploratory Data Analysis (EDA)

This section explores trends, distributions, and correlations in SNAP application timeliness across states from 2012–2023.

Summary Statistics

The table below summarizes mean, minimum, maximum, and variability of timeliness rates across states for each year:

Year	Mean Rate	Min Rate	Max Rate	Std. Dev.
2012	86.7	56.7	99.3	9.13
2013	87.7	57.4	99.0	8.48
2014	86.9	63.4	99.6	8.01
2015	90.1	73.5	99.1	5.91
2016	91.4	71.9	98.6	4.84
2017	92.4	81.1	99.7	4.60
2018	91.4	69.6	99.2	5.84
2019	91.9	75.8	99.7	4.96
2022	85.6	42.9	100.0	10.02
2023	82.3	39.0	98.2	12.89

Key observations:

From 2012–2019, mean timeliness rose steadily, peaking above 92%.

Variability narrowed during these years, reflecting consistent performance across states.

In 2022–2023, mean timeliness declined, and variability widened, showing large disparities.

State Trends

Selected states (California, Florida, New York, Texas) show similar pre-2019 stability, followed by sharp declines in 2022–2023.

Yearly Variation

Boxplots show compressed distributions during 2015–2019, with post-COVID years marked by lower medians and wider spreads.

Distributional Shifts

Histograms indicate most states clustered near 90–95% pre-2019, but distributions spread out post-COVID, with some states dropping below 50%.

Correlation Patterns

Strong positive correlations exist between adjacent pre-2019 years (e.g., 2016–2017). Post-COVID years (2022–2023) break this pattern, showing weaker or even negative correlations with earlier years.

Insights

High performance plateau (2015–2019): Most states consistently exceeded 90%.

COVID-era disruption (2022–2023): Mean timeliness dropped and variability widened.

Unequal resilience: Some states maintained high rates, while others fell drastically, exposing administrative disparities.
