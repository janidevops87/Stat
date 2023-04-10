

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PersonTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure PersonTypeInsert'
		DROP Procedure PersonTypeInsert
	END
GO

PRINT 'Creating Procedure PersonTypeInsert'
GO
CREATE Procedure PersonTypeInsert
(
		@PersonTypeID int = null output,
		@PersonTypeName varchar(50) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@PersonTypeProcurmentAgency smallint = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: PersonTypeInsert.sql
**	Name: PersonTypeInsert
**	Desc: Inserts PersonType Based on Id field 
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

INSERT	PersonType
	(
		PersonTypeName,
		Verified,
		Inactive,
		LastModified,
		PersonTypeProcurmentAgency,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@PersonTypeName,
		@Verified,
		@Inactive,
		@LastModified,
		@PersonTypeProcurmentAgency,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @PersonTypeID = SCOPE_IDENTITY()

EXEC PersonTypeSelect @PersonTypeID

GO

GRANT EXEC ON PersonTypeInsert TO PUBLIC
GO
