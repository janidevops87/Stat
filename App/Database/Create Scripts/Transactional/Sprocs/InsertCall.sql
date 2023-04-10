IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertCall')
	BEGIN
		PRINT 'Dropping Procedure InsertCall'
		DROP  Procedure  InsertCall
	END

GO

PRINT 'Creating Procedure InsertCall'
GO
CREATE Procedure InsertCall
  @CallID int = NULL , 
  @CallNumber varchar(15) = NULL , 
  @CallTypeID int = NULL , 
  @CallDateTime smalldatetime = NULL , 
  @StatEmployeeID smallint = NULL , 
  @CallTotalTime varchar(15) = NULL , 
  @CallTempExclusive smallint = NULL , 
  @Inactive smallint = NULL , 
  @CallSeconds smallint = NULL , 
  @CallTemp smallint = NULL , 
  @SourceCodeID int = NULL , 
  @CallOpenByID int = NULL , 
  @CallTempSavedByID int = NULL , 
  @CallExtension numeric = NULL ,   
  @CallOpenByWebPersonId int = NULL , 
  @RecycleNCFlag smallint = NULL , 
  @CallActive smallint = NULL , 
  @callSaveLastByID int,
  @AuditLogTypeID int = null
AS

/******************************************************************************
**		File: 
**		Name: InsertCall
**		Desc: Inserts a new call record into the call table
**
**              
**		Return values: returns the update call table row
** 
**		Called by:   Statline.StatTrac.Data.Tables.CallDB.UpdateCall
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 	[int],
**		@StatEmployeeID int,
**		@SourceCodeID int,
**		@CallExtension int
**		@CallTypeID int,
**		@CallDateTime datetime,
**		@CallTotalTime varchar(50),
**		@CallSeconds   varchar(50),
**		@CallTemp int,
**		@CallOpenByID int,
**		@CallTempExclusive int,
**		@CallTempSavedByID int,
**		@RecycleNCFlag int,
**		@CallActive int,
**		@callSaveLastByID int,
**
**		Auth: Thien Ta
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/13/07			Thien Ta				initial    
**		05/30/07		Bret Knoll				8.4.3.8 Audit Call table
**												add AuditLogTypeID
*******************************************************************************/


INSERT 
	Call 
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
		CallOpenByWebPersonId,
		RecycleNCFlag,
		CallActive,
		CallSaveLastByID,
		AuditLogTypeID	
	) 
VALUES 
	(
		NULL, 
		@CallTypeID, 
		@CallDateTime, 
		@StatEmployeeID, 
		@CallTotalTime, 
		@CallTempExclusive, 
		@Inactive, 
		@CallSeconds, 
		GetDate(), --- LastModified
		@CallTemp, 
		@SourceCodeID, 
		@CallOpenByID, 
		@CallTempSavedByID, 
		@CallExtension, 
		@CallOpenByWebPersonId, 
		@RecycleNCFlag, 
		@CallActive, 
		@callSaveLastByID, 
		1 -- @auditLogTypeID 1 = Create
	)

-- set CallID for Update and select
SELECT @CallID = SCOPE_IDENTITY()

--- update CallNumber
	UPDATE
		Call
	SET
		CallNumber = CONVERT(VARCHAR(20), CallID) + '-' +CONVERT(VARCHAR(20), StatEmployeeID),
		CallSaveLastByID = @callSaveLastByID,
		AuditLogTypeID = 3, -- 3 = Modify	
		LastModified = GetDate()
	WHERE
		CallID = @CallID 	

SELECT
	CallID, 
	CallNumber, 
	CallTypeID, 
	CallDateTime,
	StatEmployeeID, 
	CallTotalTime, 
	CallSeconds, 
	CallTemp,
	SourceCodeID, 
	CallOpenByID, 
	CallTempExclusive, 
	CallTempSavedByID, 
	RecycleNCFlag, 
	CallActive, 
	CallSaveLastByID, 
	CallExtension
FROM
	Call
WHERE
	CallID = @CallID



GO

GRANT EXEC ON InsertCall TO PUBLIC

GO
