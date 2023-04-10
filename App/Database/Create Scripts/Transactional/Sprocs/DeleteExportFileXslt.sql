IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteExportFileXslt]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteExportFileXslt]
	PRINT 'Dropping Procedure: DeleteExportFileXslt'
END
	PRINT 'Creating Procedure: DeleteExportFileXslt'
GO

CREATE PROCEDURE [dbo].[DeleteExportFileXslt]
(
	@ExportFileXsltID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteExportFileXslt.sql
**		Name: DeleteExportFileXslt
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
	FROM   [ExportFileXslt]
	WHERE  
		[ExportFileXsltID] = @ExportFileXsltID

	RETURN @@Error
GO
