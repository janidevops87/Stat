 SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'[dbo].[fn_StatFileCloseCaseTrigger]') and xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[fn_StatFileCloseCaseTrigger]'
	DROP FUNCTION [dbo].[fn_StatFileCloseCaseTrigger]
END
	PRINT 'CREATE FUNCTION dbo.fn_StatFileCloseCaseTrigger'
GO

CREATE FUNCTION dbo.fn_StatFileCloseCaseTrigger
	(
	@CloseCaseTriggerID int,
	@ExportFileID int
	)
RETURNS @CallIDTable TABLE
	(
		CallID int
	) 		
AS
/******************************************************************************
**		File: 
**		Name: dbo.fn_StatFileCloseCaseTrigger
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
	DECLARE 
		@Opened bit
		,@CloseCaseTriggerReferralComplete int
		,@CloseCaseTriggerRegistryComplete int

	SET @Opened = 1
	SET @CloseCaseTriggerReferralComplete = 1
	SET @CloseCaseTriggerRegistryComplete = 2

	IF(@CloseCaseTriggerID = @CloseCaseTriggerReferralComplete)
	BEGIN
		
		INSERT 
			@CallIDTable
		SELECT CallID FROM dbo.fn_StatFileCloseCaseTriggerReferralComplete(@ExportFileID, @Opened)
	
	END
	ELSE IF(@CloseCaseTriggerID = @CloseCaseTriggerRegistryComplete)
	BEGIN
		
		INSERT 
			@CallIDTable
		SELECT CallID FROM dbo.fn_StatFileCloseCaseTriggerRegistryComplete(@ExportFileID, @Opened)
	
	END
		
	RETURN
END
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

