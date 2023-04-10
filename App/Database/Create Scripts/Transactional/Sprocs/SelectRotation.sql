

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotation')
	BEGIN
		PRINT 'Dropping Procedure SelectRotation'
		PRINT GETDATE()
		DROP Procedure SelectRotation
	END
GO

PRINT 'Creating Procedure SelectRotation'
PRINT GETDATE()
GO
CREATE Procedure SelectRotation
(
		@RotationID int = null,
		@RotationGroupID int = null,
		@ServiceLevelID int = null					
)
AS
/******************************************************************************
**	File: SelectRotation.sql
**	Name: SelectRotation
**	Desc: Selects multiple rows of Rotation Based on Id  fields 
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
		Rotation.RotationID,
		Rotation.RotationName,
		Rotation.RotationFrequency,
		Rotation.RotationSequence,
		Rotation.RotationLastRun,
		Rotation.RotationNextRun,
		Rotation.RotationReportAccessDate,
		Rotation.ID,
		Rotation.RotationGroupID,
		Rotation.ServiceLevelID,
		Rotation.ServiceLevelName,
		Rotation.CurrentRotation,
		Rotation.RotationRemediate
	FROM 
		dbo.Rotation 
	WHERE 
		Rotation.RotationID = ISNULL(@RotationID, Rotation.RotationID)
	AND
		Rotation.RotationGroupID = ISNULL(@RotationGroupID, Rotation.RotationGroupID)
	AND
		Rotation.ServiceLevelID = ISNULL(@ServiceLevelID, Rotation.ServiceLevelID)				

GO

GRANT EXEC ON SelectRotation TO PUBLIC
GO
