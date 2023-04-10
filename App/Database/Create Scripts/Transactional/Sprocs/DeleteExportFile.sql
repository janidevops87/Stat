IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteExportFile]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteExportFile]
	PRINT 'Dropping Procedure: DeleteExportFile'
END
	PRINT 'Creating Procedure: DeleteExportFile'
GO

CREATE PROCEDURE [dbo].[DeleteExportFile]
(
	@ExportFileID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteExportFile.sql
**		Name: DeleteExportFile
**		Desc:  Used on StatFile
**
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	Bret Knoll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[ExportFile]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[ExportFileID] = @ExportFileID

	DELETE 
	FROM   [ExportFile]
	WHERE  
		[ExportFileID] = @ExportFileID

	RETURN @@Error
GO