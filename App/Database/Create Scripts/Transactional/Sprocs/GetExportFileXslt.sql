IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFileXslt]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFileXslt]
	PRINT 'Dropping Procedure: GetExportFileXslt'
END
	PRINT 'Creating Procedure: GetExportFileXslt'
GO

CREATE PROCEDURE [dbo].[GetExportFileXslt]
(
	@ExportFileXsltID int = NULL
)
/******************************************************************************
**		File: GetExportFileXslt.sql
**		Name: GetExportFileXslt
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[ExportFileXsltID],
		[ExportFileXsltName]
	
	FROM
			[ExportFileXslt]
	WHERE 
		[ExportFileXsltID] = IsNull(@ExportFileXsltID, ExportFileXsltID)


	RETURN @@Error
GO

