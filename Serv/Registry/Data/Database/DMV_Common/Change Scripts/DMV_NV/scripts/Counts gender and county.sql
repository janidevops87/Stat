 SELECT     DMV.Gender, 
			DMV.Donor, 
			CASE WHEN DMVADDR.City = 'Las Vegas' OR
                      DMVADDR.City = 'Henderson' THEN 'Clark County' ELSE 'Other' END AS Expr2, 
            count(*) Counts
FROM         DMV INNER JOIN
                      DMVADDR ON DMV.ID = DMVADDR.ID
group by 
	DMV.Gender, 
	DMV.Donor, 
	CASE WHEN DMVADDR.City = 'Las Vegas' OR
                      DMVADDR.City = 'Henderson' THEN 'Clark County' ELSE 'Other' END