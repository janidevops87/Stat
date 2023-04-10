 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PhoneMerge')
	BEGIN
		PRINT 'Dropping Procedure PhoneMerge'
		DROP Procedure PhoneMerge
	END
GO

PRINT 'Creating Procedure PhoneMerge'
GO
CREATE Procedure PhoneMerge
(
		@PhoneID int = null output,
		@Phone varchar(20) = null,
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
		@AuditLogTypeID int = null,
		@ReturnNewRecord bit = 1					
)
AS
/******************************************************************************
**	File: PhoneMerge.sql
**	Name: PhoneMerge
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
DECLARE @insertedPhone TABLE
	(PhoneID int)
IF(@PhoneAreaCode IS NULL AND @PhonePrefix IS NULL AND @PhoneNumber IS NULL)
BEGIN
	SELECT 
	@PhoneAreaCode = PhoneAreaCode, 
	@PhonePrefix = PhonePrefix, 
	@PhoneNumber = PhoneNumber 
	FROM
		fn_PhoneParse(@Phone)
	
END
	
MERGE 
	Phone AS source 
USING (SELECT @PhoneID) AS target (PhoneID)
ON (target.PhoneID = source.PhoneID)
WHEN MATCHED THEN
UPDATE
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
WHEN NOT MATCHED THEN
	INSERT 
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
		GETDATE(),
		@Unused,
		@UpdatedFlag,
		@LastStatEmployeeID,
		1
	)
OUTPUT inserted.PhoneID INTO @insertedPhone;

SELECT  @PhoneID = ISNULL(PhoneID, @PhoneID) FROM @insertedPhone
IF(@ReturnNewRecord = 1)
	EXEC PhoneSelect @PhoneID

GO

GRANT EXEC ON PhoneMerge TO PUBLIC
GO
