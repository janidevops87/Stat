IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertExportFileType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertExportFileType]
			PRINT 'Dropping Procedure: InsertExportFileType'
	END

PRINT 'Creating Procedure: InsertExportFileType'
GO

CREATE PROCEDURE [dbo].[InsertExportFileType]
(
	@ExportFileTypeID int = NULL OUTPUT,
	@ExportFileTypeName varchar(30) = NULL,
	@LastModified smalldatetime = NULL,
	@UpdatedFlag smallint = NULL,
	@ExportFileXsltID int = NULL,
	@Enabled bit = NULL,
	@ExportFileDataTypeID int = NULL
)
/******************************************************************************
**		File: InsertExportFileType.sql
**		Name: InsertExportFileType
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

	INSERT INTO [ExportFileType]
	(
		[ExportFileTypeName],
		[LastModified],
		[UpdatedFlag],
		[ExportFileXsltID],
		[Enabled],
		[ExportFileDataTypeID]
	)
	VALUES
	(
		@ExportFileTypeName,
		@LastModified,
		@UpdatedFlag,
		@ExportFileXsltID,
		@Enabled,
		@ExportFileDataTypeID
	)

	SELECT @ExportFileTypeID = SCOPE_IDENTITY();

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