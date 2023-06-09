SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroups]
GO



CREATE PROCEDURE sps_ReportGroups

	@vUserOrgID	int		= null

AS

IF	@vUserOrgID = 194

	BEGIN

		SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @vUserOrgID

		UNION

       		SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName
       		FROM WebReportGroup
       		JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
        		WHERE WebReportGroupMaster = 1

		ORDER BY	WebReportGroupName
	END
	
ELSE

	SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @vUserOrgID
	ORDER BY	WebReportGroupName






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

