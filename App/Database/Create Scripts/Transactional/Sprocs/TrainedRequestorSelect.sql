

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TrainedRequestorSelect')
	BEGIN
		PRINT 'Dropping Procedure TrainedRequestorSelect'
		DROP Procedure TrainedRequestorSelect
	END
GO

PRINT 'Creating Procedure TrainedRequestorSelect'
GO
CREATE Procedure TrainedRequestorSelect
(
		@TrainedRequestorID int = null output					
)
AS
/******************************************************************************
**	File: TrainedRequestorSelect.sql
**	Name: TrainedRequestorSelect
**	Desc: Selects multiple rows of TrainedRequestor Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		TrainedRequestor.TrainedRequestorID,
		TrainedRequestor.TrainedRequestor,
		TrainedRequestor.LastModified,
		TrainedRequestor.LastStatEmployeeID,
		TrainedRequestor.AuditLogTypeID
	FROM 
		dbo.TrainedRequestor 

	WHERE 
		TrainedRequestor.TrainedRequestorID = ISNULL(@TrainedRequestorID, TrainedRequestor.TrainedRequestorID)				
	ORDER BY 1
GO

GRANT EXEC ON TrainedRequestorSelect TO PUBLIC
GO
