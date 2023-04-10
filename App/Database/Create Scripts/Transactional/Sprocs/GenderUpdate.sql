

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'GenderUpdate')
	BEGIN
		PRINT 'Dropping Procedure GenderUpdate'
		DROP Procedure GenderUpdate
	END
GO

PRINT 'Creating Procedure GenderUpdate'
GO
CREATE Procedure GenderUpdate
(
		@GenderID int = null output,
		@Gender varchar(20) = null,
		@GenderAbbreviation varchar(1) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: GenderUpdate.sql
**	Name: GenderUpdate
**	Desc: Updates Gender Based on Id field 
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
	dbo.Gender 	
SET 
		Gender = @Gender,
		GenderAbbreviation = @GenderAbbreviation,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	GenderID = @GenderID 				

GO

GRANT EXEC ON GenderUpdate TO PUBLIC
GO
