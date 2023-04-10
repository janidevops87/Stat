

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportSortTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportSortTypeDropDown';
		DROP Procedure sps_ReportSortTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportSortTypeDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportSortTypeDropDown]
	@ReportId INT = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportSortTypeDropDown.sql
**	Name: sps_ReportSortTypeDropDown
**	Desc: Populates dropdown for report sort type dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/17/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/17/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT 
	
	rdt.ReportSortTypeName as [value],
	rdt.ReportSortTypeDisplayname as [label]

FROM	
	ReportSortTypeConfiguration rdtc
JOIN
	ReportSortType rdt ON rdt.ReportSortTypeID = rdtc.ReportSortTypeID
WHERE
	rdtc.Reportid = ISNULL(@ReportId, 0)

GO

GRANT EXEC ON sps_ReportSortTypeDropDown TO PUBLIC;
GO
