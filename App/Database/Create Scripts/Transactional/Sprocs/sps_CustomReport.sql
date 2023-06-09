SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CustomReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CustomReport]
GO


CREATE PROCEDURE sps_CustomReport
		@UserOrgID int
	
 AS

	
	If @UserOrgID = 194	
		BEGIN
			SELECT DISTINCT
				 	ReportID, 
					ReportDisplayName, 
					ReportVirtualUrl, 
					ReportDescFileName 
			FROM 		Report 
			WHERE 	ReportTypeID = 6 
			ORDER BY	ReportDisplayName
		END

	ELSE
		BEGIN
			SELECT DISTINCT	
					ReportID, 
					ReportDisplayName, 
					ReportVirtualUrl, 
					ReportDescFileName 
			FROM 		Report 
			JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
			WHERE 	ReportTypeID = 6 
			AND		ReportCustomOrganizationID = @UserOrgID
			ORDER BY	ReportDisplayName
		END
	





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

