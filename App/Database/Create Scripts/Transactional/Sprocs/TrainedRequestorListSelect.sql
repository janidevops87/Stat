

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TrainedRequestorListSelect')
	BEGIN
		PRINT 'Dropping Procedure TrainedRequestorListSelect'
		DROP Procedure TrainedRequestorListSelect
	END
GO

PRINT 'Creating Procedure TrainedRequestorListSelect'
GO
CREATE Procedure TrainedRequestorListSelect
(
		@TrainedRequestorID int = null output					
)
AS
/******************************************************************************
**	File: TrainedRequestorListSelect.sql
**	Name: TrainedRequestorListSelect
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
		TrainedRequestor.TrainedRequestorID AS ListId,
		TrainedRequestor.TrainedRequestor AS FieldValue
	FROM 
		dbo.TrainedRequestor 
	WHERE 
		TrainedRequestor.TrainedRequestorID = ISNULL(@TrainedRequestorID, TrainedRequestor.TrainedRequestorID)				
	ORDER BY 2
GO

GRANT EXEC ON TrainedRequestorListSelect TO PUBLIC
GO
