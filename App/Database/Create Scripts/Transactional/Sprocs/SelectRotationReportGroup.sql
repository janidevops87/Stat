

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationReportGroup')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationReportGroup'
		PRINT GETDATE()
		DROP Procedure SelectRotationReportGroup
	END
GO

PRINT 'Creating Procedure SelectRotationReportGroup'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationReportGroup
(
		@RotationID int = null,
		@RotationGroupID int = null,
		@RotationReportGroupID int = null
)
AS
/******************************************************************************
**	File: SelectRotationReportGroup.sql
**	Name: SelectRotationReportGroup
**	Desc: Selects multiple rows of RotationReportGroup Based on Id  fields 
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
		RotationReportGroup.RotationID,
		RotationReportGroup.RotationGroupID,
		RotationReportGroup.RotationReportGroupName,
		RotationReportGroup.RotationReportGroupID,
		RotationReportGroup.RotationReportGroupType,
		RotationReportGroup.RotationReportGroupTypeName,
		RotationReportGroup.RotationAddAccessDate,
		RotationReportGroup.ID
	FROM 
		dbo.RotationReportGroup 
	WHERE 
		RotationReportGroup.RotationID = ISNULL(@RotationID, RotationReportGroup.RotationID)
	AND
		RotationReportGroup.RotationGroupID = ISNULL(@RotationGroupID, RotationReportGroup.RotationGroupID)
	AND
		RotationReportGroup.RotationReportGroupID = ISNULL(@RotationReportGroupID, RotationReportGroup.RotationReportGroupID)

GO

GRANT EXEC ON SelectRotationReportGroup TO PUBLIC
GO
