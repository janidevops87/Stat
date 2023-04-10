

IF EXISTS (Select * FROM sysobjects WHERE type = 'P' AND name = 'callInsert')
	BEGIN
		PRINT 'Dropping Procedure callInsert'
		DROP Procedure callInsert
	END
GO

PRINT 'Creating Procedure callInsert'
GO
CREATE Procedure callInsert
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
**	File: callInsert.sql
**	Name: callInsert
**	Desc: Inserts call Based on Id field 
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

INSERT	call
	(
		CallNumber,
		CallTypeID,
		CallDateTime,
		StatEmployeeID,
		CallTotalTime,
		CallTempExclusive,
		Inactive,
		CallSeconds,
		LastModified,
		CallTemp,
		SourceCodeID,
		CallOpenByID,
		CallTempSavedByID,
		CallExtension,
		UpdatedFlag,
		CallOpenByWebPersonId,
		RecycleNCFlag,
		CallActive,
		CallSaveLastByID,
		AuditLogTypeID
	)
VALUES
	(
		@CallNumber,
		@CallTypeID,
		@CallDateTime,
		@StatEmployeeID,
		@CallTotalTime,
		@CallTempExclusive,
		@Inactive,
		@CallSeconds,
		@LastModified,
		@CallTemp,
		@SourceCodeID,
		@CallOpenByID,
		@CallTempSavedByID,
		@CallExtension,
		@UpdatedFlag,
		@CallOpenByWebPersonId,
		@RecycleNCFlag,
		@CallActive,
		@CallSaveLastByID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @callID = SCOPE_IDENTITY()

UPDATE Call 
	SET CallNumber = CONVERT(VARCHAR(15), @callID) + '-' + CONVERT(VARCHAR(15), @CallSaveLastByID)
WHERE
	CallID = @callID

GO

GRANT EXEC ON callInsert TO PUBLIC
GO
