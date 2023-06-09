SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ArchiveData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ArchiveData]
GO


CREATE PROCEDURE sps_ArchiveData 
	@Month			SMALLDATETIME = null,
	@LastDateRan	SMALLDATETIME = null

AS
/******************************************************************************
**		File: 
**		Name: sps_ArchiveData
**		Desc: sps_ArchiveData pulls data from the production tables to the archive tables
**
**              
**		Return values: 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 10/10/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		10/10/07	Bret Knoll			2006 Data Archive
*******************************************************************************/
-- Declare variables
DECLARE @ProductionCount	int,
	@CurrentDataSize	int,
	@ErrorMessage		varchar(600),
	@DaysToArchive		int,		
	@TableID		int,
	@DayLightStartDate      datetime,	
        @DayLightEndDate        datetime,
        @Year			int,
        @RowCount		int,
        @Delay			varchar(10),
	@starttime		datetime,
	@endtime		datetime,
	@CurrentRowCount	int



-- set the delay between selects
SELECT @Delay = '00:00:05'
-- Set the number of months to archive, default 6 (This is the number of days ago after which no data will be archived)
SET @CurrentDataSize = 160 -- 
--Added datepart...dateadd humbo jumbo to account for full months. gets number of days for the next month of archive
SELECT  @DaysToArchive = datepart(d,dateadd(d,-1,dateadd(m,1,rtrim(cast(Datepart(m,DATEADD(d,1,max(TableDate))) as char)) + '/1/' + cast(Datepart(yy,DATEADD(d,1,max(TableDate))) as char)))) FROM ArchiveStatus
-- datepart(d,dateadd(d,-1,dateadd(m,1,rtrim(cast(Datepart(m,@myDate) as char)) + '/1/' + cast(Datepart(yy,@myDate) as char))))

-- Confirm Archive Tables are empty. If any data exists in the Archive tables return error

IF	(select count(*) from ArchiveCall)>0 
OR	(select count(*) from ArchiveCallCriteria)>0
OR 	(select count(*) from ArchiveCallCustomField)>0
OR 	(select count(*) from ArchiveCODCaller)>0
OR 	(select count(*) from ArchiveCODQuestionLog)>0
OR	(select count(*) from ArchiveDonorData)>0
OR	(select count(*) from ArchiveFSCase)>0
OR	(select count(*) from ArchiveLOCall)>0
OR	(select count(*) from ArchiveLogEvent)>0
OR	(select count(*) from ArchiveMessage)>0
OR	(select count(*) from ArchiveNDRICallSheet)>0
OR	(select count(*) from ArchiveNoCall)>0
OR	(select count(*) from ArchiveNOK)>0
OR	(select count(*) from ArchiveReferral)>0
OR	(select count(*) from ArchiveReferralSecondaryData)>0
OR	(select count(*) from ArchiveRegistryStatus)>0
OR	(select count(*) from ArchiveSecondary)>0
OR	(select count(*) from ArchiveSecondary2)>0
OR	(select count(*) from ArchiveSecondaryApproach)>0
OR	(select count(*) from ArchiveSecondaryDisposition)>0
OR	(select count(*) from ArchiveSecondaryMedication)>0
OR	(select count(*) from ArchiveSecondaryMedicationOther)>0
OR	(select count(*) from ArchiveSecondaryTBI)>0
OR	(select count(*) from ArchiveAppropriateCounts)>0

BEGIN
	RAISERROR  ('Archive tables were not truncated. Confirm archive completed',11,1)with LOG
	RETURN 1
END
-- If @Month was not set by the application calling this stored procedure 
--- determine what the next archive month is  
IF (@Month IS NULL)
BEGIN
	-- Determine the next month to archive
	SELECT 	@Month = DATEADD(d,@DaysToArchive,ISNULL(TableDate,'9/1/96 00:00')),
		@LastDateRan = TableDate
	FROM 	ArchiveStatus
	WHERE	TableDate = (SELECT MAX(TableDate) FROM ArchiveStatus )
END

-- get daylight saving dates
	SELECT @Year = DATEPART(YYYY, @Month)
	EXEC spf_GetDayLightDates
        @Year = @Year,
        @DayLightStartDate = @DayLightStartDate OUTPUT,
        @DayLightEndDate = @DayLightEndDate    OUTPUT

-- Confirm the current archive month is not less than set size
IF DATEDIFF(d, @Month, GETDATE()) <= @CurrentDataSize
BEGIN	
	SET @ErrorMessage = 'Archive Month within ' + CAST(@CurrentDataSize AS VARCHAR(20))
	RAISERROR (@ErrorMessage,11,1)with LOG
	RETURN 1
END

-- send current month to log
SET @ErrorMessage = 'Information Message:> Current Archive Date is ' + Cast(@Month AS VARCHAR(20))
RAISERROR (@ErrorMessage,10,1)with LOG

-- Update ArchiveStatus table

INSERT		ArchiveStatus (TableDate,Status)
VALUES 		(
		@Month,
		'Processing'
		)

-- START TRANSACTION

SET @RowCount = 0 

--BEGIN TRANSACTION Archive
SELECT 'Archive Call Data'
-- Archive Call Data
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()
	
	INSERT		ArchiveCall
	SELECT 		TOP 1500
			C.* 
	FROM 		Call C
	LEFT JOIN	Referral r ON r.CallID = C.CallID
	LEFT JOIN	MESSAGE m  ON m.CallID = C.CallID	
	LEFT JOIN	Organization ro ON ro.OrganizationID = r.ReferralCallerOrganizationID
	LEFT JOIN TimeZone  rt ON ro.TimeZoneId = rt.TimeZoneID

	LEFT JOIN	Organization mo ON mo.OrganizationID = m.OrganizationID
	LEFT JOIN TimeZone mt ON mo.TimeZoneId = mt.TimeZoneID

	WHERE		-- bjk 08/16/06 replace with new statement to capture TZ differences CallDateTime >=  DATEADD(d,1,@LastDateRan) AND CallDateTime < DATEADD(d,1,@Month)

		DATEADD(hh,
		--- start case statement to adjust calldatetime
		(CASE 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'AT' Then 3 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'ET' Then 2 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'CT' Then 1 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'MT' Then 0 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'PT' Then -1 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'KT' Then -2 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'HT' Then -3 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'ST' Then -4 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'AS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'ES'	
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'CS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'MS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'PS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'KS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'HS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
		When CASE WHEN rt.TimeZoneAbbreviation IS NULL THEN mt.TimeZoneAbbreviation ELSE  rt.TimeZoneAbbreviation END = 'SS' 
			Then (case when CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End) 
		END ), CallDateTime)		
		-- end case statment to adjust calldatetime
		< DATEADD(d,1,@Month)	
		AND C.CALLID NOT IN (SELECT CallID FROM ArchiveCall)

	SET @CurrentRowCount = @@ROWCOUNT 
	
	SET @RowCount = @RowCount + @CurrentRowCount
	
	SELECT @endtime = GETDATE()
	PRINT 'Call times: ' + CAST(DATEDIFF(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + CAST(DATEDIFF(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay
END
--Record number of records copied from Call
SET @ErrorMessage = 'Information Message:> Call Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive Referral Data '

WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveReferral 
	SELECT	TOP 1500
		R.* 
	FROM 	Referral R, ArchiveCall AC
	WHERE	R.CallID = AC.CallID
	AND	R.ReferralID NOT IN (SELECT ReferralID FROM ArchiveReferral)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'Referral time: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay

END
	

--Record number of records copied from Referral
SELECT @ErrorMessage = 'Information Message:> Referral Records: ' + cast(COUNT(*) AS VARCHAR(20)) FROM ArchiveReferral
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive ReferralSecondary Data '
-- Archive ReferralSecondary Data sp_help ReferralSecondaryData
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveReferralSecondaryData
	SELECT 	TOP 1500
	 	RSD.* 
	FROM 	ReferralSecondaryData RSD, ArchiveReferral AR
	WHERE	RSD.ReferralID = AR.ReferralID 
	AND	RSD.ReferralID NOT IN (SELECT ReferralID FROM ArchiveReferralSecondaryData)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'ReferralSecondaryData time: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay
	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> ReferralSecondaryData Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive LogEvent  '
-- ****** 
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveLogEvent	
	SELECT 	TOP 1500
		LE.* 
	FROM 	LogEvent LE, ArchiveCall AC
	WHERE	LE.CallID = AC.CallID	
	AND 	LE.LogEventID NOT IN (SELECT LogEventID FROM ArchiveLogEvent)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'LogEvent times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay
	
END
-- ****** 


--Record number of records copied 
SELECT @ErrorMessage = 'Information Message:> LogEvent Records: ' + cast(Count(*) AS VARCHAR(20)) from ArchiveLogEvent 
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive CallCustomField '
-- Archive CallCustomField sp_help CallCustomField
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveCallCustomField
	SELECT 	TOP 1500
		CCF.*
	FROM	CallCustomField CCF, ArchiveCall AC
	WHERE	CCF.CallID = AC.CallID
	AND 	CCF.CALLID NOT IN (SELECT CallID FROM ArchiveCallCustomField)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'CallCustomField times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay

END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> CallCustomField Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive Message '
-- Archive Message sp_help Message
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveMessage
	SELECT 	TOP 1500
		M.*
	FROM	Message M, ArchiveCall AC
	WHERE	M.CallID = AC.CallID
	AND 	M.MessageID NOT IN (SELECT MessageID FROM ArchiveMessage)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'Message times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay

END

--Record number of records copied 
SET @ErrorMessage = 'Information Message:> Message Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive NoCall '
-- Archive NoCall sp_help NoCall
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveNoCall
	SELECT 		TOP 1500
			NC.*
	FROM		NoCall NC, ArchiveCall AC
	WHERE		NC.CallID = AC.CallID
	AND 	NC.NoCallID NOT IN (SELECT NoCallID FROM ArchiveNoCall)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'NoCall times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay
	
	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> NoCall Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive LOCall'
-- Archive LOCall sp_help LOCall
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT	ArchiveLOCall
	SELECT	TOP 1500
		LC.*
	FROM	LOCall LC, ArchiveCall AC
	WHERE	LC.CallID = AC.CallID
	AND 	LC.LOCallID NOT IN (SELECT LOCallID FROM ArchiveLOCall)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'LOCall times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay
	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> LOCall Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

SET @RowCount = 0

select 'Archive FSCase '
-- Archive FS Case
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveFSCase
	SELECT 		TOP 1500
			FC.*
	FROM		FSCase FC, ArchiveCall AC
	WHERE		FC.CallID = AC.CallID
	AND 	FC.FSCaseID NOT IN (SELECT FSCaseID FROM ArchiveFSCase)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'FSCase times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> FSCase Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG

--*************
-- Archive CallCriteria

SET @RowCount = 0

select 'Archive CallCriteria'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveCallCriteria
	SELECT 		TOP 1500
			CC.*
	FROM		CallCriteria CC, ArchiveCall AC
	WHERE		CC.CallID = AC.CallID
	AND 	CC.CALLID NOT IN (SELECT CallID FROM ArchiveCallCriteria)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'CallCriteria times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> CallCriteria Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive DonorData
SET @RowCount = 0

select 'Archive DonorData'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveDonorData
	SELECT 		TOP 1500
			DD.*
	FROM		DonorData DD, ArchiveCall AC
	WHERE		DD.CallID = AC.CallID	
	AND 	DD.DonorDataID NOT IN (SELECT DonorDataID FROM ArchiveDonorData)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'DonorData times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> DonorData Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive Secondary

SET @RowCount = 0

select 'Archive Secondary'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondary
	SELECT 		TOP 1500
			S.*
	FROM		Secondary S, ArchiveCall AC
	WHERE		S.CallID = AC.CallID
	AND 	S.CallID NOT IN (SELECT CallID FROM ArchiveSecondary)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'Secondary times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> Secondary Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive Secondary2

SET @RowCount = 0

select 'Archive Secondary2'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondary2
	SELECT 		TOP 1500
			S2.*
	FROM		Secondary2 S2, ArchiveCall AC
	WHERE		S2.CallID = AC.CallID
	AND 	S2.CallID NOT IN (SELECT CallID FROM ArchiveSecondary2)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'Secondary2 times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> Secondary2 Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive SecondaryApproach

SET @RowCount = 0

select 'Archive SecondaryApproach'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondaryApproach
	SELECT 		TOP 1500
			SA.*
	FROM		SecondaryApproach SA, ArchiveCall AC
	WHERE		SA.CallID = AC.CallID
	AND 	SA.CallID NOT IN (SELECT CallID FROM ArchiveSecondaryApproach)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'SecondaryApproach times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> SecondaryApproach Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive SecondaryDisposition

SET @RowCount = 0

select 'Archive SecondaryDisposition'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondaryDisposition
	SELECT 		TOP 1500
			SD.*
	FROM		SecondaryDisposition SD, ArchiveCall AC
	WHERE		SD.CallID = AC.CallID
	AND 	SD.SecondaryDispositionID NOT IN (SELECT SecondaryDispositionID FROM ArchiveSecondaryDisposition)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	
	SELECT @endtime = GETDATE()
	
	print 'SecondaryDisposition times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
	
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> SecondaryDisposition Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive SecondaryMedication

SET @RowCount = 0

select 'Archive SecondaryMedication'
	SELECT @StartTime = GETDATE()


	INSERT		ArchiveSecondaryMedication
	SELECT 		
			SM.*
	FROM		SecondaryMedication SM, ArchiveCall AC
	WHERE		SM.CallID = AC.CallID

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'SecondaryMedication times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))

	WAITFOR DELAY @Delay			

--Record number of records copied 
SET @ErrorMessage = 'Information Message:> SecondaryMedication Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive SecondaryMedicationOther

SET @RowCount = 0

select 'Archive SecondaryMedicationOther'
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondaryMedicationOther
	SELECT 		
			SMO.*
	FROM		SecondaryMedicationOther SMO, ArchiveCall AC
	WHERE		SMO.CallID = AC.CallID
	
	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'SecondaryMedicationOther times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))

	WAITFOR DELAY @Delay		
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> SecondaryMedicationOther Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 


-- New archives added for: CODCaller, CODQuestionLog, NDRICallSheet 8/13/04 - SAP
-- *************
-- Archive CODCaller

SET @RowCount = 0

select 'Archive CODCaller'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveCODCaller
	SELECT 		TOP 1500
			CC.*
	FROM		CODCaller CC, ArchiveCall AC
	WHERE		CC.CallID = AC.CallID
	AND 	CC.CODCallerID NOT IN (SELECT CODCallerID FROM ArchiveCODCaller)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'CODCaller times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> CODCaller Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- ************* 
-- Archive CODQuestionLog

SET @RowCount = 0

select 'Archive CODQuestionLog'
WHILE (0=0)
BEGIN
	SELECT @StartTime = GETDATE()

	INSERT		ArchiveCODQuestionLog
	SELECT 		TOP 1500
			CQ.*
	FROM		CODQuestionLog CQ, ArchiveCall AC
	WHERE		CQ.CallID = AC.CallID
	AND 	CQ.CODQuestionLogID NOT IN (SELECT CODQuestionLogID FROM ArchiveCODQuestionLog)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'CODQuestionLog times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay			
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> CODQuestionLog Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- *************
-- Archive NDRICallSheet

SET @RowCount = 0

select 'Archive NDRICallSheet'
WHILE (0=0)
BEGIN

	SELECT @StartTime = GETDATE()

	INSERT		ArchiveNDRICallSheet
	SELECT 		TOP 1500
			ND.*
	FROM		NDRICallSheet ND, ArchiveCall AC
	WHERE		ND.CallID = AC.CallID
	AND 	ND.NDRICallSheetID NOT IN (SELECT NDRICallSheetID FROM ArchiveNDRICallSheet)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'NDRICallSheet times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> NDRICallSheet Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 


-- *************
-- Archive RegistryStatus

SET @RowCount = 0

select 'Archive RegistryStatus'
WHILE (0=0)
BEGIN

	SELECT @StartTime = GETDATE()

	INSERT		ArchiveRegistryStatus
	SELECT 		TOP 1500
			RS.*
	FROM		RegistryStatus RS, ArchiveCall AC
	WHERE		RS.CallID = AC.CallID
	AND 	RS.ID NOT IN (SELECT ID FROM ArchiveRegistryStatus)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'RegistryStatus times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> RegistryStatus Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- *************

-- *************
-- Archive NOK

SET @RowCount = 0

select 'Archive NOK'
WHILE (0=0)
BEGIN

	SELECT @StartTime = GETDATE()

	INSERT		ArchiveNOK
	SELECT 		TOP 1500
			N.*
	FROM		NOK N, ArchiveReferral AR
	WHERE		N.NOKID = AR.ReferralNOKID
	AND 		N.NOKID NOT IN (SELECT NOKID FROM ArchiveNOK)

	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'NOK times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> NOK Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 
-- *************
-- Archive SecondaryTBI

SET @RowCount = 0

select 'Archive ArchiveSecondaryTBI'
WHILE (0=0)
BEGIN

	SELECT @StartTime = GETDATE()

	INSERT		ArchiveSecondaryTBI
	SELECT 	TOP 1500
		STBI.* 
	FROM 	SecondaryTBI STBI, ArchiveCall AC
	WHERE	STBI.CallID = AC.CallID	
	AND 	STBI.CallID NOT IN (SELECT CallID FROM ArchiveSecondaryTBI)


	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'SecondaryTBI times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> SecondaryTBI Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 
-- *************
-- Archive AppropriateCounts

SET @RowCount = 0

select 'Archive AppropriateCounts'
WHILE (0=0)
BEGIN

	SELECT @StartTime = GETDATE()

	INSERT		ArchiveAppropriateCounts
	SELECT 	TOP 1500
		aCounts.* 
	FROM 	AppropriateCounts aCounts, ArchiveCall AC
	WHERE	aCounts.CallID = AC.CallID	
	AND 	aCounts.CallID NOT IN (SELECT CallID FROM ArchiveAppropriateCounts)


	SET @CurrentRowCount = @@ROWCOUNT 
	SET @RowCount = @RowCount + @CurrentRowCount
	SELECT @endtime = GETDATE()
	print 'AppropriateCounts times: ' + cast(datediff(ms,@starttime, @endtime) AS VARCHAR(20)) + ' ' + cast(datediff(s,@starttime, @endtime) AS VARCHAR(20))
	IF @CurrentRowCount = 0 BREAK;

	WAITFOR DELAY @Delay		
END
--Record number of records copied 
SET @ErrorMessage = 'Information Message:> AppropriateCounts Records: ' + cast(@RowCount AS VARCHAR(20))
RAISERROR (@ErrorMessage,1,1)with LOG
-- ************* 

-- set archive flag for Organization
	DECLARE @OrgIDTable Table
	(
		ID INT IDENTITY(1,1),
		OrgID	INT
	)


	INSERT @OrgIDTable (OrgID)
	SELECT DISTINCT ReferralCallerOrganizationID	FROM ArchiveReferral 
	UNION ALL
	SELECT DISTINCT OrganizationID			FROM ArchiveCODCaller 
	UNION ALL
	SELECT DISTINCT OrganizationID			FROM ArchiveLogEvent
	UNION ALL
	SELECT DISTINCT OrganizationID			FROM ArchiveMessage 

-- wait for delay here
	WAITFOR DELAY @Delay		

	UPDATE ORGANIZATION 
	SET OrganizationArchive	= 1
	WHERE OrganizationID IN (SELECT OrgID FROM @OrgIDTable)


-- end set archive flag for Organization

-- set archive flag for Person

-- WAIT FOR DELAY HERE
	WAITFOR DELAY @Delay		

	DECLARE @PerIDTable Table
	(
		ID INT IDENTITY(1,1),
		PerID	INT
	)


	INSERT @PerIDTable (PerID)
	SELECT DISTINCT ReferralCallerPersonID		FROM ArchiveReferral 
	UNION ALL
	SELECT DISTINCT ReferralApproachedByPersonID	FROM ArchiveReferral 
	UNION ALL
	SELECT DISTINCT PersonID			FROM ArchiveLogEvent 
	UNION ALL
	SELECT DISTINCT SecondaryManualBillPersonId	FROM ArchiveFSCase 
	UNION ALL
	SELECT DISTINCT PersonID			FROM ArchiveMessage 

-- place a delay here
	WAITFOR DELAY @Delay		
	
	UPDATE Person
	SET PersonArchive = 1
	WHERE PersonID IN (SELECT PerID FROM @perIDTable WHERE ISNULL(PERID, 0)<>0 )

-- end set archive flag for Person



--END TRANSACTION
--COMMIT TRANSACTION Archive

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

