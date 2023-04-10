IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteIDologyLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteIDologyLog]
	PRINT 'Dropping Procedure: DeleteIDologyLog'
END
	PRINT 'Creating Procedure: DeleteIDologyLog'
GO

CREATE PROCEDURE [dbo].[DeleteIDologyLog]
(
	@IDologyLogID int,
	@RegistryID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteIDologyLog.sql
**		Name: DeleteIDologyLog
**		Desc: 
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
	
	UPDATE
			[IDologyLog]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE
	 		[RegistryID] = @RegistryID AND
	 		[IDologyLogID] = IsNull(@IDologyLogID, IDologyLogID)


	DELETE 
	FROM   [IDologyLog]
	WHERE  
	 		[RegistryID] = @RegistryID AND
	 		[IDologyLogID] = IsNull(@IDologyLogID, IDologyLogID)

	RETURN @@Error
GO