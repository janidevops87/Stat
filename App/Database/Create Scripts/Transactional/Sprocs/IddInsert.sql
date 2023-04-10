

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IddInsert')
	BEGIN
		PRINT 'Dropping Procedure IddInsert'
		DROP Procedure IddInsert
	END
GO

PRINT 'Creating Procedure IddInsert'
GO
CREATE Procedure IddInsert
(
		@IddId int = null,
		@Idd nvarchar(10) = null,		
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@CountryId int = null
)
AS
/******************************************************************************
**	File: IddInsert.sql
**	Name: IddInsert
**	Desc: Inserts Idd Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Idd
	(
		Idd,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId,
		CountryId
	)
VALUES
	(
		@Idd,
		GetDate(),
		@LastStatEmployeeId,
		1, --insert
		@CountryId
	)

SET @IddID = SCOPE_IDENTITY()

EXEC IddSelect @IddID

GO

GRANT EXEC ON IddInsert TO PUBLIC
GO
