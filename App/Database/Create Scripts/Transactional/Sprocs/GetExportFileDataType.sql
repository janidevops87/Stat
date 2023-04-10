IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFileDataType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFileDataType]
	PRINT 'Dropping Procedure: GetExportFileDataType'
END
	PRINT 'Creating Procedure: GetExportFileDataType'
GO

CREATE PROCEDURE [dbo].[GetExportFileDataType]
(
	@ExportFileDataTypeID int = NULL
)
/******************************************************************************
**		File: GetExportFileDataType.sql
**		Name: GetExportFileDataType
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
		[ExportFileDataTypeID],
		[ExportFileDataTypeName],
		[ExportFileDataTypeAbbreviation]
	
	FROM
		[ExportFileDataType]
	WHERE 
		[ExportFileDataTypeID] = IsNull(@ExportFileDataTypeID, ExportFileDataTypeID)


	RETURN @@Error
GO
