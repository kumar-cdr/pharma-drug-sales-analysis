# Pharmaceutical Drug Sales Trend Analysis (2014–2019)

Analysed 6 years of daily pharmaceutical sales data across 8 ATC drug categories
to identify seasonal patterns, year-over-year growth trends, and weekday
vs weekend demand differences.

## Dashboard Preview
### Page 1 — Sales Overview
<img width="771" height="433" alt="Dashboard pg1" src="https://github.com/user-attachments/assets/859a6858-f9c5-4663-9f2c-9e0fa57faaa5" />


### Page 2 — Deep Dive Analysis
<img width="771" height="436" alt="Dashboard pg2" src="https://github.com/user-attachments/assets/e2064331-8db3-4f40-9e3f-bc8dc51bfa76" />


## Problem Statement
Pharmaceutical distributors need to understand which drug categories drive
revenue, when seasonal demand peaks occur, and which categories are growing
vs declining — to plan inventory and procurement cycles accurately.

## Dataset
- Source: Kaggle — Pharmaceutical Drug Sales (milanzdravkovic)
- Size: ~57,000 daily sales records across 8 ATC drug categories
- Time period: 2014–2019
- Drug categories: M01AB, M01AE, N02BA, N02BE, N05B, N05C, R03, R06

## ATC Drug Code Reference
| Code  | Drug Type            | Common Example     |
|-------|----------------------|--------------------|
| N02BE | Analgesic            | Paracetamol        |
| N05B  | Anti-anxiety         | Benzodiazepines    |
| R03   | Respiratory          | Asthma inhalers    |
| M01AB | Anti-inflammatory    | Ibuprofen          |
| R06   | Antihistamine        | Allergy medication |
| N05C  | Sedative             | Sleep medication   |

## Tools Used
- MySQL 8.0 — data storage, cleaning, and SQL analysis
- Power BI Desktop — interactive 2-page dashboard

## Key Findings
1. N02BE (Paracetamol) dominates with 63,005 units — 49.4% of all drug sales.
   Its dominance is consistent across all 6 years.
2. N02BE showed extreme volatility: +28.6% growth in 2015, -30.6% crash in 2017,
   +21.3% recovery in 2018, -28.9% decline in 2019. Both drugs follow the same
   alternating pattern, suggesting supply-side disruptions rather than demand shifts.
3. R06 (antihistamines) peaks in months 4–5 (April–May) — spring allergy season.
   R03 (respiratory) peaks in Oct–Dec — cold and flu season.
   These seasonal patterns enable proactive inventory planning 4–6 weeks ahead.

## SQL Techniques Used
- LAG() window function for year-over-year growth calculation
- UNION ALL for combining drug category totals
- CTEs (WITH clause) for multi-step YoY analysis
- MONTH(), YEAR(), DAYNAME() date functions
- CASE WHEN bucketing for grouping
- LOAD DATA LOCAL INFILE for large file import (57K rows)

## Power BI Features Used
- Multi-line chart with Drug as Legend field
- Conditional formatting on YoY chart (green/red rules)
- Unpivot transformation in Power Query
- Year and Drug slicers with Tile style
- 2-page report structure with synced slicers
