

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PagerTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure PagerTypeInsert'
		DROP Procedure PagerTypeInsert
	END
GO

PRINT 'Creating Procedure PagerTypeInsert'
GO
CREATE Procedure PagerTypeInsert
(
		@PagerTypeID int = null output,
		@PagerType varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: PagerTypeInsert.sql
**	Name: PagerTypeInsert
**	Desc: Inserts PagerType Based on Id field 
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

INSERT	PagerType
	(
		PagerType,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@PagerType,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @PagerTypeID = SCOPE_IDENTITY()

EXEC PagerTypeSelect @PagerTypeID

GO

GRANT EXEC ON PagerTypeInsert TO PUBLIC
GO
