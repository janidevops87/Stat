SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebReportGroupName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebReportGroupName]
GO


CREATE PROCEDURE sps_WebReportGroupName

@RepGrpID  int

 AS

Begin 
	SELECT	WebReportGroupID, WebReportGroupName  AS ReportGroupName
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = 194 AND WebReportGroupID = @RepGrpID

	UNION

	SELECT DISTINCT WebReportGroupID, OrganizationName + ' (' + WebReportGroupName + ') ' AS ReportGroupName
	FROM WebReportGroup
	JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
	 WHERE WebReportGroupMaster = 1 AND WebReportGroupID = @RepGrpID

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

