

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'EmailTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure EmailTypeUpdate'
		DROP Procedure EmailTypeUpdate
	END
GO

PRINT 'Creating Procedure EmailTypeUpdate'
GO
CREATE Procedure EmailTypeUpdate
(
		@EmailTypeID int = null output,
		@EmailType varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: EmailTypeUpdate.sql
**	Name: EmailTypeUpdate
**	Desc: Updates EmailType Based on Id field 
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
	dbo.EmailType 	
SET 
		EmailType = @EmailType,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	EmailTypeID = @EmailTypeID 				

GO

GRANT EXEC ON EmailTypeUpdate TO PUBLIC
GO
