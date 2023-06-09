SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_CallRecycleSuspend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: spi_CallRecycleSuspend'
	drop procedure [dbo].[spi_CallRecycleSuspend]
END

PRINT 'Creating Precedure: spi_CallRecycleSuspend'
GO

CREATE PROCEDURE spi_CallRecycleSuspend (
@callId int,
@callSaveLastByID int = Null
)

/*
   Places calls in the CallRecycle table, removing them from the Call table without removing any of
   the associated records in Referral, etc.  This allows all Calls to be saved in a recycle bin
   from which they can be restored.
   Created for StatTrac v. 7.7.4 5/25/05 - Scott Plummer
   
   ccarroll 06/24/2008 - StatTrac 8.4.6
   Added parameter CallSaveLastByID for AuditTrail. When a callID is sent to recycle, write a delete
   event to the AuditTrail. Added Update to to show delete.
*/

AS

SET NOCOUNT ON

-- Update AuditTrail to Show Delete
UPDATE Call SET
		CallSaveLastByID = @callSaveLastByID,
		LastModified = GetDate(),
		AuditLogTypeID = 4 --Deleted
WHERE CallID = @callid;


-- Copy the Call data into CallRecycle
INSERT INTO CallRecycle(CallID, CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, 
		CallTempExclusive, Inactive, CallSeconds, LastModified, CallTemp, SourceCodeID, CallOpenByID, 
		CallTempSavedByID, CallExtension, UpdatedFlag, CallOpenByWebPersonId, RecycleDateTime, RecycleNCFlag,CallActive)
	SELECT CallID, CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, 
		CallTempExclusive, Inactive, CallSeconds, LastModified, CallTemp, SourceCodeID, -1, -- Force call closed by setting CallOpenByID to -1
		CallTempSavedByID, CallExtension, UpdatedFlag, CallOpenByWebPersonId, GetDate(), RecycleNCFlag, CallActive
	FROM Call 
	WHERE CallId = @callId


-- MUST DISABLE TRIGGER BEFORE DELETION FROM CALL
-- OR RELATED RECORDS IN REFERRAL AND MANY OTHER TABLES WILL GO AWAY!
-- ALTER TABLE Call DISABLE TRIGGER tg_CallDelete;
-- BJK Replaced ALTER TABLE and add tranaction
INSERT DisableCallTrigger VALUES (@@SPID) 
-- Delete Call record
DELETE FROM CAll WHERE CallId = @callId;
-- Now re-enable the trigger
-- ALTER TABLE Call ENABLE TRIGGER tg_CallDelete;
-- BJK Replaced ALTER TABLE 
DELETE DisableCallTrigger WHERE UserSPID = @@SPID 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

