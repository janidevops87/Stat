SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupOrgParentID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupOrgParentID]
GO






/****** Object:  Stored Procedure dbo.sps_ReportGroupOrgParentID    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReportGroupOrgParentID

	@vReportGroupID	int		= null

AS

SELECT	OrgHierarchyParentID, OrganizationName
FROM		WebReportGroup
JOIN		Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
WHERE 	WebReportGroupID = @vReportGroupID






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

