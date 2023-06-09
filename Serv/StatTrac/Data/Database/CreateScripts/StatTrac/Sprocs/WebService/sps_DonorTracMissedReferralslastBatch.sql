SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracMissedReferralslastBatch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		drop procedure [dbo].[sps_DonorTracMissedReferralslastBatch]
		PRINT 'Dropping sps_DonorTracMissedReferralslastBatch' 
	END
PRINT 'Creating sps_DonorTracMissedReferralslastBatch' 
GO



CREATE PROCEDURE sps_DonorTracMissedReferralslastBatch --@SourcecodeID as varchar(10),
		--@WebReportID as varchar(10),
		@vUserName as varchar(50),
		@vPassWord as varchar(50)
		
		
AS
/******************************************************************************
**		File: 
**		Name: sps_DonorTracMissedReferralslastBatch 
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Thien Ta
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-----------------------------------
**		Unknown		Thien Ta	
**		9/26/07		Bret Knoll			Added code to include referrals donortrac did not request.	
**		06/30/08	Bret Knoll			Create functionality to not include source codes when certain 
**										users are used to run the sproc.
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
DECLARE
		@PreviousDay as datetime,
		@CurrentDay as datetime,
		@SourcecodeID as varchar(10),
		@WebReportID as varchar(10),
		@vOrgID as int,
		@vSourceCode as int,
		@vReportGroupID as int,
		@vSourceCodeName as varchar(10),
		@vSourceCodeIDRef as int,
		@ID as int,
		@webReportGroupName varchar(100)

/* 6/30/08 

	for any client where a sourcecode should not be pulled have clients services create a 
	"DTStatTrac Imports" web report group.
	
	Add an IF statement to check for the @vUserName and add the DTClient user to the in statement
*/
	IF (@vUserName IN( 'DTMTF'))
	BEGIN
		SET @webReportGroupName = 'DTStatTrac Imports'
	END
	ELSE
	BEGIN
		SET @webReportGroupName = 'All Referrals'
	END
	
/* End 6/30/08 Section */

SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword
Print @vOrgID
--Add for conversion of datetime range previousday currentday T.T 08/08/2005 dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified) as LastModified
select organizationname as group_name from organization where organizationID = @vOrgID
Print @PreviousDay
Print @CurrentDay
--Get SourceCode
select   @vSourceCode= Sourcecode.SourceCodeID from sourcecodeorganization JOIN SourceCode 
ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID where organizationID = @vOrgID and sourcecodetype = 1 and sourcecode.sourcecodeID <>170
--select   @vSourceCode = SourcecodeID from sourceCodeOrganization where OrganizationID = @vOrgID
Print @vSourceCode

-- Get SourceCode Name
select @vSourceCodeName = SourcecodeName from Sourcecode where SourcecodeID = @vSourceCode

Print @vSourceCodeName

-- Get sourcecodeType
select  @vSourceCodeIDRef = SourcecodeID from sourcecode where sourcecodeName = @vSourceCodeName and sourcecodeType = 1

Print @vSourceCodeIDRef

--Retrieve WebReportGroup
Select @vReportGroupID = wrg.WebReportGroupID  From 
WebReportGroup wrg join webreportgroupsourcecode wrgsc on wrg.webReportGroupID = wrgsc.webReportGroupID
left join organization o on o.organizationid = wrg.OrgHierarchyParentid
where 
	WebReportGroupName = @webReportGroupName
--and wrgsc.sourceCodeID  = @vSourceCodeIDRef
and o.OrganizationID = @vOrgID

Print @vReportGroupID

--select max(ID) from donortracbatchlog where sourcecodeid = 315

select @CurrentDay=EndTime,@PreviousDay=StartTime from donortracbatchlog where sourcecodeid = @vSourceCode and id = (select max(ID)from donortracbatchlog where sourcecodeid = @vSourceCode)
select RunTime as BatchRun_Time from donortracbatchlog  where sourcecodeid =@vSourceCode and id = (select max(ID)from donortracbatchlog where sourcecodeid = @vSourceCode)
select @vSourceCodeName as sourcecode

Print @CurrentDay
Print @PreviousDay
				
SELECT DISTINCT 
	CA.CallID as call_number, 
	ca.CallDateTime as Create_Date,
	me.organizationname as Referral_Facility, 
	ReferralDonorFirstName as first_name, 
	ReferralDonorLastName as last_name,
	ReferralDOB as dob  
	, referral.unusedfield3
	, referral.unusedfield1
FROM Referral 
JOIN 
	Call CA ON CA.CallID = Referral.CallID 
LEFT JOIN 
	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
LEFT JOIN 
	Organization ME ON ME.OrganizationID = Referral.ReferralCallerOrganizationID
WHERE 
	CA.CallDateTime BETWEEN  @PreviousDay AND @CurrentDay 
AND 
	ca.SourceCodeID in (SELECT DISTINCT 
							SourceCode.SourceCodeID 
						FROM 
							SourceCode 
						JOIN 
							WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
						WHERE 
							WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID)
AND 
	CA.CallTemp = 0  
--and not EXISTS (SELECT CA.CallID FROM FSCase as FSC WHERE FSC.CallID = CA.CallID ) 
AND (
	ISNULL(referral.unusedfield3, 0) = 0
OR
	(
		ISNULL(referral.unusedfield3, 0) = 1 	
	AND
		ISNULL(referral.unusedfield1, 0) = 0 	
	)		
	
	)
	
ORDER BY ca.callID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

