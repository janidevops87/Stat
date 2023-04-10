

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationCriteria')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationCriteria'
		PRINT GETDATE()
		DROP Procedure SelectRotationCriteria
	END
GO

PRINT 'Creating Procedure SelectRotationCriteria'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationCriteria
(
		@RotationID int = null,
		@RotationGroupID int = null,
		@CriteriaGroupID int = null		
)
AS
/******************************************************************************
**	File: SelectRotationCriteria.sql
**	Name: SelectRotationCriteria
**	Desc: Selects multiple rows of RotationCriteria Based on Id  fields 
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
		RotationCriteria.RotationID,
		RotationCriteria.RotationGroupID,
		RotationCriteria.CriteriaID,
		RotationCriteria.CriteriaType,
		RotationCriteria.CriteriaGroupName,
		RotationCriteria.CriteriaGroupID,
		RotationCriteria.ID
	FROM 
		dbo.RotationCriteria 
	WHERE 
		RotationCriteria.RotationID = ISNULL(@RotationID, RotationCriteria.RotationID)
	AND
		RotationCriteria.RotationGroupID = ISNULL(@RotationGroupID, RotationCriteria.RotationGroupID)
	AND
		RotationCriteria.CriteriaGroupID = ISNULL(@CriteriaGroupID, RotationCriteria.CriteriaGroupID)

GO

GRANT EXEC ON SelectRotationCriteria TO PUBLIC
GO
