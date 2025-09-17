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
