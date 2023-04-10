

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TrainedRequestorUpdate')
	BEGIN
		PRINT 'Dropping Procedure TrainedRequestorUpdate'
		DROP Procedure TrainedRequestorUpdate
	END
GO

PRINT 'Creating Procedure TrainedRequestorUpdate'
GO
CREATE Procedure TrainedRequestorUpdate
(
		@TrainedRequestorID int = null output,
		@TrainedRequestor varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: TrainedRequestorUpdate.sql
**	Name: TrainedRequestorUpdate
**	Desc: Updates TrainedRequestor Based on Id field 
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

UPDATE
	dbo.TrainedRequestor 	
SET 
		TrainedRequestor = @TrainedRequestor,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	TrainedRequestorID = @TrainedRequestorID 				

GO

GRANT EXEC ON TrainedRequestorUpdate TO PUBLIC
GO
