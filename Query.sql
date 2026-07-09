-- create database pharma_sales

## Query 1 — total sales by drug category:
-- sql-- Sum each drug column separately --
/*SELECT
  'M01AB' AS drug, ROUND(SUM(M01AB), 2) AS total FROM sales_daily
UNION ALL SELECT 'M01AE', ROUND(SUM(M01AE), 2) FROM sales_daily
UNION ALL SELECT 'N02BA', ROUND(SUM(N02BA), 2) FROM sales_daily
UNION ALL SELECT 'N02BE', ROUND(SUM(N02BE), 2) FROM sales_daily
UNION ALL SELECT 'N05B',  ROUND(SUM(N05B),  2) FROM sales_daily
UNION ALL SELECT 'N05C',  ROUND(SUM(N05C),  2) FROM sales_daily
UNION ALL SELECT 'R03',   ROUND(SUM(R03),   2) FROM sales_daily
UNION ALL SELECT 'R06',   ROUND(SUM(R06),   2) FROM sales_daily
ORDER BY total DESC;*/

## Query 2 — monthly seasonality (average sales per month):
-- Which months have highest average sales per drug?
/* SELECT
  Month,
  ROUND(AVG(M01AB), 3) AS M01AB_avg,
  ROUND(AVG(M01AE), 3) AS M01AE_avg,
  ROUND(AVG(N02BA), 3) AS N02BA_avg,
  ROUND(AVG(N02BE), 3) AS N02BE_avg,
  ROUND(AVG(N05B),  3) AS N05B_avg,
  ROUND(AVG(N05C),  3) AS N05C_avg,
  ROUND(AVG(R03),   3) AS R03_avg,
  ROUND(AVG(R06),   3) AS R06_avg
FROM salesdaily
GROUP BY Month
ORDER BY Month;
*/

## Query 3 — year-over-year annual totals:
-- Annual sales per drug across 2014-2019
/*SELECT
  Year,
  ROUND(SUM(M01AB), 2) AS M01AB,
  ROUND(SUM(M01AE), 2) AS M01AE,
  ROUND(SUM(N02BA), 2) AS N02BA,
  ROUND(SUM(N02BE), 2) AS N02BE,
  ROUND(SUM(N05B),  2) AS N05B,
  ROUND(SUM(N05C),  2) AS N05C,
  ROUND(SUM(R03),   2) AS R03,
  ROUND(SUM(R06),   2) AS R06
FROM salesdaily
GROUP BY Year */

## Query 4 — day of week pattern:
-- Do sales differ Mon–Sun? Uses the pre-built Weekday Name column
/* SELECT
  `Weekday Name`,
  ROUND(AVG(M01AB), 3) AS M01AB_avg,
  ROUND(AVG(N02BE), 3) AS N02BE_avg,
  ROUND(AVG(R06),   3) AS R06_avg,
  ROUND(AVG(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06), 3) AS all_drugs_avg
FROM salesdaily
GROUP BY `Weekday Name`
ORDER BY FIELD(`Weekday Name`, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
*/

## Query 5 — YoY growth rate using CTE (your showpiece query):
/*
WITH yearly AS (
  SELECT
    Year,
    ROUND(SUM(N02BE), 2) AS N02BE_total,
    ROUND(SUM(R06),   2) AS R06_total,
    ROUND(SUM(M01AB), 2) AS M01AB_total
  FROM salesdaily
  GROUP BY Year
)
SELECT
  Year,
  N02BE_total,
  ROUND((N02BE_total - LAG(N02BE_total) OVER (ORDER BY Year))
    * 100.0 / NULLIF(LAG(N02BE_total) OVER (ORDER BY Year), 0), 1) AS N02BE_yoy_pct,
  M01AB_total,
  ROUND((M01AB_total - LAG(M01AB_total) OVER (ORDER BY Year))
    * 100.0 / NULLIF(LAG(M01AB_total) OVER (ORDER BY Year), 0), 1) AS M01AB_yoy_pct,
  R06_total,
  ROUND((R06_total - LAG(R06_total) OVER (ORDER BY Year))
    * 100.0 / NULLIF(LAG(R06_total) OVER (ORDER BY Year), 0), 1) AS R06_yoy_pct
FROM yearly
ORDER BY Year; */


-- ALTER TABLE salesdaily MODIFY datum DATE;
# ALTER TABLE salesdaily ADD COLUMN datum_clean DATE;
-- Safe key--
#SET SQL_SAFE_UPDATES = 1; 
-- Check the datatype
#SELECT datum, datum_clean FROM salesdaily LIMIT 5;
#UPDATE salesdaily
# datum_clean = STR_TO_DATE(datum, '%m/%d/%Y');
/* SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'salesdaily' 
  AND column_name = 'datum';
*/