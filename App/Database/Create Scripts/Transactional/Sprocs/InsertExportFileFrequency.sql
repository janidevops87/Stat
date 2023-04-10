IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertExportFileFrequency]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertExportFileFrequency]
			PRINT 'Dropping Procedure: InsertExportFileFrequency'
	END

PRINT 'Creating Procedure: InsertExportFileFrequency'
GO

CREATE PROCEDURE [dbo].[InsertExportFileFrequency]
(
	@ExportFileFrequencyID int = NULL OUTPUT,
	@ExportFileFrequencyName nvarchar(50) = NULL
)
/******************************************************************************
**		File: InsertExportFileFrequency.sql
**		Name: InsertExportFileFrequency
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

	INSERT INTO [ExportFileFrequency]
	(
		[ExportFileFrequencyName]
	)
	VALUES
	(
		@ExportFileFrequencyName
	)

	SELECT @ExportFileFrequencyID = SCOPE_IDENTITY();

	SELECT
		[ExportFileFrequencyID],
		[ExportFileFrequencyName]
	
	FROM
			[ExportFileFrequency]
	WHERE 
		[ExportFileFrequencyID] = IsNull(@ExportFileFrequencyID, ExportFileFrequencyID)

	RETURN @@Error
GO