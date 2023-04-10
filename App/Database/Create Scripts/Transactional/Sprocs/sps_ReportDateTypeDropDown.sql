

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportDateTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportDateTypeDropDown'
		DROP Procedure sps_ReportDateTypeDropDown
	END
GO

PRINT 'Creating Procedure sps_ReportDateTypeDropDown'
GO


 CREATE PROCEDURE [dbo].[sps_ReportDateTypeDropDown]
	@ReportID INT = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportDateTypeDropDown.sql
**	Name: sps_ReportDateTypeDropDown
**	Desc: Populates dropdown for date type dropdown in reporting.
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

 SELECT 
	rdt.ReportDateTypeID as [value],
	rdt.ReportDateTypeDisplayname as [label]
FROM	
	ReportDateTypeConfiguration rdtc
JOIN
	ReportDateType rdt ON rdt.ReportDateTypeID = rdtc.ReportDateTypeID
WHERE
	rdtc.Reportid = @ReportID
GO

GRANT EXEC ON sps_ReportDateTypeDropDown TO PUBLIC
GO
