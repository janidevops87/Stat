SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndSource]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndSource]
GO





/*

3.	Outreach enrollments by source code
a.	Name CO Registry Count (Source)
Kenn, I have the organization name in an Excel spreadsheet. Can they be imported into the database, or how do you want to handle this?

Report Date	Date Range	Event Source Code	Organization Name	Number 	Gender	Age

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry
SELECT * FROM Registry WHERE SourceCode IS NULL Order By SourceCode, LastModified
SELECT * FROM Registry WHERE FIRST = 'Bret' AND LAST = 'Knoll' Order By SourceCode, LastModified
delete Registry  where RegistryID = 6905
UPDATE Registry SET SourceCode = "" WHERE SourceCode is null
SELECT COUNT(*) FROM Registry Order By SourceCode
SELECT COUNT(*) FROM Registry

*/
-- sp_helptext sps_DonorRegistryByGenderAndAge
-- sps_DonorRegistryByGenderAgeAndSource '5/1/01', '9/20/02'
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAgeAndSource
CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndSource

	@StartDate	SMALLDATETIME = NULL,
	@EndDate	SMALLDATETIME = NULL,
	@SourceCodeID   VARCHAR(50) =NULL


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

SELECT 

Count(*) as  'Outreach',
ISNULL(SC.SourceCodeName, 'No Source') AS 'EventName',
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
END AS 'AgeRange'

FROM Registry
LEFT JOIN RegistryEventSourceCodes SC ON  SC.SourceCodeID = Registry.SourceCode
WHERE	(SOURCECODE = @SourceCodeID   or isnull(@SourceCodeID,   '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  >= @StartDate  OR ISNULL(@StartDate, '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  <= @EndDate OR ISNULL(@EndDate, '')='')


GROUP BY 
SC.SourceCodeName ,
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
ORDER BY 
SC.SourceCodeName ,

CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END ,
Gender

/*
-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, SourceCode AS 'EventName'
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Donor, Gender, AgeRange 
*/

--DROP TABLE #DRCountHoldingTable 













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

