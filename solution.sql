;
with 
m as (
	SELECT DISTINCT dimension_1, correct_dimension_2 FROM [Table MAP]
),
t as (
	SELECT a.dimension_1, m.correct_dimension_2, measure_1, 0 measure_2 
	FROM [Table A] a
	LEFT JOIN m ON m.dimension_1=a.dimension_1

	UNION ALL

	SELECT b.dimension_1, m.correct_dimension_2, 0,  measure_2 
	FROM [Table B] b
	LEFT JOIN m ON m.dimension_1=b.dimension_1
)
SELECT 
	 t.dimension_1
	,t.correct_dimension_2 dimension_2
	,sum(t.measure_1) measure_1
	,sum(t.measure_2) measure_1
FROM t 
GROUP BY t.dimension_1, t.correct_dimension_2  