SELECT F.dest_city AS city
FROM FLIGHTS AS F
WHERE NOT EXISTS (
	SELECT *
	FROM FLIGHTS AS F1, FLIGHTS AS F2
	WHERE F1.origin_city = 'Seattle WA'
		AND (F.dest_city = F1.dest_city OR (F2.origin_city = F1.dest_city AND F.dest_city = F2.dest_city))
)
GROUP BY F.dest_city
	HAVING F.dest_city != 'Seattle WA'
ORDER BY city ASC;
