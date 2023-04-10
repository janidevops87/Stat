

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectScheduleGroup')
	BEGIN
		PRINT 'Dropping Procedure SelectScheduleGroup'
		PRINT GETDATE()
		DROP Procedure SelectScheduleGroup
	END
GO

PRINT 'Creating Procedure SelectScheduleGroup'
PRINT GETDATE()
GO
CREATE Procedure SelectScheduleGroup
(
		@ScheduleGroupID int = null output,
		@OrganizationID int = null					
)
AS
/******************************************************************************
**	File: SelectScheduleGroup.sql
**	Name: SelectScheduleGroup
**	Desc: Selects multiple rows of ScheduleGroup Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ScheduleGroup.ScheduleGroupID,
		ScheduleGroup.OrganizationID,
		ScheduleGroup.ScheduleGroupName,
		ScheduleGroup.Verified,
		ScheduleGroup.Inactive,
		ScheduleGroup.LastModified,
		ScheduleGroup.ScheduleGroupReferralNotes,
		ScheduleGroup.ScheduleGroupMessageNotes,
		ScheduleGroup.ScheduleGroupCode,
		ScheduleGroup.UpdatedFlag,
		ScheduleGroup.UseNewSchedule
	FROM 
		dbo.ScheduleGroup 
	WHERE 
		ScheduleGroup.ScheduleGroupID = ISNULL(@ScheduleGroupID, ScheduleGroup.ScheduleGroupID)
	AND
		ScheduleGroup.OrganizationID = ISNULL(@OrganizationID, ScheduleGroup.OrganizationID)				

GO

GRANT EXEC ON SelectScheduleGroup TO PUBLIC
GO
