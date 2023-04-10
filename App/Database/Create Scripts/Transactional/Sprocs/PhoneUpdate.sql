

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PhoneUpdate')
	BEGIN
		PRINT 'Dropping Procedure PhoneUpdate'
		DROP Procedure PhoneUpdate
	END
GO

PRINT 'Creating Procedure PhoneUpdate'
GO
CREATE Procedure PhoneUpdate
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
**	File: PhoneUpdate.sql
**	Name: PhoneUpdate
**	Desc: Updates Phone Based on Id field 
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

UPDATE
	dbo.Phone 	
SET 
		PhoneAreaCode = @PhoneAreaCode,
		PhonePrefix = @PhonePrefix,
		PhoneNumber = @PhoneNumber,
		PhonePin = @PhonePin,
		PhoneTypeID = @PhoneTypeID,
		Verified = @Verified,
		Inactive = @Inactive,
		LastModified = GetDate(),
		Unused = @Unused,
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = 3 /* modified */
WHERE 
	PhoneID = @PhoneID 				

GO

GRANT EXEC ON PhoneUpdate TO PUBLIC
GO
