WITH MaxTime AS(
	SELECT F1.origin_city AS origin_city, MAX(F1.actual_time) AS maxTime
	FROM FLIGHTS AS F1
	GROUP BY F1.origin_city)
SELECT F.origin_city, F.dest_city, F.actual_time AS time
FROM FLIGHTS AS F, MaxTime AS MT
WHERE F.actual_time = MT.maxTime
	AND F.origin_city = MT.origin_city
GROUP BY F.origin_city, F.dest_city, F.actual_time
ORDER BY F.origin_city, F.dest_city ASC;