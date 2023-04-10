

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportQATrackingTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportQATrackingTypeDropDown';
		DROP Procedure sps_ReportQATrackingTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportQATrackingTypeDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportQATrackingTypeDropDown]
 (
	@OrganizationId int
 )
	
 AS 
 /******************************************************************************
**	File: sps_ReportQATrackingTypeDropDown.sql
**	Name: sps_ReportQATrackingTypeDropDown
**	Desc: Populates dropdown for report years dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/24/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/24/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

select QATrackingTypeID as [value], 
	QATrackingTypeDescription as [label]
from QATrackingType
where OrganizationID = @OrganizationId
order by QATrackingTypeDescription;


GO

GRANT EXEC ON sps_ReportQATrackingTypeDropDown TO PUBLIC;
GO
