

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'GenderInsert')
	BEGIN
		PRINT 'Dropping Procedure GenderInsert'
		DROP Procedure GenderInsert
	END
GO

PRINT 'Creating Procedure GenderInsert'
GO
CREATE Procedure GenderInsert
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
**	File: GenderInsert.sql
**	Name: GenderInsert
**	Desc: Inserts Gender Based on Id field 
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

INSERT	Gender
	(
		Gender,
		GenderAbbreviation,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@Gender,
		@GenderAbbreviation,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @GenderID = SCOPE_IDENTITY()

EXEC GenderSelect @GenderID

GO

GRANT EXEC ON GenderInsert TO PUBLIC
GO
