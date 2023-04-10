IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateExportFileType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateExportFileType]
	PRINT 'Dropping Procedure: UpdateExportFileType'
END
	PRINT 'Creating Procedure: UpdateExportFileType'
GO

CREATE PROCEDURE [dbo].[UpdateExportFileType]
(
	@ExportFileTypeID int,
	@ExportFileTypeName varchar(30) = NULL,
	@LastModified smalldatetime = NULL,
	@UpdatedFlag smallint = NULL,
	@ExportFileXsltID int = NULL,
	@Enabled bit = NULL,
	@ExportFileDataTypeID int = NULL
)
/******************************************************************************
**		File: UpdateExportFileType.sql
**		Name: UpdateExportFileType
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
	
	UPDATE [ExportFileType]
	SET
		[ExportFileTypeName] = IsNull(@ExportFileTypeName, ExportFileTypeName),
		[LastModified] = IsNull(@LastModified, LastModified),
		[UpdatedFlag] = IsNull(@UpdatedFlag, UpdatedFlag),
		[ExportFileXsltID] = IsNull(@ExportFileXsltID, ExportFileXsltID),
		[Enabled] = IsNull(@Enabled, Enabled),
		[ExportFileDataTypeID] = IsNull(@ExportFileDataTypeID, ExportFileDataTypeID)
	WHERE 
		[ExportFileTypeID] = @ExportFileTypeID

	RETURN @@Error
GO

