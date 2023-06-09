SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_reportGroupList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_reportGroupList]
GO





/* 
 * PROCEDURE: ReportGroupListSelProc 
 */

CREATE PROCEDURE sps_reportGroupList AS
			SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = 194

		UNION

       		SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName
       		FROM WebReportGroup
       		JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
        		WHERE WebReportGroupMaster = 1

		ORDER BY	WebReportGroupName




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

