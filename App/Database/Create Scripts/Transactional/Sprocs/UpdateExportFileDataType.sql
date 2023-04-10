IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateExportFileDataType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateExportFileDataType]
	PRINT 'Dropping Procedure: UpdateExportFileDataType'
END
	PRINT 'Creating Procedure: UpdateExportFileDataType'
GO

CREATE PROCEDURE [dbo].[UpdateExportFileDataType]
(
	@ExportFileDataTypeID int,
	@ExportFileDataTypeName nvarchar(100) = NULL,
	@ExportFileDataTypeAbbreviation varchar(10) = NULL
)
/******************************************************************************
**		File: UpdateExportFileDataType.sql
**		Name: UpdateExportFileDataType
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
	
	UPDATE [ExportFileDataType]
	SET
		[ExportFileDataTypeName] = IsNull(@ExportFileDataTypeName, ExportFileDataTypeName),
		[ExportFileDataTypeAbbreviation] = IsNull(@ExportFileDataTypeAbbreviation, ExportFileDataTypeAbbreviation)
	WHERE 
		[ExportFileDataTypeID] = @ExportFileDataTypeID

	RETURN @@Error
GO