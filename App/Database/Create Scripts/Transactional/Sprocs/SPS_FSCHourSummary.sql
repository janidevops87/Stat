SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_FSCHourSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_FSCHourSummary]
GO

CREATE PROCEDURE SPS_FSCHourSummary 
 @StartDate AS SMALLDATETIME,
 @EndDate AS SMALLDATETIME
 
AS
SET NOCOUNT ON
--Build a temp table. This step creates table with the columns as the INSERT below.
---The Where clause causes it to build an empty table
---A table is created before inserting the data. ITS FASTER
SELECT 11 AS MONTH,
 11 AS DAY,
 1111 AS YEAR,
 11 AS HOUR,
 'Secondary Screening' AS 'GROUP',
 0 AS 'SecondaryScreening', 
 0 AS 'FamilyApproaches',
 0 AS 'FamilyUnavailable',
 0 AS 'Consent' 
INTO  #CountTable 
FROM  Call 
JOIN  Referral ON Referral.CallID = Call.CallID
--JOIN  Person SP ON SP.PersonID = FSCase.FSCaseSecCompUserID
--JOIN  SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
WHERE  0 = 1
-- Insert into the temp table
INSERT #CountTable
---Secondary Screening
---- Statline Employees
---- FSCaseSecCompUserID > 0
---- CHARINDEX('Family Services',ReferralSecondaryHistory)>0 
SELECT DATEPART(mm, FSCaseSecCompDateTime),
 DATEPART(dd, FSCaseSecCompDateTime),
 DATEPART(yyyy, FSCaseSecCompDateTime),
 DATEPART(hh, FSCaseSecCompDateTime),
 'Secondary Screening',
 COUNT(Call.CallID), 
 0,
 0,
 0
FROM  Call 
JOIN  FSCase ON FSCase.CallID = Call.CallID
JOIN StatEmployee ON StatEmployee.StatEmployeeID = FSCase.FSCaseSecCompUserID
JOIN Person SD ON SD.PersonID = StatEmployee.PersonID
JOIN  Referral ON Referral.CallID = Call.CallID
JOIN  ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID
WHERE FSCaseSecCompUserID > 0 
AND  CHARINDEX('Family Services',ReferralSecondaryHistory)>0 
AND SD.OrganizationID = 194
AND  CallDateTime 
BETWEEN @StartDate 
AND @EndDate
AND FSCaseSecCompDateTime IS NOT NULL
GROUP 
BY  DATEPART(mm, FSCaseSecCompDateTime),
 DATEPART(dd, FSCaseSecCompDateTime),
 DATEPART(yyyy, FSCaseSecCompDateTime),
 DATEPART(hh, FSCaseSecCompDateTime)
UNION ALL
-- FS Approach
--- Family Services
--- FSCaseApproachUserId > 0
--- PersonTypeID = 84 
SELECT DATEPART(mm, FSCaseApproachDateTime),
 DATEPART(dd, FSCaseApproachDateTime),
 DATEPART(yyyy, FSCaseApproachDateTime),
 DATEPART(hh, FSCaseApproachDateTime),
 'Family Approaches' ,
 0 , 
 COUNT(Call.CallID),
 0,
 0 
FROM  Call 
JOIN  FSCase ON FSCase.CallID = Call.CallID
JOIN  Referral ON Referral.CallID = Call.CallID   
JOIN  Person AP ON AP.PersonID = Referral.ReferralApproachedByPersonID
WHERE FSCaseApproachUserId > 0
AND  AP.OrganizationID = 194 
AND  CallDateTime 
BETWEEN @StartDate 
AND @EndDate
AND FSCaseApproachDateTime IS NOT NULL
GROUP 
BY  DATEPART(mm, FSCaseApproachDateTime),
 DATEPART(dd, FSCaseApproachDateTime),
 DATEPART(yyyy, FSCaseApproachDateTime),
 DATEPART(hh, FSCaseApproachDateTime)
UNION ALL
--Family Unavailable
---FSCaseApproachUserId>0
SELECT  DATEPART(mm, FSCaseApproachDateTime),
 DATEPART(dd, FSCaseApproachDateTime),
 DATEPART(yyyy, FSCaseApproachDateTime),
 DATEPART(hh, FSCaseApproachDateTime),
 'Family Unavailable',
 0, 
 0, 
 SUM(CASE WHEN ReferralBoneApproachID = 3 OR ReferralTissueApproachID =3 OR ReferralSkinApproachID=3 OR ReferralEyesTransApproachID=3  OR ReferralEyesRschApproachID=3 OR ReferralValvesApproachID=3 THEN 1 ELSE 0 END )AS 'FamilyUnavailable',
 0 
FROM  Call 
JOIN  FSCase ON FSCase.CallID = Call.CallID
JOIN LogEvent ON Logevent.CallID = Call.CallID
JOIN  Referral ON Referral.CallID = Call.CallID
JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
JOIN Person ON Person.PersonID = StatEmployee.PersonID
WHERE LogEventTypeID = 7
AND Person.OrganizationID = 194
AND  CallDateTime 
BETWEEN @StartDate 
AND @EndDate
AND FSCaseApproachDateTime IS NOT NULL
GROUP 
BY  DATEPART(mm, FSCaseApproachDateTime),
 DATEPART(dd, FSCaseApproachDateTime),
 DATEPART(yyyy, FSCaseApproachDateTime),
 DATEPART(hh, FSCaseApproachDateTime)
UNION ALL
-- Consent
SELECT  DATEPART(mm, FSCaseFinalDateTime),
 DATEPART(dd, FSCaseFinalDateTime),
 DATEPART(yyyy, FSCaseFinalDateTime),
 DATEPART(hh, FSCaseFinalDateTime),
 'Consented' ,
 0 , 
 0,
 0, 
 COUNT(Call.CallID) 
FROM  Call 
JOIN  FSCase ON FSCase.CallID = Call.CallID
JOIN  Referral ON Referral.CallID = Call.CallID 
JOIN  Person AP ON AP.PersonID = Referral.ReferralApproachedByPersonID
WHERE AP.OrganizationID = 194
AND FSCaseFinalDateTime IS NOT NULL
AND  CallDateTime between @StartDate and @EndDate
AND  (ReferralGeneralConsent = 1 or ReferralGeneralConsent = 2)
AND FSCaseFinalDateTime IS NOT NULL
GROUP 
BY  DATEPART(mm, FSCaseFinalDateTime),
 DATEPART(dd, FSCaseFinalDateTime),
 DATEPART(yyyy, FSCaseFinalDateTime),
 DATEPART(hh, FSCaseFinalDateTime)
SELECT  CAST(Month AS VARCHAR) + '/' + CAST(DAY AS VARCHAR)+ '/' + CAST(YEAR AS VARCHAR) AS 'Date',
 HOUR, 
 SUM(SecondaryScreening) AS 'SecondaryScreening', 
 SUM(FamilyApproaches) AS 'FamilyApproaches', 
 SUM(FamilyUnavailable) AS 'FamilyUnavailable', 
 SUM(FamilyUnavailable + FamilyApproaches)AS 'TotalApproaches',
 SUM(Consent) AS 'Consent'  
FROM  #CountTable
--JOIN  Person ON Person.PersonID = #CountTable.ReferralApproachedByPersonID
--JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
--JOIN SourceCode ON SourceCode.SourceCodeID = #CountTable.SourceCodeID
GROUP 
BY  CAST(Month AS VARCHAR) + '/' + CAST(DAY AS VARCHAR)+ '/' + CAST(YEAR AS VARCHAR) , HOUR 
ORDER 
BY  CAST(Month AS VARCHAR) + '/' + CAST(DAY AS VARCHAR)+ '/' + CAST(YEAR AS VARCHAR) , HOUR 
DROP 
TABLE  #CountTable


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

