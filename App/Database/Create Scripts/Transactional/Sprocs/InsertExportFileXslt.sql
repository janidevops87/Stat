IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertExportFileXslt]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertExportFileXslt]
			PRINT 'Dropping Procedure: InsertExportFileXslt'
	END

PRINT 'Creating Procedure: InsertExportFileXslt'
GO

CREATE PROCEDURE [dbo].[InsertExportFileXslt]
(
	@ExportFileXsltID int = NULL OUTPUT,
	@ExportFileXsltName nvarchar(100) = NULL
)
/******************************************************************************
**		File: InsertExportFileXslt.sql
**		Name: InsertExportFileXslt
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

	INSERT INTO [ExportFileXslt]
	(
		[ExportFileXsltName]
	)
	VALUES
	(
		@ExportFileXsltName
	)

	SELECT @ExportFileXsltID = SCOPE_IDENTITY();

	SELECT
		[ExportFileXsltID],
		[ExportFileXsltName]
	
	FROM
			[ExportFileXslt]
	WHERE 
		[ExportFileXsltID] = IsNull(@ExportFileXsltID, ExportFileXsltID)

	RETURN @@Error
GO