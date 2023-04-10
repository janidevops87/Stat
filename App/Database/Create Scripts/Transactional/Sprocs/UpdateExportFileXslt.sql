IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateExportFileXslt]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateExportFileXslt]
	PRINT 'Dropping Procedure: UpdateExportFileXslt'
END
	PRINT 'Creating Procedure: UpdateExportFileXslt'
GO

CREATE PROCEDURE [dbo].[UpdateExportFileXslt]
(
	@ExportFileXsltID int,
	@ExportFileXsltName nvarchar(100) = NULL
)
/******************************************************************************
**		File: UpdateExportFileXslt.sql
**		Name: UpdateExportFileXslt
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
	
	UPDATE [ExportFileXslt]
	SET
		[ExportFileXsltName] = IsNull(@ExportFileXsltName, ExportFileXsltName)
	WHERE 
		[ExportFileXsltID] = @ExportFileXsltID

	RETURN @@Error
GO