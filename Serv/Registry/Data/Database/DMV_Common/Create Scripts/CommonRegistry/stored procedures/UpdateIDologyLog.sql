IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateIDologyLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateIDologyLog]
	PRINT 'Dropping Procedure: UpdateIDologyLog'
END
	PRINT 'Creating Procedure: UpdateIDologyLog'
GO

CREATE PROCEDURE [dbo].[UpdateIDologyLog]
(
	@IDologyLogID int,
	@IDologyLogNumberID int =NULL, 
	@IDologyLogRequest nvarchar(2000) = NULL,
	@IDologyLogResponse nvarchar(2000) = NULL,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: UpdateIDologyLog.sql
**		Name: UpdateIDologyLog
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/02/2009	ccarroll	initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [IDologyLog]
	SET
		[IDologyLogNumberID] = IsNull(@IDologyLogNumberID, IDologyLogNumberID),
		[IDologyLogRequest] = IsNull(@IDologyLogRequest, IDologyLogRequest),
		[IDologyLogResponse] = IsNull(@IDologyLogResponse, IDologyLogResponse),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = @LastStatEmployeeID,
		[AuditLogTypeID] = 3 --Modify

	WHERE 
		[IDologyLogID] = @IDologyLogID

	RETURN @@Error
GO
