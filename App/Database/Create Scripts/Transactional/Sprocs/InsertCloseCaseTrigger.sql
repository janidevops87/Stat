IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertCloseCaseTrigger]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertCloseCaseTrigger]
			PRINT 'Dropping Procedure: InsertCloseCaseTrigger'
	END

PRINT 'Creating Procedure: InsertCloseCaseTrigger'
GO

CREATE PROCEDURE [dbo].[InsertCloseCaseTrigger]
(
	@CloseCaseTriggerID int = NULL OUTPUT,
	@CloseCaseTriggerName nvarchar(100) = NULL
)
/******************************************************************************
**		File: InsertCloseCaseTrigger.sql
**		Name: InsertCloseCaseTrigger
**		Desc:  Used on StatFile
**
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	Bret Knoll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [CloseCaseTrigger]
	(
		[CloseCaseTriggerName]
	)
	VALUES
	(
		@CloseCaseTriggerName
	)

	SELECT @CloseCaseTriggerID = SCOPE_IDENTITY();

	SELECT
		[CloseCaseTriggerID],
		[CloseCaseTriggerName]
	
	FROM
			[CloseCaseTrigger]
	WHERE 
		[CloseCaseTriggerID] = IsNull(@CloseCaseTriggerID, CloseCaseTriggerID)

	RETURN @@Error
GO