IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAErrorLogHowIdentified]
	PRINT 'Dropping Procedure: UpdateQAErrorLogHowIdentified'
END
	PRINT 'Creating Procedure: UpdateQAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[UpdateQAErrorLogHowIdentified]
(
	@QAErrorLogHowIdentifiedID int,
	@QAErrorLogHowIdentifiedDescription int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAErrorLogHowIdentified.sql
**		Name: UpdateQAErrorLogHowIdentified
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/22/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/22/2009	ccarroll	initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QAErrorLogHowIdentified]
	SET
		[QAErrorLogHowIdentifiedDescription] = IsNull(@QAErrorLogHowIdentifiedDescription, QAErrorLogHowIdentifiedDescription),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAErrorLogHowIdentifiedID] = @QAErrorLogHowIdentifiedID

	RETURN @@Error
GO
