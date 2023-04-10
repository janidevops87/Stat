

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportOrganizationTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportOrganizationTypeDropDown';
		DROP Procedure sps_ReportOrganizationTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportOrganizationTypeDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportOrganizationTypeDropDown]
	
 AS 
 /******************************************************************************
**	File: sps_ReportOrganizationTypeDropDown.sql
**	Name: sps_ReportOrganizationTypeDropDown
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

select OrganizationTypeID as [value], 
	OrganizationTypeName as [label]
from OrganizationType
where ISNULL(inactive,0) = 0
order by organizationTypeName;


GO

GRANT EXEC ON sps_ReportOrganizationTypeDropDown TO PUBLIC;
GO
