

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationPhoneInsert'
		DROP Procedure OrganizationPhoneInsert
	END
GO

PRINT 'Creating Procedure OrganizationPhoneInsert'
GO
CREATE Procedure OrganizationPhoneInsert
(
		@OrganizationPhoneID int = null,
		@OrganizationID int = null,
		@PhoneID int = null,
		@Phone varchar(20) = null,
		@PhoneTypeID int = null,
		@PhoneType varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@SubLocationID int = null,
		@SubLocation varchar(50) = null,
		@SubLocationLevelID int = null,
		@SubLocationLevel varchar(5) = null,
		@Inactive smallint = null						
)
AS
/******************************************************************************
**	File: OrganizationPhoneInsert.sql
**	Name: OrganizationPhoneInsert
**	Desc: Inserts OrganizationPhone Based on Id field 
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
SET NOCOUNT ON
-- add upsert code here using Merge
DECLARE @PhoneTable TABLE
	(
	[PhoneID] [int] NOT NULL
	)

INSERT @PhoneTable (PhoneID)
EXEC [PhoneMerge] 
   @PhoneID = @PhoneID OUTPUT
  ,@Phone = @Phone
  ,@PhoneTypeID = @PhoneTypeID
  ,@LastModified = @LastModified
  ,@LastStatEmployeeID = @LastStatEmployeeID
  ,@AuditLogTypeID = @AuditLogTypeID
  ,@ReturnNewRecord = 0


  --making sure it works backwards compatible, text field is now used, but in case there are stil places sending the id...
  IF (@SubLocationLevel IS NULL AND @SubLocationLevelID IS NOT NULL)
  BEGIN
	SELECT @SubLocationLevel = SubLocationLevelName
	FROM dbo.SubLocationLevel
	WHERE SubLocationLevelID = @SubLocationLevelID;
	
  END

INSERT	OrganizationPhone
	(
		OrganizationID,
		PhoneID,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId,
		SubLocationID,
		SubLocationLevelID,
		SubLocationLevel,
		Inactive
	)
VALUES
	(
		@OrganizationID,
		@PhoneID,
		GetDate(),
		@LastStatEmployeeId,
		1, --insert
		@SubLocationID,
		@SubLocationLevelID,
		@SubLocationLevel,
		@Inactive
	)

SET @OrganizationPhoneID = SCOPE_IDENTITY()

EXEC OrganizationPhoneSelect @OrganizationPhoneID

GO

GRANT EXEC ON OrganizationPhoneInsert TO PUBLIC
GO
