IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportScreeningCriteriaOrganizationsDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportScreeningCriteriaOrganizationsDropDown';
		DROP PROCEDURE sps_ReportScreeningCriteriaOrganizationsDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportScreeningCriteriaOrganizationsDropDown';
GO


CREATE PROCEDURE [dbo].[sps_ReportScreeningCriteriaOrganizationsDropDown]	
AS
 /******************************************************************************
**	File: sps_ReportScreeningCriteriaOrganizationsDropDown.sql
**	Name: sps_ReportScreeningCriteriaOrganizationsDropDown
**	Desc: Populates dropdown for Screening Client Organizations dropdown in reporting.
**	Auth: James Gerberich
**	Date: 07/15/2021
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	07/15/2021		James Gerberich				Initial Sproc Creation
**	08/26/2021		Mike Berenson				Added aliases to output & renamed sproc
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT DISTINCT
	org.OrganizationID AS 'value',
	org.OrganizationName AS 'label'
FROM
	Organization org
	INNER JOIN ScheduleGroup sg ON org.OrganizationID = sg.OrganizationID
	INNER JOIN CriteriaScheduleGroup csg ON sg.ScheduleGroupID = csg.ScheduleGroupID
	INNER JOIN Criteria c ON csg.CriteriaID = c.CriteriaID AND c.CriteriaStatus = 1
ORDER BY OrganizationName;

GO

GRANT EXEC ON sps_ReportScreeningCriteriaOrganizationsDropDown TO PUBLIC;
GO