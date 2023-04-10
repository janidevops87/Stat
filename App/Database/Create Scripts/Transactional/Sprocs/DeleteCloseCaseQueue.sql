IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteCloseCaseQueue]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteCloseCaseQueue]
	PRINT 'Dropping Procedure: DeleteCloseCaseQueue'
END
	PRINT 'Creating Procedure: DeleteCloseCaseQueue'
GO

CREATE PROCEDURE [dbo].[DeleteCloseCaseQueue]
(
	@CloseCaseQueueID int = NULL,
	@CallID int = NULL,
	@ExportFileID int = NULL
)
/******************************************************************************
**		File: DeleteCloseCaseQueue.sql
**		Name: DeleteCloseCaseQueue
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

	DELETE 
	FROM   [CloseCaseQueue]
	WHERE  
	(
		[CloseCaseQueueID] = ISNULL(@CloseCaseQueueID, CloseCaseQueueID)
	OR 
		[CallID] = ISNULL(@CallID, CallID)
	OR  
		ExportFileID = ISNULL(@ExportFileID, ExportFileID) 
	)
	AND
		Enabled = 0

	RETURN @@Error
GO
