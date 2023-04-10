 
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleGroupOrganizationSelect'
		DROP Procedure ScheduleGroupOrganizationSelect
	END
GO

PRINT 'Creating Procedure ScheduleGroupOrganizationSelect'
GO
CREATE Procedure ScheduleGroupOrganizationSelect
(
		@ScheduleGroupOrganizationID int = null,
		@ScheduleGroupID int = null,
		@OrganizationID int = null
		 				
)
AS
/******************************************************************************
**	File: ScheduleGroupOrganizationSelect.sql
**	Name: ScheduleGroupOrganizationSelect
**	Desc: Selects multiple rows of ScheduleGroupOrganization Based on Id  fields 
**	Auth: ccarroll	
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll				Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ScheduleGroupOrganization.ScheduleGroupOrganizationID,
		IsNull(ScheduleGroupOrganization.ScheduleGroupID, 0) AS ScheduleGroupID,
		IsNull(ScheduleGroupOrganization.OrganizationID, 0) AS OrganizationID,
		ScheduleGroupOrganization.LastModified,
		IsNull(ScheduleGroupOrganization.UpdatedFlag, 0) AS UpdatedFlag
	FROM 
		dbo.ScheduleGroupOrganization 
	WHERE 
		ScheduleGroupOrganization.ScheduleGroupOrganizationID = ISNULL(@ScheduleGroupOrganizationID, ScheduleGroupOrganization.ScheduleGroupOrganizationID) AND
		ScheduleGroupOrganization.ScheduleGroupID = ISNULL(@ScheduleGroupID, ScheduleGroupOrganization.ScheduleGroupID) AND
		ScheduleGroupOrganization.OrganizationID = ISNULL(@OrganizationID, ScheduleGroupOrganization.OrganizationID)
	ORDER BY 1
GO

GRANT EXEC ON ScheduleGroupOrganizationSelect TO PUBLIC
GO
