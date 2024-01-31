SELECT F2.dest_city AS city
FROM FLIGHTS AS F1, FLIGHTS AS F2
WHERE F1.dest_city = F2.origin_city
	AND F1.origin_city = 'Seattle WA'
	AND F1.dest_city = F2.origin_city
	AND NOT EXISTS (
		SELECT *
		FROM FLIGHTS AS F
		WHERE F.origin_city = 'Seattle WA'
		AND F2.dest_city = F.dest_city
		)
GROUP BY F2.dest_city
	HAVING F2.dest_city != 'Seattle WA'
ORDER BY F2.dest_city ASC;