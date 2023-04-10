 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateFax]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateFax]
	PRINT 'Dropping Procedure: UpdateFax'
END
	PRINT 'Creating Procedure: UpdateFax'
GO

CREATE PROCEDURE [dbo].[UpdateFax]
(
	@faxQueueID int,
	@jobID varchar(50)
)
/******************************************************************************
**		File: UpdateFax.sql
**		Name: UpdateFax
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 08/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		08/2009		jth			initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [FaxQueue]
	SET
		[FaxQueueSentDate] = GetDate(),
		[FaxQueueJobId] = @jobID
		
	WHERE 
		[FaxQueueID] = @faxQueueID

	RETURN @@Error
GO
