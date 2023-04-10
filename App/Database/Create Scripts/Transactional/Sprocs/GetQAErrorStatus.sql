IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorStatus]
	PRINT 'Dropping Procedure: GetQAErrorStatus'
END
	PRINT 'Creating Procedure: GetQAErrorStatus'
GO

CREATE PROCEDURE [dbo].[GetQAErrorStatus]
(
	@QAErrorStatusID int = NULL
)
/******************************************************************************
**		File: GetQAErrorStatus.sql
**		Name: GetQAErrorStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              **
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QAErrorStatusID],
		[QAErrorStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QAErrorStatus]
	WHERE 
		[QAErrorStatusID] = IsNull(@QAErrorStatusID, QAErrorStatusID)


	RETURN @@Error
GO


