IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFileType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFileType]
	PRINT 'Dropping Procedure: GetExportFileType'
END
	PRINT 'Creating Procedure: GetExportFileType'
GO

CREATE PROCEDURE [dbo].[GetExportFileType]
(
	@ExportFileTypeID int = NULL
)
/******************************************************************************
**		File: GetExportFileType.sql
**		Name: GetExportFileType
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
		[ExportFileTypeID],
		[ExportFileTypeName],
		[LastModified],
		[UpdatedFlag],
		[ExportFileXsltID],
		[Enabled],
		[ExportFileDataTypeID]
	
	FROM
			[ExportFileType]
	WHERE 
		[ExportFileTypeID] = IsNull(@ExportFileTypeID, ExportFileTypeID)


	RETURN @@Error
GO

