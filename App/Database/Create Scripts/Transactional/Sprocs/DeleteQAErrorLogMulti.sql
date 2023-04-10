IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorLogMulti]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorLogMulti]
	PRINT 'Dropping Procedure: DeleteQAErrorLogMulti'
END
	PRINT 'Creating Procedure: DeleteQAErrorLogMulti'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorLogMulti]
(
	@LastStatEmployeeID int,
	@QAErrorLocationID int,
	@QAErrorLogPersonID int
)
/******************************************************************************
**		File: DeleteQAErrorLogMulti.sql
**		Name: DeleteQAErrorLogMulti
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**      03/09       jth         needs to delete by employeeid and locationid
**      1/10        jth         change to use new field qaerrorlogpersonid
**		4/2010		bret		fixed param Name
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[QAErrorLog]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE  
		[QAErrorLogPersonID] = @QAErrorLogPersonID and
		[QAErrorLocationID] = @QAErrorLocationID

	DELETE 
	FROM   [QAErrorLog]
	WHERE  
		[StatEmployeeID] = @LastStatEmployeeID and
		[QAErrorLocationID] = @QAErrorLocationID

	RETURN @@Error
GO 