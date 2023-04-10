

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationPhoneUpdate'
		DROP Procedure OrganizationPhoneUpdate
	END
GO

PRINT 'Creating Procedure OrganizationPhoneUpdate'
GO
CREATE Procedure OrganizationPhoneUpdate
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
**	File: OrganizationPhoneUpdate.sql
**	Name: OrganizationPhoneUpdate
**	Desc: Updates OrganizationPhone Based on Id field 
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
-- add upsert code here using Merge
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

UPDATE
	dbo.OrganizationPhone 	
SET 
		OrganizationID = @OrganizationID,
		PhoneID = @PhoneID,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3), --- Modify,
		SubLocationID = @SubLocationID,
		SubLocationLevelID = @SubLocationLevelID,
		SubLocationLevel = @SubLocationLevel,
		Inactive = @Inactive
WHERE 
	OrganizationPhoneID = @OrganizationPhoneID 				

GO

GRANT EXEC ON OrganizationPhoneUpdate TO PUBLIC
GO
