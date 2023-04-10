

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PagerTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure PagerTypeUpdate'
		DROP Procedure PagerTypeUpdate
	END
GO

PRINT 'Creating Procedure PagerTypeUpdate'
GO
CREATE Procedure PagerTypeUpdate
(
		@PagerTypeID int = null output,
		@PagerType varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: PagerTypeUpdate.sql
**	Name: PagerTypeUpdate
**	Desc: Updates PagerType Based on Id field 
**	Auth: Bret Knoll
**	Date: 10/6/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/6/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.PagerType 	
SET 
		PagerType = @PagerType,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	PagerTypeID = @PagerTypeID 				

GO

GRANT EXEC ON PagerTypeUpdate TO PUBLIC
GO
