SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO
IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'spd_CallRecyclePurge')
	BEGIN
		PRINT 'Dropping Procedure spd_CallRecyclePurge'
		DROP Procedure spd_CallRecyclePurge
	END
GO

PRINT 'Creating Procedure spd_CallRecyclePurge'
GO

CREATE PROCEDURE spd_CallRecyclePurge 
/******************************************************************************
**		File: spd_CallRecyclePurge.sql
**		Name: spd_CallRecyclePurge
**		Desc:
**		Removes any records in the CallRecycle table along with any accompanying 
**		records in the LogEvent, FSCase, LOCall, CallCustomField, CallCriteria,
**		Secondary, Secondary2, SecondaryApproach, SecondaryDisposition,
**		SecondaryMedication, SecondaryMedicationOther, DonorData, RegistryStatus,
**		Referral, Message, and NoCall.  Logic was taken from Call delete trigger.
**		Created for StatTrac v. 7.7.4 
**		
**              
**		Return values: 
**		
**		Called by: SQL Server Job
**              
**
**
**		Auth: Scott Plummer
**		Date: 5/26/05
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------
**		5/26/05		Scott Plummer	v. 7.7.4 
**		2/20/08		jth				Adding functionality to move calls into recyclecall
**		05/19/2011	ccarroll		Changed to Cursor and removed top 50 wi:12299
**									Added OASIS
**      06/20/11    jth             added FsbCaseStatus
*******************************************************************************/
AS

SET NOCOUNT ON

DECLARE @CallID int

DECLARE @weekAgo datetime
SET @weekAgo = DateAdd(dd, -7, GetDate())

/* Purge Recycled Calls */
DECLARE @getCallID CURSOR
	SET @getCallID = CURSOR FOR
		SELECT CallId 
		FROM CallRecycle
		WHERE RecycleDateTime < @weekAgo;
OPEN @getCallID
FETCH NEXT
	FROM @getCallID INTO @CallID

WHILE @@FETCH_STATUS = 0
BEGIN
	--Delete AlphaPage
	DELETE FROM dbo.AlphaPage WHERE CallID = @CallID;
	-- Delete AutoResponseCode
	DELETE FROM dbo.AutoResponseCode WHERE CallID = @CallID;
	-- Delete CallCustomField records
	DELETE FROM CallCustomField WHERE CallId = @CallID;
	-- Delete CallCriteria records
	DELETE FROM CallCriteria WHERE CallId = @CallID;
	--Delete CallIncompleteDate
	DELETE FROM dbo.CallIncompleteDate WHERE CallID = @CallID;
	--Delete CODCaller
	DELETE FROM dbo.CODCaller WHERE CallID = @CallID;
	--Delete DocumentRequestQueue
	DELETE FROM dbo.DocumentRequestQueue WHERE CallID = @CallID;
	-- Delete DonorData records
	DELETE FROM DonorData WHERE CallId = @CallID;
	-- Delete FsbCaseStatus records
	DELETE FROM FsbCaseStatus WHERE CallId = @CallID;
	-- Delete FSCase records
	DELETE FROM FSCase WHERE CallId = @CallID;
	-- Delete LOCall records
	DELETE FROM LOCall WHERE CallId = @CallID;
	-- Delete LogEvent records
	DELETE FROM LogEvent WHERE CallID = @CallID;
	-- Delete Message records
	DELETE FROM [Message] WHERE CallId = @CallID;
	-- Delete NoCall records
	DELETE FROM NoCall WHERE CallId = @CallID;
	-- Delete Referral records
	DELETE FROM Referral WHERE CallId = @CallID;
	-- Delete RegistryStatus records
	DELETE FROM RegistryStatus WHERE CallId = @CallID;
	-- Delete Secondary records
	DELETE FROM [Secondary] WHERE CallId = @CallID;
	-- Delete Secondary2 records
	DELETE FROM Secondary2 WHERE CallId = @CallID;
	-- Delete SecondaryApproach records
	DELETE FROM SecondaryApproach WHERE CallId = @CallID;
	-- Delete SecondaryDisposition records
	DELETE FROM SecondaryDisposition WHERE CallId = @CallID;
	-- Delete SecondaryMedication records
	DELETE FROM SecondaryMedication WHERE CallId = @CallID;
	-- Delete SecondaryMedicationOther records
	DELETE FROM SecondaryMedicationOther WHERE CallId = @CallID;
	--Delete TcssRecipientOfferInformation
	DELETE FROM TcssRecipientOfferInformation WHERE CallId = @CallID;
	-- Almost finally, Delete the CallRecycle records themselves
	DELETE FROM CallRecycle WHERE CallID = @CallID;

FETCH NEXT
	FROM @getCallID INTO @CallID
END
CLOSE @getCallID;
DEALLOCATE @getCallID;


/* Purge OASIS Calls */
DECLARE @getOASISCallID CURSOR
	SET @getOASISCallID = CURSOR FOR
		SELECT CallId 
		FROM Call
		JOIN CallType ON Call.CallTypeID = CallType.CallTypeID AND Call.CallTypeID = 6 -- OASIS
		WHERE CallDateTime < @weekAgo AND
			  CallActive = 0;
			   
OPEN @getOASISCallID
FETCH NEXT
	FROM @getOASISCallID INTO @CallID

WHILE @@FETCH_STATUS = 0
BEGIN
	--Delete AlphaPage
	DELETE FROM dbo.AlphaPage WHERE CallID = @CallID;
	-- Delete AutoResponseCode
	DELETE FROM dbo.AutoResponseCode WHERE CallID = @CallID;
	-- Delete CallCustomField records
	DELETE FROM CallCustomField WHERE CallId = @CallID;
	-- Delete CallCriteria records
	DELETE FROM CallCriteria WHERE CallId = @CallID;
	--Delete CallIncompleteDate
	DELETE FROM dbo.CallIncompleteDate WHERE CallID = @CallID;
	--Delete CODCaller
	DELETE FROM dbo.CODCaller WHERE CallID = @CallID;
	--Delete DocumentRequestQueue
	DELETE FROM dbo.DocumentRequesetQueue WHERE CallID = @CallID;
	-- Delete DonorData records
	DELETE FROM DonorData WHERE CallId = @CallID;
	-- Delete FsbCaseStatus records
	DELETE FROM FsbCaseStatus WHERE CallId = @CallID;
	-- Delete FSCase records
	DELETE FROM FSCase WHERE CallId = @CallID;
	-- Delete LOCall records
	DELETE FROM LOCall WHERE CallId = @CallID;
	-- Delete LogEvent records
	DELETE FROM LogEvent WHERE CallID = @CallID;
	-- Delete Message records
	DELETE FROM [Message] WHERE CallId = @CallID;
	-- Delete NoCall records
	DELETE FROM NoCall WHERE CallId = @CallID;
	-- Delete Referral records
	DELETE FROM Referral WHERE CallId = @CallID;
	-- Delete RegistryStatus records
	DELETE FROM RegistryStatus WHERE CallId = @CallID;
	-- Delete Secondary records
	DELETE FROM [Secondary] WHERE CallId = @CallID;
	-- Delete Secondary2 records
	DELETE FROM Secondary2 WHERE CallId = @CallID;
	-- Delete SecondaryApproach records
	DELETE FROM SecondaryApproach WHERE CallId = @CallID;
	-- Delete SecondaryDisposition records
	DELETE FROM SecondaryDisposition WHERE CallId = @CallID;
	-- Delete SecondaryMedication records
	DELETE FROM SecondaryMedication WHERE CallId = @CallID;
	-- Delete SecondaryMedicationOther records
	DELETE FROM SecondaryMedicationOther WHERE CallId = @CallID;
	--Delete TcssRecipientOfferInformation
	DELETE FROM TcssRecipientOfferInformation WHERE CallId = @CallID;
	-- Almost finally, Delete the CallRecycle records themselves
	DELETE FROM CallRecycle WHERE CallID = @CallID;

FETCH NEXT
	FROM @getOASISCallID INTO @CallID
END
CLOSE @getOASISCallID;
DEALLOCATE @getOASISCallID;

/* GetOrphanCall CURSOR */
--New 2/08 Move Orphan Calls into CallRecycle
DECLARE @getOrphanCallID CURSOR
	SET @getOrphanCallID = CURSOR FOR
		SELECT CallID
		FROM   Call C
		WHERE	(ISNULL(CallActive, 0) <> -1) AND
				(ISNULL(CallTypeID, 0) IN (-1, 0, 1, 2)) AND 
				(CallDateTime >= DATEADD(d, -30, GETDATE())) AND 
				(CallDateTime <= DATEADD(hh, -3, GETDATE())) AND -- exclude calls in CallRecycle
				not exists (select 1 from CallRecycle where CallRecycle.CallID = C.Callid);

OPEN @getOrphanCallID
FETCH NEXT
	FROM @getOrphanCallID INTO @CallID

WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC spi_CallRecycleSuspend @CallId;

FETCH NEXT
	FROM @getOrphanCallID INTO @CallID
END
CLOSE @getOrphanCallID;
DEALLOCATE @getOrphanCallID;


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

