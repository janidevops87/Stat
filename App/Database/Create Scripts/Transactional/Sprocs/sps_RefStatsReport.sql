SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RefStatsReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RefStatsReport]
GO

CREATE PROCEDURE sps_RefStatsReport
		@UserOrgID int

 AS
declare 	@ctr	int
	
	If @UserOrgID = 194	
		BEGIN
			SELECT DISTINCT
				 	ReportID, 
					ReportDisplayName, 
					ReportVirtualUrl, 
					ReportDescFileName 
			FROM 		Report 
			WHERE 	ReportTypeID = 4
			ORDER BY	ReportDisplayName
		END

	ELSE
		BEGIN

		SELECT @ctr = Count(*) 
		FROM 		Report 
		JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
		WHERE 	ReportTypeID = 4
		AND 		ReportLocalOnly = 0
		AND		ReportCustomOrganizationID = @UserOrgID
		
		IF @ctr	<> 0 
		BEGIN
			SELECT DISTINCT	
					ReportID, 
					ReportDisplayName, 
					ReportVirtualUrl, 
					ReportDescFileName 
			FROM 		Report 
			JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
			WHERE 	ReportTypeID = 4
			AND		ReportCustomOrganizationID = @UserOrgID
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
			WHERE 	ReportTypeID = 4
			AND 		ReportLocalOnly = 0
			ORDER BY	ReportDisplayName
		END
	END
	







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

