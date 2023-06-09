SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineHospitalSourceCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineHospitalSourceCode]
GO

CREATE PROCEDURE sps_OnlineHospitalSourceCode
			@OrganizationID as int


 AS

SELECT DISTINCT WebReportGroupSourceCode.SourceCodeID AS SourceCodeID, SourceCode.SourceCodeName
FROM         WebReportGroup INNER JOIN
                      Organization ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID INNER JOIN
                      WebReportGroupSourceCode ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID INNER JOIN
                      SourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
WHERE     (Organization.OrganizationID =@OrganizationID) AND (SourceCode.SourceCodeType = 1)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

