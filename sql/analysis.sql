-- ================================================
-- B2B Sales Pipeline Analysis
-- Business Questions
-- ================================================

-- ------------------------------------------------
-- Q1: Which products are the most profitable?
-- Metrics: popularity, win contribution, median deal value
-- ------------------------------------------------
SELECT product,
COUNT(*) AS total_product,
ROUND(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)*100
/
SUM(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)) OVER(), 2) AS "won_contribution_%",
percentile_cont(0.5) WITHIN GROUP (ORDER BY close_value)::numeric AS med_closevalue
FROM sales_pipeline
WHERE deal_stage='Won'
GROUP BY product
ORDER BY total_product DESC, "grand_total_%" DESC, med_closevalue DESC;

-- ------------------------------------------------
-- Q2: Which sales agents are the most effective?
-- Metrics: win contribution, time to close, median deal value
-- Custom scoring system using DENSE_RANK
-- ------------------------------------------------
WITH time AS(
	SELECT engage_date,
		opportunity_id,
		close_date,
		close_date - engage_date AS time_to_close
	FROM sales_pipeline
	WHERE close_date IS NOT NULL
	AND deal_stage IN ('Won', 'Lost')
)

SELECT sp.sales_agent AS sales_agent,
ROUND(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)*100
/
SUM(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)) OVER(), 2) AS "won_contribution_%",
ROUND(AVG(t.time_to_close)) AS avg_time_to_close,
percentile_cont(0.5) WITHIN GROUP(ORDER BY CASE WHEN deal_stage='Won' THEN close_value END)::numeric AS med_closevalue
FROM sales_pipeline AS sp
LEFT JOIN time AS t
ON t.opportunity_id = sp.opportunity_id
GROUP BY sp.sales_agent
ORDER BY;

WITH time AS(
	SELECT engage_date,
		opportunity_id,
		close_date,
		close_date - engage_date AS time_to_close
	FROM sales_pipeline
	WHERE close_date IS NOT NULL
	AND deal_stage IN ('Won', 'Lost')
),

matrix AS(
	SELECT sp.sales_agent AS sales_agent,
	ROUND(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)*100
	/
	SUM(SUM(CASE WHEN deal_stage='Won' THEN 1 ELSE 0 END)) OVER(), 2) AS "won_contribution_%",
	ROUND(AVG(t.time_to_close)) AS avg_time_to_close,
	percentile_cont(0.5) WITHIN GROUP(ORDER BY CASE WHEN deal_stage='Won' THEN close_value END)::numeric AS med_closevalue
	FROM sales_pipeline AS sp
	LEFT JOIN time AS t
	ON t.opportunity_id = sp.opportunity_id
	GROUP BY sp.sales_agent
	ORDER BY "won_contribution_%" DESC, avg_time_to_close ASC, med_closevalue DESC
),

won_contribution_point AS (
	SELECT sales_agent,
	"won_contribution_%",
	DENSE_RANK() OVER(ORDER BY "won_contribution_%") AS point
	FROM matrix
),

med_closevalue_point AS (
	SELECT sales_agent,
	med_closevalue,
	DENSE_RANK() OVER(ORDER BY med_closevalue) AS point
	FROM matrix
),

time_to_close_point AS (
	SELECT sales_agent,
	avg_time_to_close,
	DENSE_RANK() OVER(ORDER BY avg_time_to_close DESC) AS point
	FROM matrix
)


SELECT m.sales_agent AS sales_agent,
p1.point AS won_contribution_point,
p2.point AS med_closevalue_point,
p3.point AS time_to_close_point,
p1.point + p2.point + p3.point AS total_point
FROM matrix AS m
JOIN won_contribution_point AS p1 USING(sales_agent)
JOIN med_closevalue_point AS p2 USING(sales_agent)
JOIN time_to_close_point AS p3 USING(sales_agent)
ORDER BY total_point DESC
LIMIT 5;
