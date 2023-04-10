SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupMaster]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupMaster]
GO




CREATE PROCEDURE sps_ReportGroupMaster

	@vUserOrgID	int		= null

AS

SELECT	WebReportGroupID
FROM		WebReportGroup
WHERE 	WebReportGroupMaster = 1
AND		OrgHierarchyParentID = @vUserOrgID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

