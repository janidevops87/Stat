 SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[fn_StatFileCloseCaseTriggerRegistryComplete]') and xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[fn_StatFileCloseCaseTriggerRegistryComplete]'
	DROP FUNCTION [dbo].[fn_StatFileCloseCaseTriggerRegistryComplete]
END 

	PRINT 'CREATE FUNCTION dbo.fn_StatFileCloseCaseTriggerRegistryComplete'	
GO


CREATE FUNCTION dbo.fn_StatFileCloseCaseTriggerRegistryComplete
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
**		Name: dbo.fn_StatFileCloseCaseTriggerRegistryComplete
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
**		3/02/2009	Bret Knoll			initial
*******************************************************************************/
BEGIN
	-- find open cases in the ExporFileQueue
	IF(@Opened = 1)
	BEGIN
		INSERT 
			@CallIDTable
		SELECT CallID 
		FROM ExportFileQueue 
		WHERE ExportFileID = @ExportFileID
		AND CallID NOT IN
		(
		SELECT 
			CallID
		FROM 
			LogEvent 
		WHERE 
			LogEventTypeID =  1 
		AND 
			LogEventName = 'Donor Registry'
		AND 
			LogEventDeleted = 0		
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
			SELECT 
				CallID
			FROM 
				LogEvent 
			WHERE 
				LogEventTypeID =  1 
			AND 
				LogEventName = 'Donor Registry'
			AND 
				LogEventDeleted = 0		
			)
	END

	RETURN
END
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 