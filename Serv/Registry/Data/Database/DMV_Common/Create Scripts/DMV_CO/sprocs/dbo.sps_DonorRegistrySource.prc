SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistrySource    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistrySource]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistrySource]
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
-- sps_DonorRegistrySource '5/1/01', '9/20/02'
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistrySource
-- SELECT * FROM RegistryEventSourceCodes
CREATE PROCEDURE sps_DonorRegistrySource

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

SELECT 

Count(*) as  'Outreach',
SC.SourceCodeName AS 'EventName',
Registry.SourceCode AS 'SourceID'

FROM Registry
LEFT JOIN RegistryEventSourceCodes SC ON  SC.SourceCodeID = Registry.SourceCode
WHERE	SC.SourceCodeName IS NOT NULL 
AND	SignatureDate BETWEEN @StartDate AND @EndDate
 
GROUP BY 
SC.SourceCodeName,Registry.SourceCode 
ORDER BY 
SC.SourceCodeName 

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

