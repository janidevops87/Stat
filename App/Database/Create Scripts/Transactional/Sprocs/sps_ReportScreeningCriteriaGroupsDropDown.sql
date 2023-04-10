IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportScreeningCriteriaGroupsDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportScreeningCriteriaGroupsDropDown';
		DROP PROCEDURE sps_ReportScreeningCriteriaGroupsDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportScreeningCriteriaGroupsDropDown';
GO


CREATE PROCEDURE [dbo].[sps_ReportScreeningCriteriaGroupsDropDown]
(
	@OrganizationID     int = null --51
)
AS
 /******************************************************************************
**	File: sps_ReportScreeningCriteriaGroupsDropDown.sql
**	Name: sps_ReportScreeningCriteriaGroupsDropDown
**	Desc: Populates dropdown for Criteria Group dropdown in reporting.
**	Auth: James Gerberich
**	Date: 07/15/2021
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	07/15/2021		James Gerberich				Initial Sproc Creation
**	08/26/2021		Mike Berenson				Updated aliases on output
**	08/30/2021		Mike Berenson				Updated alias in order by statement
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT DISTINCT
	c.CriteriaID AS 'value',
	c.CriteriaGroupName + ' - ' + dc.DonorCategoryName AS 'label'
FROM
	Criteria c
	INNER JOIN DonorCategory dc ON c.DonorCategoryID = dc.DonorCategoryID
	INNER JOIN CriteriaScheduleGroup csg ON c.CriteriaID = csg.CriteriaID
	INNER JOIN ScheduleGroup sg ON csg.ScheduleGroupID = sg.ScheduleGroupID
WHERE
	c.CriteriaStatus = 1
AND	(
		@OrganizationID IS NULL
	OR	sg.OrganizationID = @OrganizationID
	)
ORDER BY [label];

GO

GRANT EXEC ON sps_ReportScreeningCriteriaGroupsDropDown TO PUBLIC;
GO