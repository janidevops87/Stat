 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingStatus]
	PRINT 'Dropping Procedure: GetQATrackingStatus'
END
	PRINT 'Creating Procedure: GetQATrackingStatus'
GO

CREATE PROCEDURE [dbo].[GetQATrackingStatus]
(
	@QATrackingStatusID int = NULL
)
/******************************************************************************
**		File: GetQATrackingStatus.sql
**		Name: GetQATrackingStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              **
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QATrackingStatusID],
		[QATrackingStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QATrackingStatus]
	WHERE 
		[QATrackingStatusID] = IsNull(@QATrackingStatusID, QATrackingStatusID)


	RETURN @@Error
GO


