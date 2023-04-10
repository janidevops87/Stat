IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_DORDataHalfHour')
	BEGIN
		PRINT 'Dropping Procedure sps_DORDataHalfHour'
		DROP  Procedure  sps_DORDataHalfHour
	END

GO

PRINT 'Creating Procedure sps_DORDataHalfHour'
GO
CREATE Procedure sps_DORDataHalfHour
	@StartDate SMALLDATETIME,
 	@EndDate SMALLDATETIME =null,
	@MedSocOffSet INT = 1 --- USE THIS TO DETERMINE HOW MANY HOURS MEDSOC IS OFFSET BY
						-- the event that triggers medsoc happen after completetion	
AS

/******************************************************************************
**		File: 
**		Name: sps_DORDataHalfHour
**		Desc: 
**
**              
**		Return values:
**		All values are based on the shift for that day
**		See Requirements
**
**		Called by:   DOR Data Report
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 10/23/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		10/23/07	Bret Knoll			Automated Data Generation for DOR Report
**		11/06/07	Bret Knoll			Modifying based on new Requirements						
******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON
DECLARE
	@Today SMALLDATETIME,
	@tempTime SMALLDATETIME

declare @TimeTable TABLE
		(
			id int identity(1, 1),
			ActivityDateTime SMALLDATETIME,
			SecondaryScreening INT, 
			FamilyApproaches INT,
			MedSoc INT
		)
declare @finalCountTable TABLE
		(
			id int identity(1, 1),
			ActivityDateTime SMALLDATETIME,
			SecondaryScreening INT, 
			FamilyApproaches INT,
			MedSoc INT
		)


	
SET @Today = GETDATE()
SET @tempTime = @StartDate
-- SET @Today = CONVERT(DATETIME, CONVERT(VARCHAR(2), DATEPART(MM, @Today)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, @Today)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @Today)))

IF (ISNULL(@EndDate, DATEADD(D, 1, @Today)) > @Today ) --reset the @EndDate if it greater than today
BEGIN
	SET @EndDate = CONVERT(DATETIME, CONVERT(VARCHAR(2), DATEPART(MM,@Today)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, @Today)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @Today)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, @Today)) + ':00' ) 

END
PRINT @EndDate
WHILE @tempTime <= @EndDate
BEGIN
	INSERT @TimeTable 
	VALUES (CONVERT(DATETIME, CONVERT(VARCHAR(2), DATEPART(MM, @tempTime)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, @tempTime)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @tempTime)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, @tempTime)) + ':00' ), 0, 0, 0 )
	
	INSERT @TimeTable 
	VALUES (CONVERT(DATETIME, CONVERT(VARCHAR(2), DATEPART(MM, @tempTime)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, @tempTime)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @tempTime)) + ' ' + CONVERT(VARCHAR(2), DATEPART(HH, @tempTime)) + ':30' ), 0, 0, 0 )

	SET @tempTime = DATEADD(HH, 1, @tempTime)
END


--Build a temp table. This step creates table with the columns as the INSERT below.
---The Where clause causes it to build an empty table
---A table is created before inserting the data. ITS FASTER
DECLARE
	@CountTable TABLE
	(
	-- SourceCodeID INT,
	Month INT,
	Day INT,
	Year INT,
	Hour INT,
	Minute INT,
	--ReferralApproachedByPersonID INT,
	GroupName VARCHAR(100),
	SecondaryScreening INT, 
	FamilyApproaches INT,
	FamilyUnavailable INT,
	TotalFamilyApproaches INT,
	Consent INT, 
	MedSoc INT,
	TotalTime INT
	
	)

-- Insert into the temp table
INSERT @CountTable
--- Secondary Screening
---- Statline Employees
---- Event Log > Secondary Outcome
---- Event Log > Secondary Outcome > By = Statline employee  

SELECT 
	--SourceCodeID,
	DATEPART(MM, le.LogEventDateTime),
	DATEPART(DD, le.LogEventDateTime),
	DATEPART(YYYY, le.LogEventDateTime),
	DATEPART(HH, le.LogEventDateTime),
	CASE 
		WHEN DATEPART(n, le.LogEventDateTime) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,
	--StatEmployee.PersonID, --SD.PersonID,
	'Secondary Screening',
	COUNT(c.CallID), 
	0,
	0,
	0,
	0,
	0,
	0
FROM 
	Call c
JOIN 
	LogEvent le ON le.CallID = c.CallID 
	AND le.LogEventTypeID =  15 -- 15 Secondary Pending
							-- Bret 2/13 changed 16 Secondary Outcome
JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = le.StatEmployeeID
WHERE
	c.CallID in (
					SELECT LogEvent.CallID 
					FROM LogEvent 
					WHERE LogEvent.CallID = c.CallID 
					AND LogEvent.LogEventTypeID = 16 --Secondary Outcome
				)
AND 
	StatEmployee.PersonID IN (	SELECT
									PersonID
								FROM
									Person
								WHERE
									Person.PersonID = StatEmployee.PersonID
								AND
									Person.OrganizationID = 194 -- Statline
							)
AND  
	le.LogEventDateTime 
BETWEEN 
	@StartDate 
AND 
	@EndDate
GROUP 
BY  
	DATEPART(MM, le.LogEventDateTime),
	DATEPART(DD, le.LogEventDateTime),
	DATEPART(YYYY, le.LogEventDateTime),
	DATEPART(HH, le.LogEventDateTime),
	CASE 
		WHEN DATEPART(n, le.LogEventDateTime) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,

	SourceCodeID,
	StatEmployee.PersonID

--UNION ALL
-- FS Approach
--- Family Services
--- Family Services > Approach > Informed Approach > By = Statline employee
INSERT @CountTable
SELECT 
	--SourceCodeID, 
	DATEPART(MM, FSCaseBillApproachDateTime),
	DATEPART(DD, FSCaseBillApproachDateTime),
	DATEPART(YYYY, FSCaseBillApproachDateTime),
	DATEPART(HH, FSCaseBillApproachDateTime),
	CASE 
		WHEN DATEPART(n, FSCaseBillApproachDateTime) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,

	--SecondaryApproachedBy,
	'Family Approaches' ,
	0 , 
	COUNT(Call.CallID),
	0,
	0,
	0, 
	0,
	0 
FROM  Call 
JOIN 
	Referral ON Referral.CallID = Call.CallID
JOIN FSCase ON FSCase.CallID = Call.CallID
JOIN StatEmployee ON StatEmployee.StatEmployeeID = FSCaseBillApproachUserID
JOIN Person p ON p.PersonID = StatEmployee.PersonID
--JOIN SecondaryApproach SA ON SA.CallID = Call.CallID
--JOIN  Person AP ON AP.PersonID = SA.SecondaryApproachedBy
WHERE 
	FSCaseBillApproachUserID > 0
AND
	p.OrganizationID = 194		
AND  FSCaseBillApproachDateTime 
	BETWEEN 
		@StartDate 
	AND 
		@EndDate

GROUP 
BY  
	DATEPART(MM, FSCaseBillApproachDateTime),
	DATEPART(DD, FSCaseBillApproachDateTime),
	DATEPART(YYYY, FSCaseBillApproachDateTime),
	DATEPART(HH, FSCaseBillApproachDateTime),
	CASE 
		WHEN DATEPART(n, FSCaseBillApproachDateTime) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,
	SourceCodeID 


-- MedSoc
-- Family Services > Case Management > Med/Soc = checked
-- AND 
-- (Family Services > Approach > Informed Approach > By = Statline employee
-- OR
-- Family Services > Approach > Consent > Consent Paperwork > Obtained By = Statline employee)
INSERT @CountTable
SELECT 
	--SourceCodeID, 
	DATEPART(MM, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(DD, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(YYYY, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(HH, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	CASE 
		WHEN DATEPART(n, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,

	--CASE WHEN SecondaryConsentBy>0 THEN SecondaryConsentBy ELSE SA.SecondaryApproachedBy END AS 'PersonID' ,
	'MedSoc' ,
	0 , 
	0,
	0,
	0, 
	0,
	COUNT(Call.CallID),
	0
FROM  
	Call 
JOIN  
	FSCase ON FSCase.CallID = Call.CallID
JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = FSCaseBillApproachUserID
JOIN 
	Person p ON p.PersonID = StatEmployee.PersonID
WHERE 
	FSCaseBillMedSocUserID > 0
AND
	p.OrganizationID = 194		
AND  
	FSCaseBillMedSocDateTime 
BETWEEN 
	@StartDate 
AND 
	@EndDate
GROUP 
BY  
	DATEPART(MM, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(DD, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(YYYY, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	DATEPART(HH, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)),
	CASE 
		WHEN DATEPART(n, DATEADD(HH, -@MedSocOffSet, FSCaseBillMedSocDateTime)) BETWEEN 00 AND 29 THEN '00'
		ELSE '30'
	END,

	SourceCodeID

INSERT @finalCountTable
SELECT  
	CONVERT(DATETIME, CONVERT(VARCHAR(2), Month) + '/' + CONVERT(VARCHAR(2), Day) + '/' + CONVERT(VARCHAR(4), Year) + ' ' + CONVERT(VARCHAR(2), Hour) + ':' + CONVERT(VARCHAR(4), Minute)) ActivityDateTime,	
	SUM(SecondaryScreening) AS 'SecondaryScreening', 
	SUM(FamilyApproaches) AS 'FamilyApproaches', 
	--SUM(Consent) AS 'Consent',
	SUM(MedSoc) AS 'MedSoc'
	--AVG(TotalTime) AS 'AVG_TotalTime'
FROM  
	@CountTable ct
GROUP 
BY 
 CONVERT(DATETIME, CONVERT(VARCHAR(2), Month) + '/' + CONVERT(VARCHAR(2), Day) + '/' + CONVERT(VARCHAR(4), Year) + ' ' + CONVERT(VARCHAR(2), Hour) + ':' + CONVERT(VARCHAR(4), Minute))

INSERT @finalCountTable
SELECT 
	tt.ActivityDateTime,
	ISNULL(tt.SecondaryScreening, 0) 'SecondaryScreening',
	ISNULL(tt.FamilyApproaches, 0)'FamilyApproaches',
	ISNULL(tt.MedSoc, 0) 'MedSoc'
FROM 
	@TimeTable tt 
WHERE tt.ActivityDateTime NOT IN (SELECT ct.ActivityDateTime FROM @finalCountTable ct)

SELECT 
	ct.ActivityDateTime,
	ISNULL(ct.SecondaryScreening, 0) 'SecondaryScreening',
	ISNULL(ct.FamilyApproaches, 0)'FamilyApproaches',
	ISNULL(ct.MedSoc, 0) 'MedSoc' 
FROM @finalCountTable ct
ORDER 
BY  
 ct.ActivityDateTime

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO

GRANT EXEC ON sps_DORDataHalfHour TO PUBLIC

GO
