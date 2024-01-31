SELECT C.name AS carrier
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
	AND F.origin_city = 'Seattle WA'
	AND F.dest_city = 'New York NY'
GROUP BY C.name
ORDER BY C.name ASC;