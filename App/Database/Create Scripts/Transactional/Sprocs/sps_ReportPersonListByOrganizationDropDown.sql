IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportPersonListByOrganizationDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportPersonListByOrganizationDropDown';
		DROP Procedure sps_ReportPersonListByOrganizationDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportPersonListByOrganizationDropDown';
GO

CREATE PROCEDURE [dbo].[sps_ReportPersonListByOrganizationDropDown]
	@OrganizationId	INT = NULL,
	@Inactive		INT = NULL
AS
 /******************************************************************************
**	File: sps_ReportPersonListByOrganizationDropDown.sql
**	Name: sps_ReportPersonListByOrganizationDropDown
**	Desc: Populates dropdown for persons by organization Id in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/02/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/02/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT     
	PersonID as [value], 
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') [label]
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
GO

GRANT EXEC ON sps_ReportPersonListByOrganizationDropDown TO PUBLIC;
GO

