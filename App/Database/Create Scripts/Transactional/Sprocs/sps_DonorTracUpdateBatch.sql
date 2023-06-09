SET QUOTED_IDENTIFIER ON; 
GO
SET ANSI_NULLS OFF; 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracUpdateBatch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		drop procedure [dbo].[sps_DonorTracUpdateBatch];
		PRINT 'Dropping sps_DonorTracUpdateBatch' ;
	END
PRINT 'Creating sps_DonorTracUpdateBatch' ;
GO


CREATE PROCEDURE sps_DonorTracUpdateBatch
		@vUserName as varchar(50),
		@vPassWord as varchar(50),
		
		@PreviousDay as datetime,
		@CurrentDay as datetime
AS
/******************************************************************************
**		File: sps_DonorTracUpdateBatch.sql
**		Name: sps_DonorTracUpdateBatch
**		Desc: 
**			Retrieves a list of CallID for processing by DonorTrac
**			Inserts a record into DonorTracBatchLog
**			Updates unusedfield3 = 1
**
**              
**		Return values: CallID Dataset
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vUserName as varchar(50),
**		@vPassWord as varchar(50),
**		
**		@PreviousDay as datetime,
**		@CurrentDay as datetime
**
**  
**		Auth: Thien Ta
**		Date: 2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		2005		Thien Ta			initial
**		9/26/2007	Bret Knoll			Added code to resend referrals donrotrac never pulled
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**      07/09       jth					Comment webreport group code and now join to function
**		04/08/2011	Bret Knoll			Added check For CallActive WI 8311
**		03/17/2015	Bret Knoll			Converted to fn_rpt_ConvertDateTime
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;

DECLARE
		@SourcecodeID as varchar(10),
		@WebReportID as varchar(10),
		@vOrgID as int,
		@vSourceCode as int,
		@vReportGroupID as int,
		@vSourceCodeName as varchar(10),
		@vBatchRun as datetime = GETDATE(),
		@webReportGroupName varchar(100),
		@TargetHashedPassword VARCHAR(100),
		@IIAMSOURCECODEID int = 170;

SELECT @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
	FROM [dbo].[WebPerson]
	JOIN 	Person ON Person.PersonID = WebPerson.PersonID
	WHERE [WebPersonUserName] = @vUserName 
	AND 	Person.Inactive <> 1;


SELECT 	@vOrgID = Person.OrganizationID
FROM	WebPerson
JOIN	Person ON Person.PersonID = WebPerson.PersonID
WHERE 	WebPersonUserName = @vUserName
AND 	HashedPassword = @TargetHashedPassword;


--Add for conversion of datetime range previousday currentday T.T 08/08/2005 dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified) as LastModified
SELECT 
	@CurrentDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @CurrentDay, 0),
	@PreviousDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @PreviousDay, 0);  

--Get SourceCode 
select   
	@vSourceCode= Sourcecode.SourceCodeID,
	@vSourceCodeName = Sourcecode.SourcecodeName  
from sourcecodeorganization 
JOIN SourceCode ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID 
where organizationID = @vOrgID 
and sourcecodetype = 1 
and sourcecode.sourcecodeID <> @IIAMSOURCECODEID;

SELECT 		
	SourceCodeID, 
	OrgID
INTO #WebGroups
FROM dbo.fn_GetStatInfoReportWebGroups (@vUserName);


SELECT DISTINCT 
	CA.CallID
INTO #CallImport
FROM Referral 
JOIN Call CA ON CA.CallID = Referral.CallID 
JOIN #WebGroups fn ON ca.sourcecodeid =fn.sourcecodeid and fn.orgid = ReferralCallerOrganizationID
LEFT JOIN FSCase fs on CA.CallID = fs.CallId
WHERE 
	CA.CallDateTime >=  @PreviousDay 
	AND CA.CallDateTime <= @CurrentDay 
AND 
	(
		(referral.unusedfield3 IS NULL OR referral.unusedfield3 = 0)
	OR
	(
		(referral.unusedfield3 IS NULL OR referral.unusedfield3 = 1) 	
	AND
		(referral.unusedfield1 IS NULL OR referral.unusedfield1 = 0) 	
	)		
	
	)
AND 
	CA.CallTemp = 0  
AND 
	(
		(fs.CallId IS NULL) 
	OR
		(fs.CallId IS NOT NULL AND fs.FSCaseFinalUserId <> 0)
	)
AND
	(
		(CA.CallActive IS NULL OR CA.CallActive = -1)
	)
ORDER BY 
	ca.callID;

--Pull list for donortrac
SELECT * FROM #CallImport;

--Update field
UPDATE Referral 
	SET unusedfield3 = 1
FROM Referral r 
JOIN #CallImport c ON r.callID = c.CallID;

--Record BatchLog
insert into DonorTracBatchLog(SourcecodeID,SourcecodeName,StartTime,EndTime,RunTime) values
(@vSourceCode,@vSourceCodeName,@PreviousDay,@CurrentDay,@vBatchRun);




GO
SET QUOTED_IDENTIFIER OFF; 
GO
SET ANSI_NULLS ON; 
GO

