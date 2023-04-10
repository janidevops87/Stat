IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorLocation]
	PRINT 'Dropping Procedure: DeleteQAErrorLocation'
END
	PRINT 'Creating Procedure: DeleteQAErrorLocation'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorLocation]
(
	@QAErrorLocationID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAErrorLocation.sql
**		Name: DeleteQAErrorLocation
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

	UPDATE
			[QAErrorLocation]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAErrorLocationID] = @QAErrorLocationID

	DELETE 
	FROM   [QAErrorLocation]
	WHERE  
		[QAErrorLocationID] = @QAErrorLocationID

	RETURN @@Error
GO
