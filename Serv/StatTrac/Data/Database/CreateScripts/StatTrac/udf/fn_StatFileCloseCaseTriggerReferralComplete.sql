  SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'[dbo].[fn_StatFileCloseCaseTriggerReferralComplete]') and xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[fn_StatFileCloseCaseTriggerReferralComplete]'
	DROP FUNCTION [dbo].[fn_StatFileCloseCaseTriggerReferralComplete]
END
	PRINT 'CREATE FUNCTION dbo.fn_StatFileCloseCaseTriggerReferralComplete'
GO
CREATE FUNCTION dbo.fn_StatFileCloseCaseTriggerReferralComplete
	(
		@ExportFileID int,
		@Opened bit
	)
RETURNS @CallIDTable TABLE
	(
		CallID int
	) 		
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_StatFileCloseCaseTriggerReferralComplete
**		Desc: 
**
**		This function provides a list of CallIDs based on the provided paremeters.
** 
**      StatFile
**		GetStatFileReferral      
**
**		Auth: Bret Knoll
**		Date: 03/01/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3/01/2009	Bret Knoll			initial
*******************************************************************************/
BEGIN
	-- find open cases in the ExporFileQueue
	IF(@Opened = 1)
	BEGIN
		INSERT 
			@CallIDTable
		SELECT CallID 
		FROM ExportFileQueue 
		WHERE 
			ExportFileID =  @ExportFileID	
		AND	
			CallID IN 
			(
			SELECT     CallID
			FROM         Call
			WHERE     
				(
					--either CallTemp is 1
					CallTemp <> 0
					and
					CallTempExclusive <> 0)
					-- or the call is new and call temp and exclusive have not been set
					or
					(
					CallTemp = 0
					and
					CallTempExclusive = 0
					and
					CallOpenByID <> -1
					and 
					CallTempSavedByID = -1
				)	
			)
			
	END
	-- find open cases in the CloseCaseQueue
	ELSE
	BEGIN
		INSERT 
			@CallIDTable
		SELECT CallID 
		FROM CloseCaseQueue 
		WHERE 
			ExportFileID = @ExportFileID	
		AND	
			CallID IN 
			(
			SELECT     CallID
			FROM         Call
			WHERE     (CallTemp = 0)	
			)
			
	END
	
	RETURN
END
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

