 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileReferral]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileReferral]
	PRINT 'Dropping Procedure: GetStatFileReferral'
END
	PRINT 'Creating Procedure: GetStatFileReferral'
GO

CREATE PROCEDURE [dbo].[GetStatFileReferral]
(
	@StartDateTime datetime,
	@EndDateTime datetime,
	@WebReportGroupID int,
	@OrganizationID int ,
	@DateTypeID int,
	@ExportFileID int = 0,
	@SeperateFiles bit = 0,
	@CloseCaseTriggerID int = 0,
	@CloseCaseOverride int = 0
)
/******************************************************************************
**		File: GetStatFileReferral.sql
**		Name: GetStatFileReferral
**		Desc:  Used on StatFile
**
**		Called by:  
**              StatFile
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
**********************************************************************************************
**		Change History
**********************************************************************************************
**		Date:		Author:			Description:
**		--------	--------		----------------------------------------------------------
**		03/02/2009	Bret Knoll		initial
**		02/01/2018	Mike Berenson	added check to make sure file isn't in the CloseCaseQueue
**********************************************************************************************/
AS

/*
This procedure uses 6 steps to generate two dataSets the First DataSet is always generated by Create Date. 
The second dataset is created by lastmodified.	
1. Check the CloseCaseQueue table for any cases where the override time has past or the Trigger has tripped.
2. Build ExportFileQueue
3. Add cases from the ExportFileQueue to the CloseCaseQueue where the CloseCaseTrigger has not tripped
4. Call GetStatFileReferralSelect
5. Clear ExportFileQueue for ExportFileID
6. Clear CloseCaseQueue for ExportFileID and Disabled cases

*/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
DECLARE
	@Created bit, 
	@Modified bit,
	@loopMax int,
	@loopCount int
SET @loopCount = 0

print 'step 0'
-- clear the exportFileQue to ensure a fresh start.
		DELETE ExportFileQueue
		WHERE ExportFileID = @ExportFileID

IF(@SeperateFiles = 1)
BEGIN
	SET @loopMax = 2
END
ELSE 
BEGIN
	SET @loopMax = 1
END

-- Run the 	GetStatFileReferralSelect if @SeperateFiles = 0 and @DateTypeID = 1 (lastmodified)
-- This generates an empty dataset 
if(@SeperateFiles = 0 AND @DateTypeID = 1 )
BEGIN
	EXEC GetStatFileReferralSelect @ExportFileID, @OrganizationID
END

WHILE (@loopCount < @loopMax)
BEGIN
	-- determine if to query createDate or lastmodified
	IF (@SeperateFiles = 1)-- yes supply two files
	BEGIN
		IF (@loopCount = 0) -- first loop
		BEGIN
			SET @Created = 1
			SET @Modified = 0
		END
		ELSE IF (@loopCount = 1) -- second loop
		BEGIN
			SET @Created = 0
			SET @Modified = 1
		END
		
	END
	ELSE IF(@SeperateFiles = 0) -- no supply one one file
	BEGIN
		IF (@DateTypeID = 0) -- use Created
		BEGIN
			SET @Created = 1
			SET @Modified = 0
		END
		ELSE IF (@DateTypeID = 1) -- use lastmofied
		BEGIN
			SET @Created = 1 
			SET @Modified = 1
		END	
	END
		-- add a step to detect Missed referrals
		-- IF a Referral either has not been sent or is not queueue then add it to the queue
		IF (exists(SELECT * FROM sysobjects WHERE name like 'checkReferralQueue') and exists(select * from sysobjects where name like 'checkCloseCaseQueue'))
			BEGIN 
				DECLARE @alternateStart DATETIME
				SET @alternateStart = DATEADD(MINUTE, -@CloseCaseOverride, @StartDateTime)
				INSERT CloseCaseQueue
				SELECT 
					fnCallList.CallID,
					GETDATE(),
					@ExportFileID, 
					1 -- enable
				FROM	
					dbo.fn_GetCallIDList(@alternateStart, @StartDateTime, @Created, @Modified) fnCallList
				JOIN Referral r ON r.CallID = fnCallList.CallID
				JOIN Call c ON c.CallID = fnCallList.CallID
				WHERE
					r.ReferralCallerOrganizationID IN (SELECT WebReportGroupOrg.OrganizationID FROM WebReportGroupOrg WHERE WebReportGroupOrg.WebReportGroupID = @WebReportGroupID  )
				AND	
					c.SourceCodeID IN (SELECT SourceCodeID FROM dbo.fn_SourceCodeList(@WebReportGroupID, NULL))
				AND 
					c.callid NOT IN (SELECT checkreferralqueue.callid FROM CheckReferralQueue WHERE ExportFileID = @ExportFileID)
				AND 
					c.callid NOT IN (SELECT checkclosecasequeue.callid FROM CheckCloseCaseQueue WHERE ExportFileID = @ExportFileID)
				AND c.callid NOT IN (SELECT callid FROM CloseCaseQueue WHERE ExportFileID = @ExportFileID );		
			END


	-- Step 1: 1. Check the CloseCaseQueue table for any cases where the override time has past or the Trigger has tripped.
	/*
		Use dbo.fn_StatFileCloseCaseTriggerDisable(@CloseCaseTriggerID, @ExportFileID) to identify cases where the case has closed based on trigger
		
		User @CloseCaseOverride to flag cases as closed if the override time has past
		
	*/
	-- ONLY RUN ON LOOP 1
	IF (@loopCount = 0)
	BEGIN
		UPDATE 
			CloseCaseQueue
		SET 
			ENABLED = 0
		WHERE 
			(ExportFileID = @ExportFileID)
		AND
			(
			CallID IN (SELECT CallID FROM dbo.fn_StatFileCloseCaseTriggerDisable(@CloseCaseTriggerID, @ExportFileID) )
			OR
			DateAdd(n, @CloseCaseOverride, LastModified)  < GetDate()
			)
		AND (@CloseCaseOverride > 0)
	END

	-- Step 2: 2. Build ExportFileQueue
	/*
		use dbo.fn_GetCallIDList

	*/
		INSERT ExportFileQueue
		SELECT 
			fnCallList.CallID, 
			@ExportFileID, 
			1 -- Enabled
		FROM	
			dbo.fn_GetCallIDList (@StartDateTime, @EndDateTime, @Created, @Modified	) fnCallList
		JOIN Referral r ON r.CallID = fnCallList.CallID
		JOIN Call c ON c.CallID = fnCallList.CallID
		WHERE
			r.ReferralCallerOrganizationID IN (SELECT WebReportGroupOrg.OrganizationID FROM WebReportGroupOrg WHERE WebReportGroupOrg.WebReportGroupID = @WebReportGroupID  )
		AND	
			c.SourceCodeID IN (SELECT SourceCodeID FROM dbo.fn_SourceCodeList(@WebReportGroupID, NULL))

	-- Step 3:
	/*
		Use dbo.fn_StatFileCloseCaseTrigger(@CloseCaseTriggerID, @ExportFileID) to identify cases where the case has closed based on trigger

	*/
		INSERT 
			CloseCaseQueue
		SELECT  
			CallID,
			GetDate(),
			@ExportFileID,
			1 -- enabled 
		FROM 
			dbo.fn_StatFileCloseCaseTrigger(@CloseCaseTriggerID, @ExportFileID)
		WHERE CALLID NOT IN (SELECT callid FROM CloseCaseQueue WHERE ExportFileID = @ExportFileID );

		-- add a step to log CloseCaseQueue
		-- this will only happen if the table exists
			if exists(select * from sysobjects where name like 'checkCloseCaseQueue')
			begin 
				INSERT checkCloseCaseQueue
				SELECT
					CallID, LastModified, ExportFileID
				FROM
					closeCaseQueue
				where not exists (select checkCloseCaseQueue.CallID from checkCloseCaseQueue where checkCloseCaseQueue.CallID = closeCaseQueue.CallID and checkCloseCaseQueue.ExportFileID = closeCaseQueue.ExportFileID )
				and ExportFileID = @ExportFileID
			end

		-- add a stop to log Referral 
			if exists(select * from sysobjects where name like 'checkReferralQueue')
			begin 
		
				INSERT checkReferralQueue
				SELECT CallID, GETDATE(), @ExportFileID
				FROM CALL 
				WHERE 
					Call.CallID IN (
									SELECT CallID FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
									UNION
									SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0				
									)		
				AND 
					Call.CallID NOT IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1)
			end
	-- Step 4:
		EXEC GetStatFileReferralSelect @ExportFileID, @OrganizationID

	-- Step 5:
		DELETE ExportFileQueue
		WHERE ExportFileID = @ExportFileID

	-- Step 6:
		DELETE CloseCaseQueue
		WHERE
			ExportFileID = @ExportFileID
		AND 
			Enabled = 0

	SET @loopCount = @loopCount + 1

END
-- Run the 	GetStatFileReferralSelect if @SeperateFiles = 0 and @DateTypeID = 0 (CreateDate)
-- this generates an empty dataset
if(@SeperateFiles = 0 AND @DateTypeID = 0 )
BEGIN
	EXEC GetStatFileReferralSelect @ExportFileID, @OrganizationID
END

GO
