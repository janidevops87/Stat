SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAndAge]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAndAge]
GO

/*

Do you want any demographic info? We can get gender and age info if you'd like.

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry

*/
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAndAge 
CREATE PROCEDURE sps_DonorRegistryByGenderAndAge

	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME


AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

-- TURN RECORD COUNTS OFF
SET NOCOUNT ON
-- Build temporary holding table
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT 0,
Count(*) as  'Outrech',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate)  BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT Count(*) as  'Online',
0,
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate)  BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Gender, AgeRange


DROP TABLE #DRCountHoldingTable
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

