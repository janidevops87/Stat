

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationScheduleGroup')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationScheduleGroup'
		PRINT GETDATE()
		DROP Procedure SelectRotationScheduleGroup
	END
GO

PRINT 'Creating Procedure SelectRotationScheduleGroup'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationScheduleGroup
(
		@RotationID int = null,
		@RotationGroupID int = null,
		@RotationScheduleGroupID int = null
)
AS
/******************************************************************************
**	File: SelectRotationScheduleGroup.sql
**	Name: SelectRotationScheduleGroup
**	Desc: Selects multiple rows of RotationScheduleGroup Based on Id  fields 
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
		RotationScheduleGroup.RotationID,
		RotationScheduleGroup.RotationGroupID,
		RotationScheduleGroup.RotationScheduleGroupName,
		RotationScheduleGroup.RotationScheduleGroupID,
		RotationScheduleGroup.RotationScheduleGroupType,
		RotationScheduleGroup.RotationScheduleGroupTypeName,
		RotationScheduleGroup.ID
	FROM 
		dbo.RotationScheduleGroup 
	WHERE 
		RotationScheduleGroup.RotationID = ISNULL(@RotationID, RotationScheduleGroup.RotationID)
	AND
		RotationScheduleGroup.RotationGroupID = ISNULL(@RotationGroupID, RotationScheduleGroup.RotationGroupID)
	AND
		RotationScheduleGroup.RotationScheduleGroupID = ISNULL(@RotationScheduleGroupID, RotationScheduleGroup.RotationScheduleGroupID)

GO

GRANT EXEC ON SelectRotationScheduleGroup TO PUBLIC
GO
