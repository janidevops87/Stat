 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileMessageEvent]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileMessageEvent]
	PRINT 'Dropping Procedure: GetStatFileMessageEvent'
END
	PRINT 'Creating Procedure: GetStatFileMessageEvent'
GO

CREATE PROCEDURE [dbo].[GetStatFileMessageEvent]
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
**		File: GetStatFileMessageEvent.sql
**		Name: GetStatFileMessageEvent
**		Desc:  Used on StatFile
**
**		Called by:  
**              StatFile
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/02/2009	Bret Knoll	initial
*******************************************************************************/
AS

/*
This procedure uses 6 steps to generate two dataSets the First DataSet is always generated by Create Date. 
The second dataset is created by lastmodified.	
1. Check the CloseCaseQueue table for any cases where the override time has past or the Trigger has tripped.
2. Build ExportFileQueue
3. Add cases from the ExportFileQueue to the CloseCaseQueue where the CloseCaseTrigger has not tripped
4. Call GetStatFileMessageEventSelect
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

-- Run the 	GetStatFileMessageEventSelect if @SeperateFiles = 0 and @DateTypeID = 1 (lastmodified)
if(@SeperateFiles = 0 AND @DateTypeID = 1 )
BEGIN
	EXEC GetStatFileMessageEventSelect @ExportFileID, @OrganizationID, 1
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
			LogEventID, 
			@ExportFileID, 
			1 -- Enabled
		FROM	
			dbo.fn_GetLogEventIDList (@StartDateTime, @EndDateTime, @Created, @Modified	) fnEventList
		WHERE fnEventList.LogEventID IN ( SELECT le.LogEventID FROM LogEvent le 
										JOIN Message m ON m.CallID = le.CallID
											WHERE
												m.OrganizationID IN (
																	SELECT     OrgHierarchyParentID
																	FROM         WebReportGroup
																	WHERE     (WebReportGroupID = @WebReportGroupID ))										
										)

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

	-- Step 4:
		EXEC GetStatFileMessageEventSelect @ExportFileID, @OrganizationID, @Created

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
-- Run the 	GetStatFileMessageEventSelect if @SeperateFiles = 0 and @DateTypeID = 0 (CreateDate)
if(@SeperateFiles = 0 AND @DateTypeID = 0 )
BEGIN
	EXEC GetStatFileMessageEventSelect @ExportFileID, @OrganizationID, 0
END

GO
