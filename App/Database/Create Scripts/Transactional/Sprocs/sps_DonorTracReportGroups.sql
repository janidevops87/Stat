SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracReportGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorTracReportGroups]
GO





CREATE PROCEDURE sps_DonorTracReportGroups
			@vUserName as varchar(20),
			@vPassword as varchar(20)

AS
/******************************************************************************
**		File: sps_DonorTracReportGroups.sql
**		Name: sps_DonorTracReferralFSMedications
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*********************************************************************************/
			declare
			@vOrgID as int,
			@TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;

SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	HashedPassword = @TargetHashedPassword

Select  distinct wrg.WebReportGroupID as 'ID', wrg.webreportgroupname as 'Value' From 
WebReportGroup wrg join webreportgroupsourcecode wrgsc on wrg.webReportGroupID = wrgsc.webReportGroupID
left join organization o on o.organizationid = wrg.OrgHierarchyParentid
 --WebReportGroupMaster = 1  
--and WebReportGroupName = 'All Referrals' 
--and wrgsc.sourceCodeID  = @vSourceCodeIDRef
where o.OrganizationID = @vOrgID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

