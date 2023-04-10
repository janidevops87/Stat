 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateDocumentRequestQueue]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN 
	DROP PROCEDURE [dbo].[UpdateDocumentRequestQueue];
	PRINT 'Dropping Procedure: UpdateDocumentRequestQueue';
END
	PRINT 'Creating Procedure: UpdateDocumentRequestQueue'
GO

CREATE PROCEDURE [dbo].[UpdateDocumentRequestQueue]
(
	@documentRequestQueueID int,
	@jobID varchar(50)
)
/******************************************************************************
**		File: UpdateDocumentRequestQueue.sql
**		Name: UpdateDocumentRequestQueue
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
**		08/2019		pls			initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [DocumentRequestQueue]
	SET
		[SentDate] = GetDate(),
		[JobId] = @jobID
		
	WHERE 
		[DocumentRequestQueueID] = @documentRequestQueueID;

	RETURN @@Error;
GO
