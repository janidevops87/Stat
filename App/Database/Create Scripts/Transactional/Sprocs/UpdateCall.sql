 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateCall')
	BEGIN
		PRINT 'Dropping Procedure UpdateCall'
		DROP  Procedure  UpdateCall
	END

GO

PRINT 'Creating Procedure UpdateCall'
GO
CREATE Procedure UpdateCall
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
	@CallSaveLastByID int,
	@AuditLogTypeID int = null,
	@CheckCallOpenByID INT = NULL -- SEE NOTE BELOW
AS
/******************************************************************************
**		File: 
**		Name: UpdateCall
**		Desc: Update a  call record into the call table
**
**              
**		Return values: returns the update call table row
** 
**		Called by:   
**			Statline.StatTrac.Data.Tables.CallDB.UpdateCall
**			StatTrac.ModStatSave.SaveCall
**			StatTrac.ModStatSave.SaveCallOpenBy
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
**		@CallSaveLastByID int,
**		@CheckCallOpenByID is used to only update the record with the users number 
**							if the value is -1
**
**		Auth: Thien Ta
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/13/07			Thien Ta				initial    
**		04/05/07		Bret Knoll				8.4.3.8 Audit Call table 
**												add AuditLogTypeID
**												added LastModied Update
**		1/30/2017		Mike Berenson			Removed transactional/rollback logic
*******************************************************************************/

-- Confirm that @SourceCodeID is either null or valid
IF @SourceCodeID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM SourceCode WHERE SourceCodeID = @SourceCodeID)
BEGIN
	SET @SourceCodeID = NULL;
END

UPDATE 
	Call 
SET
	--CallNumber = ISNULL(@CallNumber, CallNumber), 
	CallTypeID = ISNULL(@CallTypeID, CallTypeID), 
	CallDateTime = ISNULL(@CallDateTime, CallDateTime), 
	StatEmployeeID = ISNULL(@StatEmployeeID, StatEmployeeID), 
	CallTotalTime = ISNULL(@CallTotalTime, CallTotalTime), 
	CallTempExclusive = ISNULL(@CallTempExclusive, CallTempExclusive), 
	Inactive = ISNULL(@Inactive, Inactive), 
	CallSeconds = ISNULL(@CallSeconds, CallSeconds), 
	LastModified = GetDate(),
	CallTemp = ISNULL(@CallTemp, CallTemp), 
	SourceCodeID = ISNULL(@SourceCodeID, SourceCodeID), 						 
	CallOpenByID =	ISNULL(@CallOpenByID, CallOpenByID),
	CallTempSavedByID = ISNULL(@CallTempSavedByID, CallTempSavedByID), 
	-- Only save initial value of Call Extension CallExtension = ISNULL(@CallExtension, CallExtension), 
	CallOpenByWebPersonId = ISNULL(@CallOpenByWebPersonId, CallOpenByWebPersonId), 
	RecycleNCFlag = ISNULL(@RecycleNCFlag, RecycleNCFlag), 
	CallActive = ISNULL(@CallActive, CallActive), 
	CallSaveLastByID = @CallSaveLastByID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE
	callID = @callID
AND
	CallOpenByID = ISNULL(@CheckCallOpenByID, CallOpenByID)

RETURN @@ERROR

GO

GRANT EXEC ON UpdateCall TO PUBLIC

GO