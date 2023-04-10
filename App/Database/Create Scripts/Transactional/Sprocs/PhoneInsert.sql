

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PhoneInsert')
	BEGIN
		PRINT 'Dropping Procedure PhoneInsert'
		DROP Procedure PhoneInsert
	END
GO

PRINT 'Creating Procedure PhoneInsert'
GO
CREATE Procedure PhoneInsert
(
		@PhoneID int = null output,
		@PhoneAreaCode varchar(3) = null,
		@PhonePrefix varchar(3) = null,
		@PhoneNumber varchar(4) = null,
		@PhonePin varchar(10) = null,
		@PhoneTypeID int = null,
		@PhoneType varchar(50) = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@Unused varchar(100) = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: PhoneInsert.sql
**	Name: PhoneInsert
**	Desc: Inserts Phone Based on Id field 
**	Auth: Bret Knoll
**	Date: 8/7/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	8/7/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Phone
	(
		PhoneAreaCode,
		PhonePrefix,
		PhoneNumber,
		PhonePin,
		PhoneTypeID,
		Verified,
		Inactive,
		LastModified,
		Unused,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@PhoneAreaCode,
		@PhonePrefix,
		@PhoneNumber,
		@PhonePin,
		@PhoneTypeID,
		@Verified,
		@Inactive,
		@LastModified,
		@Unused,
		@UpdatedFlag,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)

SET @PhoneID = SCOPE_IDENTITY()

EXEC PhoneSelect @PhoneID

GO

GRANT EXEC ON PhoneInsert TO PUBLIC
GO
