 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneNewCallInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationPhoneNewCallInsert'
		DROP Procedure OrganizationPhoneNewCallInsert
	END
GO

PRINT 'Creating Procedure OrganizationPhoneNewCallInsert'
GO
CREATE Procedure OrganizationPhoneNewCallInsert
(

		@OrganizationID int = null,
		@Phone varchar(20) = null,
		@LastStatEmployeeId int = null,		
		@SubLocationID int = null,
		@SubLocationLevelID int = null,
		@SubLocationLevel varchar(5) = null
		
)
AS
/******************************************************************************
**	File: OrganizationPhoneNewCallInsert.sql
**	Name: OrganizationPhoneNewCallInsert
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

DECLARE 
	@PhoneTypeID int = 3,
	@LastModified datetime = GetDate(),
	@AuditLogTypeId int = 1,
	@Inactive smallint = 0,	
	@PhoneAreaCode varchar(3) = null,   
	@PhonePrefix varchar(3) = null,   
	@PhoneNumber varchar(4) = null 

	
	IF (@SubLocationID < 1) 
	BEGIN
		SET @SubLocationID = NULL
	END
	
	-- Parse phone
	IF(@PhoneAreaCode IS NULL AND @PhonePrefix IS NULL AND @PhoneNumber IS NULL)  
	BEGIN  
	 SELECT   
	 @PhoneAreaCode = PhoneAreaCode,   
	 @PhonePrefix = PhonePrefix,   
	 @PhoneNumber = PhoneNumber   
	 FROM  
	  fn_PhoneParse(@Phone)  
	END

	-- CHECK IF PHONE EXISTS IN OrganizationPhone.
	IF NOT EXISTS (
			SELECT 
				OrganizationPhone.OrganizationPhoneID 
			FROM OrganizationPhone 
			JOIN Phone ON OrganizationPhone.PhoneID = Phone.PhoneID
			WHERE 
				OrganizationPhone.OrganizationID = @OrganizationID 
			AND 
				Phone.PhoneAreaCode = @PhoneAreaCode
			AND 
				Phone.PhonePrefix = @PhonePrefix
			AND 
				Phone.PhoneNumber = @PhoneNumber
			)
	BEGIN
			EXEC [OrganizationPhoneInsert] 			   
			   @OrganizationID = @OrganizationID
			  ,@Phone = @Phone
			  ,@PhoneTypeID = @PhoneTypeID
			  ,@LastModified = @LastModified
			  ,@LastStatEmployeeId = @LastStatEmployeeId
			  ,@AuditLogTypeId = @AuditLogTypeId
			  ,@SubLocationID = @SubLocationID
			  ,@SubLocationLevelID = @SubLocationLevelID
			  ,@SubLocationLevel = @SubLocationLevel
			  ,@Inactive = @Inactive
		
	END

GO
GRANT EXEC ON OrganizationPhoneNewCallInsert TO PUBLIC
GO
