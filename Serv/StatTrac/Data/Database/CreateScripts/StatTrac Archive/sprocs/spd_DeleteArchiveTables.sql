SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_DeleteArchiveTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_DeleteArchiveTables]
GO



CREATE PROCEDURE spd_DeleteArchiveTables AS

SET NOCOUNT ON

DECLARE	@COUNTER 		int,
	@RowCount 		int,  -- Values up to 2,147,483,647
	@CurrentRowCount	int,
	@TotalRowCount 		int,
	@ErrorMessage 		varchar(150),
	@Delay 			varchar(10),
	@starttime		datetime,
	@endtime		datetime
	

Set @Counter = 0 
Set @RowCount = 1000  -- Number of rows to delete per cycle
Set @TotalRowCount = 0
Set @Delay = '000:00:10'  -- Time to wait between deletes
-- Delete data from the production Table to the archive Table
-- By Deleting Call records NoCall, Message, Referral, ReferralSecondaryData, CallCustomField, LogEvent, FSCase, LOCall
-- SELECT * from ReferralSecondaryData
SELECT 'deleting tables'


-- **************************** BEGIN DELETE ReferralSecondaryData

-- No Triggers to disable

Set @RowCount = 200

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM ReferralSecondaryData
	WHERE ReferralID IN
	(SELECT ReferralID
	FROM ArchiveReferralSecondaryData
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'ReferralSecondaryData times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END

	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted ReferralSecondaryData Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE ReferralSecondaryData

-- **************************** BEGIN DELETE Message

-- No Triggers to disable

Set @RowCount = 100

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM Message
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveMessage
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'Message times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted Message Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE Message

-- **************************** BEGIN DELETE CallCustomField

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM CallCustomField
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveCallCustomField
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'CallCustomField times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted CallCustomField Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE CallCustomField

-- **************************** BEGIN DELETE LogEvent

-- No Triggers to disable

Set @RowCount = 500  -- Because there are no triggers, you can delete a lot faster from this table.  9/9/04 - SAP

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM LogEvent
	WHERE CallID IN
	( SELECT CallID FROM ArchiveLogEvent )

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'LogEvent times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted LogEvent Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE LogEvent

-- **************************** BEGIN DELETE NoCall

-- No Triggers to disable

Set @RowCount = 500

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM NoCall
	WHERE CallID IN
	( SELECT CallID
	FROM ArchiveNoCall )

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'NoCall times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted NoCall Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE NoCall


-- **************************** BEGIN DELETE FSCase

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM FSCase
	WHERE CallID IN
	(SELECT CallID 
	FROM ArchiveFSCase 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'FSCase times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted FSCase Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE FSCase

-- **************************** BEGIN DELETE LOCall

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM LOCall
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveLOCall
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'LOCall times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted LOCall Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE LOCall

-- **************************** BEGIN DELETE CallCriteria

-- No Triggers to disable

Set @RowCount = 400

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM CallCriteria
	WHERE CallID IN 
	(SELECT CallID
	FROM ArchiveCallCriteria 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'CallCriteria times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay


	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted CallCriteria Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE CallCriteria

-- **************************** BEGIN DELETE DonorData

-- No Triggers to disable

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM DonorData
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveDonorData 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'DonorData times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted DonorData Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE DonorData

-- **************************** BEGIN DELETE Secondary

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM Secondary
	WHERE CallID IN 
	(SELECT CallID
	FROM ArchiveSecondary 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'Secondary times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted Secondary Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE Secondary

-- **************************** BEGIN DELETE Secondary2

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM Secondary2
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveSecondary2 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'Secondary2 times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted Secondary2 Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE Secondary2

-- **************************** BEGIN DELETE SecondaryApproach

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM SecondaryApproach
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveSecondaryApproach
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'SecondaryApproach times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted SecondaryApproach Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE SecondaryApproach

-- **************************** BEGIN DELETE SecondaryDisposition

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM SecondaryDisposition
	WHERE CallID in 
	(SELECT CallID
	FROM ArchiveSecondaryDisposition 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'SecondaryDisposition times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted SecondaryDisposition Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE SecondaryDisposition

-- **************************** BEGIN DELETE SecondaryMedication

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM SecondaryMedication
	WHERE CallID IN 
	(SELECT CallID
	FROM ArchiveSecondaryMedication 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT
	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount

	SELECT @endtime = GETDATE()
	PRINT 'SecondaryMedication times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted SecondaryMedication Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE SecondaryMedication

-- **************************** BEGIN DELETE SecondaryMedicationOther

-- No Triggers to disable

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM SecondaryMedicationOther
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveSecondaryMedicationOther
	)

	SELECT @CurrentRowCount = @@ROWCOUNT
	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount

	SELECT @endtime = GETDATE()
	PRINT 'SecondaryMedicationOther times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted SecondaryMedicationOther Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE SecondaryMedicationOther

-- Added these tables: CODCaller, CODQuestionLog, NDRICallSheet 8/13/04 - SAP
-- **************************** BEGIN DELETE CODCaller

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM CODCaller
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveCODCaller 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'CODCaller times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted CODCaller Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG
	IF @CurrentRowCount = 0  BREAK
END
-- **************************** END DELETE CODCaller

-- **************************** BEGIN DELETE CODQuestionLog

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM CODQuestionLog
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveCODQuestionLog
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'CODQuestionLog times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted CODQuestionLog Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG
-- **************************** END DELETE CODQuestionLog

-- **************************** BEGIN DELETE NDRICallSheet

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM NDRICallSheet
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveNDRICallSheet 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'NDRICallSheet times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted NDRICallSheet Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE NDRICallSheet

-- **************************** BEGIN DELETE RegistryStatus

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM RegistryStatus
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveRegistryStatus
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'RegistryStatus times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount

	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted RegistryStatus Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE RegistryStatus

-- **************************** BEGIN DELETE NOK

-- No Triggers to disable

SELECT @TotalRowCount = 0

SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM NOK
	WHERE NOKID IN 
	(SELECT NOKID
	FROM ArchiveNOK 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'NOK times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted NOK Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG

-- **************************** END DELETE NOK

-- **************************** BEGIN DELETE SecondaryTBI

-- insert record to delete TRIGGER FUNCTIONALITY
-- No Triggers to disable

Set @RowCount = 200

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM SecondaryTBI
	WHERE CallID IN
	(
		SELECT 
			CallID
		FROM 
			ArchiveSecondaryTBI
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'SecondaryTBI times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted SecondaryTBI Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG


-- **************************** END DELETE SecondaryTBI
-- **************************** BEGIN DELETE AppropriateCounts

-- insert record to delete TRIGGER FUNCTIONALITY
-- No Triggers to disable

Set @RowCount = 200

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM AppropriateCounts
	WHERE CallID IN
	(
		SELECT 
			CallID
		FROM 
			ArchiveAppropriateCounts
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'AppropriateCounts times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted AppropriateCounts Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG


-- **************************** END DELETE SecondaryTBI



-- **************************** BEGIN DELETE Referral

-- insert record to delete TRIGGER FUNCTIONALITY
INSERT DisableCallTrigger 
VALUES (@@Spid)

Set @RowCount = 200

SELECT @TotalRowCount = 0
SET ROWCOUNT @RowCount
WHILE (0=0)
BEGIN
	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM Referral
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveReferral 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'Referral times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted Referral Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG


-- **************************** END DELETE Referral

-- **************************** BEGIN DELETE Call

SET ROWCOUNT @RowCount

SELECT @TotalRowCount = 0

WHILE (0=0)
BEGIN

-- insert record to delete TRIGGER FUNCTIONALITY
	INSERT DisableCallTrigger 
	VALUES (@@Spid)

	SELECT @Counter As 'Counter'		
	SELECT @Counter = @Counter+1

	SELECT @StartTime = GETDATE()

	DELETE
	FROM Call
	WHERE CallID IN
	(SELECT CallID
	FROM ArchiveCall 
	)

	SELECT @CurrentRowCount = @@ROWCOUNT

	SELECT @endtime = GETDATE()
	PRINT 'Call times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))

	SELECT @TotalRowCount = @TotalRowCount + @CurrentRowCount
	SELECT @CurrentRowCount
	--Wait before deleting more
	WAITFOR DELAY @Delay

-- remove delete trigger functionality
	DELETE DisableCallTrigger WHERE UserSPID = @@SPID	

	IF @CurrentRowCount = 0  BREAK
END
	--Record number of records copied 
	SET @ErrorMessage = 'Info:> Deleted Call Records: ' + CAST(@TotalRowCount AS VARCHAR(20))
	RAISERROR (@ErrorMessage,1,1)WITH LOG


-- **************************** END DELETE Call


-- **************************** Begin Wrapup Routine
IF @CurrentRowCount = 0  
and (SELECT count(*) from Call where exists (SELECT * from ArchiveCall where ArchiveCall.CallID = Call.CallID )) = 0
	BEGIN 

		SELECT 'Truncating Tables'
		--Record Truncating Tables
		SET @ErrorMessage = 'Truncating Tables'
		RAISERROR (@ErrorMessage,1,1)WITH LOG
				
		TRUNCATE TABLE ArchiveCall
		TRUNCATE TABLE ArchiveCallCriteria
		TRUNCATE TABLE ArchiveCallCustomField
		TRUNCATE TABLE ArchiveCODCaller
		TRUNCATE TABLE ArchiveCODQuestionLog
		TRUNCATE TABLE ArchiveDonorData
		TRUNCATE TABLE ArchiveFSCase
		TRUNCATE TABLE ArchiveLOCall
		TRUNCATE TABLE ArchiveLogEvent
		TRUNCATE TABLE ArchiveMessage
		TRUNCATE TABLE ArchiveNDRICallSheet
		TRUNCATE TABLE ArchiveNoCall
		TRUNCATE TABLE ArchiveReferral
		TRUNCATE TABLE ArchiveReferralSecondaryData
		TRUNCATE TABLE ArchiveSecondary
		TRUNCATE TABLE ArchiveSecondary2
		TRUNCATE TABLE ArchiveSecondaryApproach
		TRUNCATE TABLE ArchiveSecondaryDisposition
		TRUNCATE TABLE ArchiveSecondaryMedication
		TRUNCATE TABLE ArchiveSecondaryMedicationOther
		TRUNCATE TABLE ArchiveRegistryStatus   
		TRUNCATE TABLE ArchiveNOK
		TRUNCATE TABLE ArchiveSecondaryTBI
		TRUNCATE TABLE ArchiveAppropriateCounts
		
		SET @ErrorMessage = 'Deletion of Archive Tables complete.'
		RAISERROR (@ErrorMessage,1,1)WITH LOG
	END

-- **************************** End Wrapup Routine

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

