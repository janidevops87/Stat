 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetCloseCaseTrigger]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetCloseCaseTrigger]
	PRINT 'Dropping Procedure: GetCloseCaseTrigger'
END
	PRINT 'Creating Procedure: GetCloseCaseTrigger'
GO

CREATE PROCEDURE [dbo].[GetCloseCaseTrigger]
(
	@CloseCaseTriggerID int = NULL
)
/******************************************************************************
**		File: GetCloseCaseTrigger.sql
**		Name: GetCloseCaseTrigger
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[CloseCaseTriggerID],
		[CloseCaseTriggerName]
	
	FROM
			[CloseCaseTrigger]
	WHERE 
		[CloseCaseTriggerID] = IsNull(@CloseCaseTriggerID, CloseCaseTriggerID)


	RETURN @@Error
GO
