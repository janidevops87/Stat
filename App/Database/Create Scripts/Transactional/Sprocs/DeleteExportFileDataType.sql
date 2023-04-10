IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteExportFileDataType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteExportFileDataType]
	PRINT 'Dropping Procedure: DeleteExportFileDataType'
END
	PRINT 'Creating Procedure: DeleteExportFileDataType'
GO

CREATE PROCEDURE [dbo].[DeleteExportFileDataType]
(
	@ExportFileDataTypeID int
)
/******************************************************************************
**		File: DeleteExportFileDataType.sql
**		Name: DeleteExportFileDataType
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
	FROM   [ExportFileDataType]
	WHERE  
		[ExportFileDataTypeID] = @ExportFileDataTypeID

	RETURN @@Error
GO