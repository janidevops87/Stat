IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetCloseCaseQueue]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetCloseCaseQueue]
	PRINT 'Dropping Procedure: GetCloseCaseQueue'
END
	PRINT 'Creating Procedure: GetCloseCaseQueue'
GO

CREATE PROCEDURE [dbo].[GetCloseCaseQueue]
(
	@CloseCaseQueueID int = NULL,
	@LastModified datetime = NULL
)
/******************************************************************************
**		File: GetCloseCaseQueue.sql
**		Name: GetCloseCaseQueue
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
		[CloseCaseQueueID],
		[CallID],
		[LastModified]
	
	FROM
			[CloseCaseQueue]
	WHERE 
		[CloseCaseQueueID] = IsNull(@CloseCaseQueueID, CloseCaseQueueID)
	OR
		(
			@LastModified IS NOT NULL
			AND
			LastModified < @LastModified
		)


	RETURN @@Error
GO
