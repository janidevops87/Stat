IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapUpdate')
	BEGIN
		PRINT 'Dropping Procedure AspSourceCodeMapUpdate'
		DROP Procedure AspSourceCodeMapUpdate
	END
GO

PRINT 'Creating Procedure AspSourceCodeMapUpdate'
GO
CREATE Procedure AspSourceCodeMapUpdate
(
		@AspSourceCodeMapID int = null output,
		@SourceCodeID int = null,
		@AspSourceCodeID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@AspSourceCodeName varchar(10) = null					
						
)
AS
/******************************************************************************
**	File: AspSourceCodeMapUpdate.sql
**	Name: AspSourceCodeMapUpdate
**	Desc: Updates AspSourceCodeMap Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.AspSourceCodeMap 	
SET 
		SourceCodeID = @SourceCodeID,
		AspSourceCodeID = @AspSourceCodeID,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), /* 3 modified */
		AspSourceCodeName = @AspSourceCodeName				

WHERE 
	AspSourceCodeMapID = @AspSourceCodeMapID 				

GO

GRANT EXEC ON AspSourceCodeMapUpdate TO PUBLIC
GO
