SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus2    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus2]
GO

CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndDonorStatus2

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
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange', CAST(Donor AS CHAR(1)) AS 'Donor'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender, CAST(Donor AS CHAR(1)) 

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

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
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(SignatureDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') <> ''
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
END,
CAST(Donor AS CHAR(1))

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

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
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(OnLineRegDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') = ''
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
END,
CAST(Donor AS CHAR(1)) 

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, CASE Donor WHEN '1' THEN 'Y' WHEN '0' THEN 'N' ELSE 'U' END AS 'Donor'
FROM #DRCountHoldingTable

GROUP BY Donor , Gender, AgeRange 
ORDER BY AgeRange, Gender, Donor

DROP TABLE #DRCountHoldingTable
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

