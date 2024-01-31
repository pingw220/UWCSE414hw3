WITH Num AS (
	SELECT F1.origin_city AS origin_city, COUNT(F1.fid) AS num
	FROM FLIGHTS AS F1
	WHERE F1.canceled = 0
		AND F1.actual_time < 90
	GROUP BY F1.origin_city
)
SELECT F.origin_city AS origin_city, COALESCE(N.num * 1.0 / COUNT(F.fid) * 1.0 * 100.0, 0) AS percentage
FROM FLIGHTS AS F LEFT OUTER JOIN Num AS N
ON F.origin_city = N.origin_city
WHERE F.canceled = 0
GROUP BY F.origin_city, N.num
ORDER BY percentage ASC, F.origin_city ASC;