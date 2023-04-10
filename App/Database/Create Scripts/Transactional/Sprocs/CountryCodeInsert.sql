

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CountryCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure CountryCodeInsert'
		DROP Procedure CountryCodeInsert
	END
GO

PRINT 'Creating Procedure CountryCodeInsert'
GO
CREATE Procedure CountryCodeInsert
(
		@CountryCodeId int = null,
		@CountryCode nvarchar(10) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@CountryId int = null
)
AS
/******************************************************************************
**	File: CountryCodeInsert.sql
**	Name: CountryCodeInsert
**	Desc: Inserts CountryCode Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	CountryCode
	(
		CountryCode,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId,
		CountryId
	)
VALUES
	(
		@CountryCode,
		GetDate(),
		@LastStatEmployeeId,
		1, --insert
		@CountryId
	)

SET @CountryCodeID = SCOPE_IDENTITY()

EXEC CountryCodeSelect @CountryCodeID

GO

GRANT EXEC ON CountryCodeInsert TO PUBLIC
GO
