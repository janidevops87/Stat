IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAErrorStatus]
	PRINT 'Dropping Procedure: UpdateQAErrorStatus'
END
	PRINT 'Creating Procedure: UpdateQAErrorStatus'
GO

CREATE PROCEDURE [dbo].[UpdateQAErrorStatus]
(
	@QAErrorStatusID int,
	@QAErrorStatusDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAErrorStatus.sql
**		Name: UpdateQAErrorStatus
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
	
	UPDATE [QAErrorStatus]
	SET
		[QAErrorStatusDescription] = IsNull(@QAErrorStatusDescription, QAErrorStatusDescription),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[QAErrorStatusID] = @QAErrorStatusID

	RETURN @@Error
GO
