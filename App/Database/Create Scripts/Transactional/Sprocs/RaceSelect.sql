

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'RaceSelect')
	BEGIN
		PRINT 'Dropping Procedure RaceSelect'
		DROP Procedure RaceSelect
	END
GO

PRINT 'Creating Procedure RaceSelect'
GO
CREATE Procedure RaceSelect
(
		@RaceID int = null output					
)
AS
/******************************************************************************
**	File: RaceSelect.sql
**	Name: RaceSelect
**	Desc: Selects multiple rows of Race Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Race.RaceID,
		Race.RaceName,
		Race.Verified,
		Race.Inactive,
		Race.LastModified,
		Race.UpdatedFlag,
		Race.LastStatEmployeeID,
		Race.AuditLogTypeID
	FROM 
		dbo.Race 

	WHERE 
		Race.RaceID = ISNULL(@RaceID, Race.RaceID)				
	ORDER BY 1
GO

GRANT EXEC ON RaceSelect TO PUBLIC
GO
