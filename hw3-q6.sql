SELECT C.name AS carrier
FROM CARRIERS AS C
WHERE C.cid IN (
		SELECT F.carrier_id
		FROM FLIGHTS AS F
		WHERE F.origin_city = 'Seattle WA'
			AND F.dest_city = 'New York NY'
		GROUP BY F.carrier_id
	)
GROUP BY C.name
ORDER BY C.name ASC;