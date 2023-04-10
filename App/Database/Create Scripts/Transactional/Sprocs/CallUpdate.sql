

IF EXISTS (Select * FROM sysobjects WHERE type = 'P' AND name = 'callUpdate')
	BEGIN
		PRINT 'Dropping Procedure callUpdate'
		DROP Procedure callUpdate
	END
GO

PRINT 'Creating Procedure callUpdate'
GO
CREATE Procedure callUpdate
(
		@CallID int = null output,
		@CallNumber varchar(15) = null,
		@CallTypeID int = null,		
		@CallDateTime smalldatetime = null,
		@StatEmployeeID smallint = null,
		@CallTotalTime varchar(15) = null,
		@CallTempExclusive smallint = null,
		@Inactive smallint = null,
		@CallSeconds smallint = null,
		@LastModified datetime = null,
		@CallTemp smallint = null,
		@SourceCodeID int = null,
		@CallOpenByID int = null,
		@CallTempSavedByID int = null,
		@CallExtension numeric(5,0) = null,
		@UpdatedFlag smallint = null,
		@CallOpenByWebPersonId int = null,
		@RecycleNCFlag smallint = null,
		@CallActive smallint = null,
		@CallSaveLastByID int = null,
		@AuditLogTypeID int = null										
)
AS
/******************************************************************************
**	File: callUpdate.sql
**	Name: callUpdate
**	Desc: Updates call Based on Id field 
**	Auth: Bret Knoll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

-- Confirm that @SourceCodeID is either null or valid
IF @SourceCodeID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM SourceCode WHERE SourceCodeID = @SourceCodeID)
BEGIN
	SET @SourceCodeID = NULL;
END

UPDATE
	dbo.call 	
SET 
		CallNumber = @CallNumber,
		CallTypeID = @CallTypeID,
		CallDateTime = @CallDateTime,
		StatEmployeeID = @StatEmployeeID,
		CallTotalTime = @CallTotalTime,
		CallTempExclusive = @CallTempExclusive,
		Inactive = @Inactive,
		CallSeconds = @CallSeconds,
		LastModified = GetDate(),
		CallTemp = @CallTemp,
		SourceCodeID = ISNULL(@SourceCodeID, SourceCodeID),
		CallOpenByID = @CallOpenByID,
		CallTempSavedByID = @CallTempSavedByID,
		CallExtension = @CallExtension,
		UpdatedFlag = @UpdatedFlag,
		CallOpenByWebPersonId = @CallOpenByWebPersonId,
		RecycleNCFlag = @RecycleNCFlag,
		CallActive = @CallActive,
		CallSaveLastByID = @CallSaveLastByID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CallID = @CallID 				

GO

GRANT EXEC ON callUpdate TO PUBLIC
GO
