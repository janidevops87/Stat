IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteExportFileType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteExportFileType]
	PRINT 'Dropping Procedure: DeleteExportFileType'
END
	PRINT 'Creating Procedure: DeleteExportFileType'
GO

CREATE PROCEDURE [dbo].[DeleteExportFileType]
(
	@ExportFileTypeID int
)
/******************************************************************************
**		File: DeleteExportFileType.sql
**		Name: DeleteExportFileType
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

	DELETE 
	FROM   [ExportFileType]
	WHERE  
		[ExportFileTypeID] = @ExportFileTypeID

	RETURN @@Error
GO


