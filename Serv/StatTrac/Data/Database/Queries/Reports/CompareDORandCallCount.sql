
/******************************************************************************
**		File: CompareDORandCallCount.sql
**		Name:
**		Desc: Compares raw data from the DOR report to the CallCountSummary
**
**              
**
**		Auth: Bret Knoll
**		Date: 01/17/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			----------------------------------------
		01/17/07	Bret Knoll			initial compare		
******************************************************************************/

 DECLARE 
	@StartDate SMALLDATETIME,
 	@EndDate SMALLDATETIME,
	@Shift	INT ,
	@vReportGroupID INT

SET @StartDate = '1/1/08'
SET @EndDate = '1/31/08 23:59:59'
SET @vReportGroupID = 1756 -- 436
select * from webreportgroup where webreportgroupid = @vReportGroupID
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON

DECLARE @ShiftHours TABLE
	(
	  Hour int
	)
DECLARE
	@Today DateTime
	
SELECT @Today = GETDATE()
SET @Today = CONVERT(DATETIME, CONVERT(VARCHAR(2), DATEPART(MM, @Today)) + '/' + CONVERT(VARCHAR(2), DATEPART(DD, @Today)) + '/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @Today)))

IF (ISNULL(@EndDate, DATEADD(D, 1, @Today)) > @Today ) --reset the @EndDate if it greater than today
BEGIN
	SET @EndDate = @Today
END
PRINT @EndDate
IF(@Shift = 1)
BEGIN -- all hours are shifted by 2 hours so that all shifts occur during the same day.
	INSERT @ShiftHours VALUES(8)
	INSERT @ShiftHours VALUES(9) 
	INSERT @ShiftHours VALUES(10) 
	INSERT @ShiftHours VALUES(11) 
	INSERT @ShiftHours VALUES(12) 
	INSERT @ShiftHours VALUES(13) 
	INSERT @ShiftHours VALUES(14) 
	INSERT @ShiftHours VALUES(15)
END
ELSE IF(@Shift = 2)
BEGIN
	INSERT @ShiftHours VALUES(16) 
	INSERT @ShiftHours VALUES(17) 
	INSERT @ShiftHours VALUES(18) 
	INSERT @ShiftHours VALUES(19) 
	INSERT @ShiftHours VALUES(20) 
	INSERT @ShiftHours VALUES(21) 
	INSERT @ShiftHours VALUES(22) 
	INSERT @ShiftHours VALUES(23) 

END IF(@Shift = 3)
BEGIN
	INSERT @ShiftHours VALUES(0) 
	INSERT @ShiftHours VALUES(1) 
	INSERT @ShiftHours VALUES(2) 
	INSERT @ShiftHours VALUES(3) 
	INSERT @ShiftHours VALUES(4) 
	INSERT @ShiftHours VALUES(5) 
	INSERT @ShiftHours VALUES(6)
	INSERT @ShiftHours VALUES(7)
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

DECLARE @Temp_LogEventSelect TABLE
	(
		[CallID] [int],
		[CallDateTime] [datetime],
		[SourceCodeID] [INT],
		[LogEventID] [int],
		[LogEventTypeID] [int],
		[LogEventDateTime] [smalldatetime] Null
	)

-- Create temp ref table for (Minimum) event times 
DECLARE @Temp_LogEventRef TABLE
	(
		[CallID] [int],
		[LogEventTypeID] [varchar](80),
		[LogEventDateTime] [smalldatetime]
	)

-- temp table to hold Consent Outcomes
DECLARE @Temp_LogEventConsent TABLE
	(
		[CallID] [int],
		[LogEventTypeID] [varchar](80),
		[LogEventDateTime] [smalldatetime]
	)

INSERT @Temp_LogEventConsent
SELECT		
		LogEvent.CallID,
		LogEvent.LogEventTypeID,
		min(DATEADD(HH, 2, LogEvent.LogEventDateTime))
FROM 
	Call
JOIN 
	LogEvent ON LogEvent.CallID = Call.CallID 
JOIN 	
	FSCASE ON FSCase.CallID = Call.CallID
WHERE 

	LogEvent.LogEventTypeID  in(7, 27, 15) 
	-- 7 Consent Outcome	
	-- 27 Consent Obtained
AND 
	(	DATEADD(HH, 2, LogEvent.LogEventDateTime) 
		BETWEEN 	
			@StartDate 
		AND 
			@EndDate -- StartDate / EndDate
--- WE DO NOT CARE ABOUT SHIFT FOR THE COMPARISON		AND DATEPART(HH, DATEADD(HH, 2, LogEvent.LogEventDateTime)) IN (SELECT Hour FROM @ShiftHours)		
	)
AND 
	LogEvent.StatEmployeeID IN (	SELECT 
						StatEmployeeID 
					FROM 
						StatEmployee se
					JOIN					
						Person p ON p.PersonID = se.PersonID								
					WHERE 
						p.OrganizationID = 194 
					AND					
						se.StatEmployeeID = LogEvent.StatEmployeeID					
				)	
GROUP BY
		LogEvent.CallID,
		LogEvent.LogEventTypeID



INSERT INTO @Temp_LogEventSelect	

SELECT  
		LogEvent.CallID,
		DATEADD(HH, 2, Call.CallDateTime),
		Call.SourceCodeID,
		LogEvent.LogEventID,
		LogEvent.LogEventTypeID,
		DATEADD(HH, 2, LogEvent.LogEventDateTime)
FROM 
	Call
JOIN 
	FSCASE ON FSCase.CallID = Call.CallID
JOIN 
	LogEvent ON LogEvent.CallID = Call.CallID 

WHERE 
	(
		DATEADD(HH, 2, Call.CallDateTime) 
		BETWEEN 
	
			@StartDate 
		AND 
			@EndDate -- StartDate / EndDate
--- WE DO NOT CARE ABOUT SHIFT FOR THE COMPARISON			AND 			DATEPART(HH, DATEADD(HH, 2, Call.CallDateTime)) IN (SELECT Hour FROM @ShiftHours)

	)
AND 
	LogEvent.StatEmployeeID IN (	SELECT StatEmployeeID 
									FROM StatEmployee se
									JOIN					
										Person p ON p.PersonID = se.PersonID								
									WHERE se.StatEmployeeID = LogEvent.StatEmployeeID
									AND
										p.OrganizationID = 194 
								)
AND 
	LogEvent.LogEventTypeID IN (2, 28 )
	-- 2 Incoming Call	
	-- 28 Paperwork Completed
	
ORDER BY
		LogEvent.CallID,
		LogEvent.LogEventDateTime

INSERT INTO @Temp_LogEventRef	
	SELECT  
		CallID,
		LogEventTypeID,
		min(LogEventDateTime) --date was converted while filling temp table
	FROM 
		@Temp_LogEventSelect
	GROUP BY
		CallID,
		LogEventTypeID

-- Insert into the temp table
INSERT @CountTable
--- Secondary Screening
---- Statline Employees
---- Event Log > Secondary Outcome
---- Event Log > Secondary Outcome > By = Statline employee  

SELECT 
	--SourceCodeID,
	DATEPART(MM, DATEADD(HH, 2, le.LogEventDateTime)),
	DATEPART(DD, DATEADD(HH, 2, le.LogEventDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, le.LogEventDateTime)),	 
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
	LogEvent le ON le.CallID = c.CallID	AND le.LogEventTypeID =  15 
JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = le.StatEmployeeID
WHERE
	-- 16 Secondary Outcome
	-- 15 Secondary Pending
	-- select * from logeventtype
--	c.CallID IN (SELECT CallID FROM LogEvent WHERE LogEventTypeID =  16 )
-- AND 
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
	DATEADD(HH, 2, le.LogEventDateTime) 
BETWEEN 
	@StartDate 
AND 
	@EndDate
AND isnull(le.LogEventDeleted, 0)  = 0

--AND 	DATEPART(HH, DATEADD(HH, 2, le.LogEventDateTime)) IN (SELECT Hour FROM @ShiftHours)
/*
GROUP 
BY  
	DATEPART(MM, DATEADD(HH, 2, le.LogEventDateTime)),
	DATEPART(DD, DATEADD(HH, 2, le.LogEventDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, le.LogEventDateTime)),
	SourceCodeID,
	StatEmployee.PersonID
*/
/*

--UNION ALL
-- FS Approach
--- Family Services
--- Family Services > Approach > Informed Approach > By = Statline employee
INSERT @CountTable
SELECT 
	--SourceCodeID, 
	DATEPART(MM, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
	DATEPART(DD, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
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
AND  DATEADD(HH, 2, FSCaseBillApproachDateTime) 
BETWEEN @StartDate 
AND @EndDate
AND DATEPART(HH, DATEADD(HH, 2, FSCaseBillApproachDateTime))IN (SELECT Hour FROM @ShiftHours)
GROUP 
BY  
	DATEPART(MM, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
	DATEPART(DD, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, FSCaseBillApproachDateTime)),
	SourceCodeID 
	
-- UNION ALL
-- Consent
-- (Triage > Consent > Bone = Yes
-- OR
-- Triage > Consent > Soft Tissue = Yes
-- OR
-- Triage > Consent > Skin = Yes
-- OR
-- Triage > Consent > Valves = Yes
-- OR
-- Triage > Consent > Eyes = Yes
-- OR
-- Triage > Consent > Other = Yes)
-- AND
-- Reg. Status = Not Checked or Not on Registry
-- AND
-- Final Approach Consent = Yes – Written
-- AND 
-- (Family Services > Approach > Informed Approach > By = Statline employee
-- OR
-- Family Services > Approach > Consent > Consent Paperwork > Obtained By = Statline employee)
INSERT @CountTable
SELECT 
	--SourceCodeID, 
	DATEPART(MM, le.LogEventDateTime), --date was converted while filling temp table
	DATEPART(DD, le.LogEventDateTime), --date was converted while filling temp table
	DATEPART(YYYY, le.LogEventDateTime), --date was converted while filling temp table
	--CASE WHEN SecondaryConsentBy>0 THEN SecondaryConsentBy ELSE SA.SecondaryApproachedBy END AS PersonID, 
	'Consented' ,
	0 , 
	0,
	0,
	0, 
	COUNT(c.CallID),
	0,
	0
FROM  
	Call c
JOIN 
	@Temp_LogEventConsent le ON le.CallID = c.CallID
AND 
	le.LogEventTypeID  = 27
JOIN  
	SecondaryApproach SA ON SA.CallID = c.CallID 
LEFT JOIN 
	Person SCP ON SCP.PersonID = SA.SecondaryConsentBy
LEFT JOIN 
	Person SAP ON SAP.PersonID = SA.SecondaryApproachedBy
WHERE 
	SA.SecondaryApproached = 1 -- 1 = yes
AND (
	 SA.SecondaryApproachOutcome = 2 -- yes written     
     )

AND 
	((SA.SecondaryConsentBy>0 AND SCP.OrganizationID=194) OR SAP.OrganizationID=194)
AND
	c.CallID IN 	(
					SELECT
						CallID
					FROM 
						RegistryStatus rs
					WHERE 
						rs.CallID = c.CallID
					AND
						rs.RegistryStatus IN (3, 5) 
				)
AND
	c.CallID IN	(
				SELECT
					CallID
				FROM
					Referral
				WHERE	
					Referral.CallID = c.CallID
				AND
					(
						Referral.ReferralBoneConsentID = 1 -- 1 yes 
						OR
						Referral.ReferralTissueConsentID = 1 -- 1 yes 
						OR
						Referral.ReferralSkinConsentID = 1 -- 1 yes 
						OR
						Referral.ReferralEyesTransConsentID = 1 -- 1 yes 
						OR
						Referral.ReferralEyesRschConsentID = 1 -- 1 yes 
						OR
						Referral.ReferralValvesConsentID = 1 -- 1 yes 
					)					
				)
AND
	le.LogEventTypeID = 27					
GROUP 
BY  
	DATEPART(MM, le.LogEventDateTime), --date was converted while filling temp table
	DATEPART(DD, le.LogEventDateTime), --date was converted while filling temp table
	DATEPART(YYYY, le.LogEventDateTime), --date was converted while filling temp table
	SourceCodeID, 
	CASE WHEN SecondaryConsentBy>0 THEN SecondaryConsentBy ELSE SA.SecondaryApproachedBy END

--UNION ALL
-- MedSoc
-- Family Services > Case Management > Med/Soc = checked
-- AND 
-- (Family Services > Approach > Informed Approach > By = Statline employee
-- OR
-- Family Services > Approach > Consent > Consent Paperwork > Obtained By = Statline employee)
INSERT @CountTable
SELECT 
	--SourceCodeID, 
	DATEPART(MM, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
	DATEPART(DD, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
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
	DATEADD(HH, 2, FSCaseBillMedSocDateTime) 
BETWEEN 
	@StartDate 
AND 
	@EndDate
AND 
	DATEPART(HH, DATEADD(HH, 2, FSCaseBillMedSocDateTime))IN (SELECT Hour FROM @ShiftHours)
GROUP 
BY  
	DATEPART(MM, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
	DATEPART(DD, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
	DATEPART(YYYY, DATEADD(HH, 2, FSCaseBillMedSocDateTime)),
	SourceCodeID
-- UNION ALL
-- TotalTime or 'Diff_IncomingToPaperwork',
-- Calculate time difference in seconds: IncomingCall to PaperworkCompleted 
INSERT @CountTable
SELECT  DISTINCT
	--r.SourceCodeID,
	DATEPART(MM,  r.CallDateTime),  --date was converted while filling temp table
	DATEPART(DD,  r.CallDateTime), --date was converted while filling temp table
	DATEPART(YYYY,  r.CallDateTime),	  --date was converted while filling temp table
	--0,
	'Diff_IncomingToPaperwork',
	0,
	0,
	0,
	0,
	0,
	0,
	Cast(DateDiff(ss,IncomingCall.LogEventDateTime,PaperworkCompleted.LogEventDateTime)AS Int) AS 'Diff_IncomingToPaperwork'

FROM 
	@Temp_LogEventSelect AS r 
	--Referral data
JOIN 
	@Temp_LogEventRef AS IncomingCall ON IncomingCall.CallID = r.CallID AND (IncomingCall.LogEventTypeID = 2)
	-- Incoming Call
LEFT JOIN 
	@Temp_LogEventRef AS PaperworkCompleted ON PaperworkCompleted.CallID = r.CallID AND (PaperworkCompleted.LogEventTypeID = 28)
	-- Paperwork Completed
*/

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


select count(*) DORCOUNT
from @TABLEDORSECONDARY st
join call c on c.CallID = st.callid
join sourcecode sc on sc.SourceCodeID = c.SourceCodeID
-- group by sc.SourceCodeName



DECLARE @CALLCOUNT TABLE
(
	CALLID INT
)

INSERT @CALLCOUNT
SELECT  distinct
c.CallID
FROM     Call c
JOIN Referral r ON r.CallID = c.CallID
JOIN FSCASE fc ON fc.callid = c.callid
JOIN Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
JOIN WebReportGroupOrg wrg ON wrg.OrganizationID = o.OrganizationID

WHERE	
(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	    
AND CallDateTime BETWEEN @StartDate AND @EndDate
 and c.SourceCodeID IN (select sourcecodeID from sourcecode where sourcecodename in ('MN', 'CAOL', 'HIOP', 'CTLC', 'NORS', 'NYSC', 'NYRC' ))
--and wrg.WebReportGroupID = @vReportGroupID		
	
SELECT COUNT(*) CALLCOUNT FROM @CALLCOUNT

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
AND ISNULL(FC.FSCaseBillSecondaryUserID, 0) < 1
order by 1



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

--AND LE.LOGEVENTTYPEID = 16
-- GROUP BY   ReferralCallerOrganizationID, SourceCodeID

--- select * from webreportgroup where OrgHierarchyParentID = 194
