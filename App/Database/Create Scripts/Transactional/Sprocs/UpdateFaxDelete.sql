 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateFaxDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateFaxDelete]
	PRINT 'Dropping Procedure: UpdateFaxDelete'
END
	PRINT 'Creating Procedure: UpdateFaxDelete'
GO

CREATE PROCEDURE [dbo].[UpdateFaxDelete]
(
	@jobID varchar(50)
)
/******************************************************************************
**		File: UpdateFaxDelete.sql
**		Name: UpdateFaxDelete
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
**		09/2009		jth			initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [FaxQueue]
	SET
		[FaxQueueDeleteDate] = GetDate()
		
	WHERE 
		[FaxQueueJobID] = @jobID

	RETURN @@Error
GO
