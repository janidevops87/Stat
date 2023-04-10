

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TrainedRequestorInsert')
	BEGIN
		PRINT 'Dropping Procedure TrainedRequestorInsert'
		DROP Procedure TrainedRequestorInsert
	END
GO

PRINT 'Creating Procedure TrainedRequestorInsert'
GO
CREATE Procedure TrainedRequestorInsert
(
		@TrainedRequestorID int = null output,
		@TrainedRequestor varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: TrainedRequestorInsert.sql
**	Name: TrainedRequestorInsert
**	Desc: Inserts TrainedRequestor Based on Id field 
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

INSERT	TrainedRequestor
	(
		TrainedRequestor,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@TrainedRequestor,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @TrainedRequestorID = SCOPE_IDENTITY()

EXEC TrainedRequestorSelect @TrainedRequestorID

GO

GRANT EXEC ON TrainedRequestorInsert TO PUBLIC
GO
