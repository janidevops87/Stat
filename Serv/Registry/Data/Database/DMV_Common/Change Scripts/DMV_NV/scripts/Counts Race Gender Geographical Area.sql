SELECT     DMV.Gender, DMV.Donor, DMV.CreateDate, CASE WHEN DMVADDR.City = 'Las Vegas' OR
                      DMVADDR.City = 'Henderson' THEN 'Clark County' ELSE 'Other' END AS Expr2, DMV.LastModified
FROM         DMV INNER JOIN
                      DMVADDR ON DMV.ID = DMVADDR.ID
WHERE     (DMV.LastModified BETWEEN CONVERT(DATETIME, '2006-06-01 00:00:00', 102) AND CONVERT(DATETIME, '2006-06-30 23:59:59', 102)) 



SELECT 
	COUNT(*) Count,Gender, RaceName, County, Month, Year
FROM
	(
		SELECT     
			Registry.id,
			REGISTRY.Gender, 
			R.RaceName, 
			CASE 
				WHEN 
					REGISTRYADDR.City = 'Las Vegas' OR REGISTRYADDR.City = 'Las Vegas' 
				THEN 
					'Clark County' 
				WHEN 
					REGISTRYADDR.City = 'Reno' OR REGISTRYADDR.City = 'Sparks' OR REGISTRYADDR.City = 'Carson City' 
				THEN 
					'Washoe County' 
				ELSE 'Other County' 
			END AS COUNTY,
			DATENAME(MM, REGISTRY.SignatureDate) AS Month,
			DATENAME(YYYY, REGISTRY.SignatureDate) AS Year
		FROM         
			REGISTRY 
		INNER JOIN
			REGISTRYADDR ON REGISTRY.ID = REGISTRYADDR.RegistryID 
		INNER JOIN
			Race R ON R.RaceID = REGISTRY.Race
		WHERE     
			(REGISTRY.Donor = 1) 
		AND 
			(REGISTRY.SignatureDate BETWEEN CONVERT(DATETIME, '2006-06-01 00:00:00', 102) AND CONVERT(DATETIME, 
							'2007-06-30 23:59:59', 102)) 
		AND REGISTRYADDR.CITY IS NOT NULL 
			--(REGISTRYADDR.AddrTypeID = 1)
	)AS TABLE_LIST
GROUP BY Gender, RaceName, County, Month, Year
ORDER BY Year, Month, County, RaceName, Gender