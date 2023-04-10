

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PersonPhoneUpdate')
	BEGIN
		PRINT 'Dropping Procedure PersonPhoneUpdate'
		DROP Procedure PersonPhoneUpdate
	END
GO

PRINT 'Creating Procedure PersonPhoneUpdate'
GO
CREATE Procedure PersonPhoneUpdate
(
		@PersonPhoneID int = null output,
		@PersonID int = null,
		@PhoneID int = null,
		@Phone varchar(100) = null,
		@PhoneTypeID int = null,
		@PhoneType varchar(100) = null,		
		@Unused int = null,
		@PersonPhonePin varchar(10) = null,
		@PhonePin varchar(10) = null,
		@LastModified datetime = null,
		@PhoneAlphaPagerEmail varchar(100) = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@PagerTypeID int = null,
		@PagerType varchar(100) = null,
		@EmailTypeID int = null,
		@EmailType varchar(100) = null,
		@AutoResponse bit = null					
)
AS
/******************************************************************************
**	File: PersonPhoneUpdate.sql
**	Name: PersonPhoneUpdate
**	Desc: Updates PersonPhone Based on Id field 
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
  ,@PhonePin = @PhonePin
  ,@ReturnNewRecord = 0


UPDATE
	dbo.PersonPhone 	
SET 
		PersonID = @PersonID,
		PhoneID = @PhoneID,
		Unused = @Unused,
		PersonPhonePin = @PersonPhonePin,
		--PhonePin =  @PersonPin,
		LastModified = GetDate(),
		PhoneAlphaPagerEmail = @PhoneAlphaPagerEmail,
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */,
		PagerTypeID = @PagerTypeID,
		EmailTypeID = @EmailTypeID,
		AutoResponse = @AutoResponse
WHERE 
	PersonPhoneID = @PersonPhoneID 				

GO

GRANT EXEC ON PersonPhoneUpdate TO PUBLIC
GO
