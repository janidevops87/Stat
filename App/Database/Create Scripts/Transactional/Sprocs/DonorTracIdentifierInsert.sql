IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracIdentifierInsert')
	BEGIN
		PRINT 'Dropping Procedure DonorTracIdentifierInsert'
		DROP Procedure DonorTracIdentifierInsert
	END
GO

PRINT 'Creating Procedure DonorTracIdentifierInsert'
GO
CREATE Procedure DonorTracIdentifierInsert
(
		@DonorTracIdentifierID int = null output,
		@SourceCodeID int = null,
		@DonorTracIdentifier varchar(200) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: DonorTracIdentifierInsert.sql
**	Name: DonorTracIdentifierInsert
**	Desc: Inserts DonorTracIdentifier Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	DonorTracIdentifier
	(
		SourceCodeID,
		DonorTracIdentifier,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@SourceCodeID,
		@DonorTracIdentifier,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @DonorTracIdentifierID = SCOPE_IDENTITY()

EXEC DonorTracIdentifierSelect @DonorTracIdentifierID

GO

GRANT EXEC ON DonorTracIdentifierInsert TO PUBLIC
GO
