SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupsComplete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupsComplete]
GO

CREATE PROCEDURE sps_ReportGroupsComplete

	@vUserOrgID	int		= null,
	@vStart		VARCHAR(1)	= null,
	@vEnd		VARCHAR(1)	= null

AS

IF	@vUserOrgID = 194

	BEGIN

		SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @vUserOrgID 
			and BatchFlag=1
			and SubString(WebReportGroupName,1,1) BETWEEN ISNULL(@vStart,'A') AND ISNULL(@vEnd, 'Z')

		UNION

       		SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName
       		FROM WebReportGroup
       		JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
        		WHERE WebReportGroupMaster = 1
			and BatchFlag=1
		and SubString(OrganizationName,1,1) BETWEEN ISNULL(@vStart,'A') AND ISNULL(@vEnd, 'Z')
		ORDER BY	WebReportGroupName
	END
	
ELSE

	SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @vUserOrgID
	and SubString(WebReportGroupName,1,1) BETWEEN ISNULL(@vStart,'A') AND ISNULL(@vEnd, 'Z')
	
	ORDER BY	WebReportGroupName









GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

