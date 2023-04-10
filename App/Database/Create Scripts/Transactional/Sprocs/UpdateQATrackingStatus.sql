 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQATrackingStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQATrackingStatus]
	PRINT 'Dropping Procedure: UpdateQATrackingStatus'
END
	PRINT 'Creating Procedure: UpdateQATrackingStatus'
GO

CREATE PROCEDURE [dbo].[UpdateQATrackingStatus]
(
	@QATrackingStatusID int,
	@QATrackingStatusDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQATrackingStatus.sql
**		Name: UpdateQATrackingStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QATrackingStatus]
	SET
		[QATrackingStatusDescription] = IsNull(@QATrackingStatusDescription, QATrackingStatusDescription),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[QATrackingStatusID] = @QATrackingStatusID

	RETURN @@Error
GO
