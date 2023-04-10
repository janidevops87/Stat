

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationAlerts')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationAlerts'
		PRINT GETDATE()
		DROP Procedure SelectRotationAlerts
	END
GO

PRINT 'Creating Procedure SelectRotationAlerts'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationAlerts
(
		@Rotationid int = null,
		@RotationGroupID int = null,
		@AlertID int = null				
)
AS
/******************************************************************************
**	File: SelectRotationAlerts.sql
**	Name: SelectRotationAlerts
**	Desc: Selects multiple rows of RotationAlerts Based on Id  fields 
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
		RotationAlerts.Rotationid,
		RotationAlerts.RotationGroupID,
		RotationAlerts.AlertID,
		RotationAlerts.AlertType,
		RotationAlerts.AlertGroupName,
		RotationAlerts.id
	FROM 
		dbo.RotationAlerts 
	WHERE 
		RotationAlerts.Rotationid = ISNULL(@Rotationid, RotationAlerts.Rotationid)
	AND
		RotationAlerts.RotationGroupID = ISNULL(@RotationGroupID, RotationAlerts.RotationGroupID)
	AND
		RotationAlerts.AlertID = ISNULL(@AlertID, RotationAlerts.AlertID)

GO

GRANT EXEC ON SelectRotationAlerts TO PUBLIC
GO
