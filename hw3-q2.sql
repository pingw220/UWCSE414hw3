WITH MaxTime AS(
	SELECT F1.origin_city AS origin_city, MAX(F1.actual_time) AS maxTime
	FROM FLIGHTS AS F1
	WHERE F1.canceled = 0
	GROUP BY F1.origin_city
)
SELECT F.origin_city AS city
FROM FLIGHTS AS F, MaxTime as MT
WHERE F.origin_city = MT.origin_city
	AND MT.maxTime < 240
GROUP BY F.origin_city
ORDER BY F.origin_city ASC;