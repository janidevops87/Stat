SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatTracReportGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatTracReportGroups]
GO




CREATE PROCEDURE sps_StatTracReportGroups
			@vUserName as varchar(20),
			@vPassword as varchar(20)

AS

			declare
			@vOrgID as int


SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword

Select  distinct wrg.WebReportGroupID as 'ID', wrg.webreportgroupname as 'Value'  From 
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

