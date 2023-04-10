IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertExportFileDataType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertExportFileDataType]
			PRINT 'Dropping Procedure: InsertExportFileDataType'
	END

PRINT 'Creating Procedure: InsertExportFileDataType'
GO

CREATE PROCEDURE [dbo].[InsertExportFileDataType]
(
	@ExportFileDataTypeID int = NULL OUTPUT,
	@ExportFileDataTypeName nvarchar(100) = NULL,
	@ExportFileDataTypeAbbreviation varchar(10) = NULL
)
/******************************************************************************
**		File: InsertExportFileDataType.sql
**		Name: InsertExportFileDataType
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

	INSERT INTO [ExportFileDataType]
	(
		[ExportFileDataTypeName],
		[ExportFileDataTypeAbbreviation]
	)
	VALUES
	(
		@ExportFileDataTypeName,
		@ExportFileDataTypeAbbreviation
	)

	SELECT @ExportFileDataTypeID = SCOPE_IDENTITY();

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
