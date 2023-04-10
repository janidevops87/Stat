 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateDocumentRequestQueueDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN 
	DROP PROCEDURE [dbo].[UpdateDocumentRequestQueueDelete];
	PRINT 'Dropping Procedure: UpdateDocumentRequestQueueDelete';
END
	PRINT 'Creating Procedure: UpdateDocumentRequestQueueDelete'
GO

CREATE PROCEDURE [dbo].[UpdateDocumentRequestQueueDelete]
(
	@jobID varchar(50)
)
/******************************************************************************
**		File: UpdateDocumentRequestQueueDelete.sql
**		Name: UpdateDocumentRequestQueueDelete
**
**		Called by:  
**              
**
**		Auth: pls
**		Date: 08/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		09/2019		pls			initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [DocumentRequestQueue]
	SET
		[DeleteDate] = GetDate()
		
	WHERE 
		[JobID] = @jobID;

	RETURN @@Error;
GO
