IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQATrackingType]
	PRINT 'Dropping Procedure: DeleteQATrackingType'
END
	PRINT 'Creating Procedure: DeleteQATrackingType'
GO

CREATE PROCEDURE [dbo].[DeleteQATrackingType]
(
	@QATrackingTypeID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQATrackingType.sql
**		Name: DeleteQATrackingType
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
			[QATrackingType]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QATrackingTypeID] = @QATrackingTypeID

	DELETE 
	FROM   [QATrackingType]
	WHERE  
		[QATrackingTypeID] = @QATrackingTypeID

	RETURN @@Error
GO

