IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_DORandBillableCountGap')
	BEGIN
		PRINT 'Dropping Procedure sps_DORandBillableCountGap'
		DROP  Procedure  sps_DORandBillableCountGap
	END

GO

PRINT 'Creating Procedure sps_DORandBillableCountGap'
GO
CREATE Procedure sps_DORandBillableCountGap
	@StartDate SMALLDATETIME,
 	@EndDate SMALLDATETIME = null,
 	@WebReportGroupID INT = 1756 -- 1756 is the FS Only Report Group
 AS

/******************************************************************************
**		File: 
**		Name: sps_DORandBillableCountGap
**		Desc: Provides GAP data between the Secondaries identitied by the DOR Data report 
**		and FS Call Count, ignoring ME and Coroner Organizations.
**
**              
**		Return values:
**		See Requirements
**
**		Called by:   DOR Data Report
**              
**		Auth: Bret Knoll
**		Date: 03/01/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		03/01/08	Bret Knoll			Generating report for weekly QA
******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON
DECLARE
	@Today SMALLDATETIME,
	@tempTime SMALLDATETIME

DECLARE @TimeTable TABLE
		(
			id int identity(1, 1),
			ActivityDateTime SMALLDATETIME,
			SecondaryScreening INT, 
			FamilyApproaches INT,
			MedSoc INT
		)
DECLARE @finalCountTable TABLE
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
	c.CallID, 
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

--select * from @CountTable

-- 2614 distinct, non distinct 2635
DECLARE @TABLEDORSECONDARY TABLE
	(
		callID INT
	)

insert @TABLEDORSECONDARY 
SELECT  DISTINCT
	--CONVERT(DATETIME, CONVERT(VARCHAR(2),Month) + '/' + CONVERT(VARCHAR(2), Day) + '/' + CONVERT(VARCHAR(4), Year)) ActivityDateTime,
	SecondaryScreening AS 'SecondaryScreening' 
	--FamilyApproaches AS 'FamilyApproaches', 
	--Consent AS 'Consent',
	---MedSoc AS 'MedSoc',
	--TotalTime AS 'AVG_TotalTime'
FROM  

	@CountTable ct

/*
select count(*) DORCOUNT
from @TABLEDORSECONDARY st
join call c on c.CallID = st.callid
join sourcecode sc on sc.SourceCodeID = c.SourceCodeID
-- group by sc.SourceCodeName
*/


DECLARE @CALLCOUNT TABLE
(
	CALLID INT
)

INSERT @CALLCOUNT
SELECT  DISTINCT
	c.CallID
FROM 
	Call c
JOIN 
	Referral r ON r.CallID = c.CallID
JOIN 
	FSCASE fc ON fc.callid = c.callid
JOIN 
	Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
JOIN 
	WebReportGroupOrg wrg ON wrg.OrganizationID = o.OrganizationID
WHERE	
	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	    
AND 
	CallDateTime BETWEEN @StartDate AND @EndDate
AND 
	c.SourceCodeID IN (
						SELECT     
							WebReportGroupSourceCode.SourceCodeID
						FROM         
							WebReportGroupSourceCode 
						INNER JOIN
							SourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
						WHERE     
							(WebReportGroupSourceCode.WebReportGroupID = @WebReportGroupID)
						)
--and wrg.WebReportGroupID = @vReportGroupID		

-- SELECT COUNT(*) CALLCOUNT FROM @CALLCOUNT

/*
SELECT 'referrals in the DOR but not in the CallCount'

SELECT  TS.*, FC.FSCaseBillSecondaryUserID, C.CALLDATETIME, sc.SourceCodeName, o.OrganizationName
FROM  @TABLEDORSECONDARY TS
JOIN CALL C ON C.CALLID = TS.CALLID
JOIN SourceCode sc ON sc.SourceCodeID = C.SourceCodeID
JOIN FSCASE FC ON FC.CALLID = C.CALLID
join Referral r ON r.CallID = C.CallID 
join Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
--JOIN LOGEVENT LE ON LE.CALLID = C.CALLID
WHERE TS.CALLID NOT IN (SELECT CALLID FROM @CALLCOUNT)
--and C.CALLDATETIME NOT BETWEEN @StartDate AND @EndDate
order by 1


SELECT 'referrals where the date range is outside of the CallCount DateRange'
SELECT  TS.*, FC.FSCaseBillSecondaryUserID, C.CALLDATETIME, sc.SourceCodeName, o.OrganizationName
FROM  @TABLEDORSECONDARY TS
JOIN CALL C ON C.CALLID = TS.CALLID
JOIN SourceCode sc ON sc.SourceCodeID = C.SourceCodeID
JOIN FSCASE FC ON FC.CALLID = C.CALLID
join Referral r ON r.CallID = C.CallID 
join Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
--JOIN LOGEVENT LE ON LE.CALLID = C.CALLID
WHERE TS.CALLID NOT IN (SELECT CALLID FROM @CALLCOUNT)
and C.CALLDATETIME NOT BETWEEN @StartDate AND @EndDate
order by 1


SELECT 'referrals in the callcount daterange AND FC.FSCaseBillSecondaryUserID not checked'
*/

/*
-- SourceCode List
SELECT     
	SourceCode.SourceCodeName
FROM         
	WebReportGroupSourceCode 
INNER JOIN
	SourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
WHERE     (WebReportGroupSourceCode.WebReportGroupID = @WebReportGroupID)
*/


SELECT  
	--FC.FSCaseBillSecondaryUserID, 
	C.CallDateTime, 
	c.CallID,
	sc.SourceCodeName, 
	o.OrganizationName,
	ot.OrganizationTypeName
	
FROM  
	@TABLEDORSECONDARY TS
JOIN 
	CALL C ON C.CALLID = TS.CALLID
JOIN 
	SourceCode sc ON sc.SourceCodeID = C.SourceCodeID
JOIN 
	FSCASE FC ON FC.CALLID = C.CALLID
JOIN 
	Referral r ON r.CallID = C.CallID 
JOIN 
	Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
JOIN
	OrganizationType ot ON ot.OrganizationTypeID = o.OrganizationTypeID
--JOIN LOGEVENT LE ON LE.CALLID = C.CALLID and LE.LogEvent
WHERE 
	TS.CALLID NOT IN (SELECT CALLID FROM @CALLCOUNT)
AND
	o.OrganizationTypeID NOT IN (
								SELECT     OrganizationTypeID
								FROM         OrganizationType
								WHERE     (OrganizationTypeName IN ('Coroners Office', 'Medical Examiner'))
								)
AND 	C.CALLDATETIME BETWEEN @StartDate AND @EndDate
--AND ISNULL(FC.FSCaseBillSecondaryUserID, 0) < 1
ORDER BY 1


/*
SELECT 'referrals in the callcount daterange AND FC.FSCaseBillSecondaryUserID is checked'
SELECT  TS.*, FC.FSCaseBillSecondaryUserID, C.CALLDATETIME, sc.SourceCodeName, o.OrganizationName
FROM  @TABLEDORSECONDARY TS
JOIN CALL C ON C.CALLID = TS.CALLID
JOIN SourceCode sc ON sc.SourceCodeID = C.SourceCodeID
JOIN FSCASE FC ON FC.CALLID = C.CALLID
join Referral r ON r.CallID = C.CallID 
join Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
--JOIN LOGEVENT LE ON LE.CALLID = C.CALLID and LE.LogEvent
WHERE TS.CALLID NOT IN (SELECT CALLID FROM @CALLCOUNT)
and C.CALLDATETIME BETWEEN @StartDate AND @EndDate
AND ISNULL(FC.FSCaseBillSecondaryUserID, 0) > 0

--and o.OrganizationID NOT IN (select OrganizationID from webreportgroupOrg WHERE WebReportGroupID = @vReportGroupID)

order by 1
*/

/*

SELECT TS.*, FC.FSCaseBillSecondaryUserID, C.CALLDATETIME, sc.SourceCodeName, o.OrganizationName
FROM  @CALLCOUNT TS
JOIN CALL C ON C.CALLID = TS.CALLID
JOIN SourceCode sc ON sc.SourceCodeID = C.SourceCodeID
JOIN FSCASE FC ON FC.CALLID = C.CALLID
join Referral r ON r.CallID = C.CallID 
join Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
--JOIN LOGEVENT LE ON LE.CALLID = C.CALLID
WHERE TS.CALLID NOT IN (SELECT CALLID FROM @TABLEDORSECONDARY)
order by 1

*/
--AND LE.LOGEVENTTYPEID = 16
-- GROUP BY   ReferralCallerOrganizationID, SourceCodeID

--- select * from webreportgroup where OrgHierarchyParentID = 194


GO
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO

GRANT EXEC ON sps_DORandBillableCountGap TO PUBLIC

GO


