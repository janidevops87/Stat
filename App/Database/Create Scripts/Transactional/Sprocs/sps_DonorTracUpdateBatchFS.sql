SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracUpdateBatchFS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_DonorTracUpdateBatchFS]'
	drop procedure [dbo].[sps_DonorTracUpdateBatchFS]
END
PRINT 'Creating procedure [sps_DonorTracUpdateBatchFS]'


GO




-- old stuff updated 05/25/2006




CREATE PROCEDURE sps_DonorTracUpdateBatchFS 
		@vUserName as varchar(50),
		@vPassWord as varchar(50),
		
		@PreviousDay as datetime,
		@CurrentDay as datetime
AS
/******************************************************************************
**		File: sps_DonorTracUpdateBatchFS.sql
**		Name: sps_DonorTracUpdateBatchFS
**		Desc: 
**			Retrieves a list of CallID for processing by DonorTrac
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
**		--------		--------			------------------------------------------
**		2005		Thien Ta				initial
**		5/4/2007	Bret Knoll				removed check for FinalUserID
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**      07/09       jth					Comment webreport group code and now join to function
**		04/08/2011	Bret Knoll			Added check For CallActive WI 8311
**		03/17/2015	Bret Knoll			Converted to fn_rpt_ConvertDateTime
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
	declare
		@SourcecodeID as varchar(10),
		@WebReportID as varchar(10),
		@vOrgID as int,
		@vSourceCode as int,
		@vReportGroupID as int,
		@vSourceCodeName as varchar(10),
		@vSourceCodeIDRef as int,
		@webReportGroupName varchar(100),
		@TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;


SELECT 	@vOrgID = Person.OrganizationID
FROM	WebPerson
JOIN	Person ON Person.PersonID = WebPerson.PersonID
WHERE 	WebPersonUserName = @vUserName
AND 	HashedPassword = @TargetHashedPassword

Print @vOrgID
--Add for conversion of datetime range previousday currentday T.T 08/08/2005 dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified) as LastModified
set @CurrentDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @CurrentDay, 0)  
set @PreviousDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @PreviousDay, 0)  
Print @PreviousDay
Print @CurrentDay
--Get SourceCode
select   @vSourceCode= Sourcecode.SourceCodeID from sourcecodeorganization JOIN SourceCode 
ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID where organizationID = @vOrgID and sourcecodetype = 1 and sourcecode.sourcecodeID <>170
--select  @vSourceCode = SourcecodeID from sourceCodeOrganization where OrganizationID = @vOrgID
Print @vSourceCode

-- Get SourceCode Name
select @vSourceCodeName = SourcecodeName from Sourcecode where SourcecodeID = @vSourceCode

Print @vSourceCodeName

-- Get sourcecodeType
select  @vSourceCodeIDRef = SourcecodeID from sourcecode where sourcecodeName = @vSourceCodeName and sourcecodeType = 1

Print @vSourceCodeIDRef


Print @vReportGroupID

SELECT DISTINCT 
	CA.CallID 
FROM Referral 
JOIN Call CA ON CA.CallID = Referral.CallID 
JOIN 
	(
	SELECT 		
		SourceCodeID, 
		OrgID
	FROM dbo.fn_GetStatInfoReportWebGroups(@vUserName)
	) fn ON fn.sourcecodeid =ca.sourcecodeid 
	AND fn.orgid = ReferralCallerOrganizationID 

WHERE 
	CA.CallDateTime BETWEEN @PreviousDay AND @CurrentDay  
AND EXISTS (
		SELECT 
			CA.CallID 
		FROM 
			FSCase as FSC 
		WHERE 
			FSC.CallID = CA.CallID
		) 
AND
	(
	ISNULL(CA.CallActive,-1) = -1
	)

ORDER BY 
	ca.callID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

