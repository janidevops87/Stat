

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportParametersByReport')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportParametersByReport'
		DROP Procedure sps_ReportParametersByReport
	END
GO

PRINT 'Creating Procedure sps_ReportParametersByReport'
GO


CREATE PROCEDURE [dbo].[sps_ReportParametersByReport]
	@ReportID INT
 AS 
/******************************************************************************
**	File: sps_ReportParametersByReport.sql
**	Name: sps_ReportParametersByReport
**	Desc: Pulls list of parameters for a report.
**	Auth: Pam Scheichenost
**	Date: 11/09/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/09/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

select DISTINCT con.ReportControlName, sec.ReportParamSectionName
from report r
inner join ReportParamConfiguration config on r.ReportID = config.ReportID
inner join ReportControl con on config.ReportControlID = con.ReportControlID
inner join ReportParamSection sec on con.ReportParamSectionID = sec.ReportParamSectionID
WHERE r.ReportID = @ReportId
GO




GRANT EXEC ON sps_ReportParametersByReport TO PUBLIC
GO
