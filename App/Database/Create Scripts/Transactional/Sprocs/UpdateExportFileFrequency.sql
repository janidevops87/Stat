IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateExportFileFrequency]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateExportFileFrequency]
	PRINT 'Dropping Procedure: UpdateExportFileFrequency'
END
	PRINT 'Creating Procedure: UpdateExportFileFrequency'
GO

CREATE PROCEDURE [dbo].[UpdateExportFileFrequency]
(
	@ExportFileFrequencyID int,
	@ExportFileFrequencyName nvarchar(50) = NULL
)
/******************************************************************************
**		File: UpdateExportFileFrequency.sql
**		Name: UpdateExportFileFrequency
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
	
	UPDATE [ExportFileFrequency]
	SET
		[ExportFileFrequencyName] = IsNull(@ExportFileFrequencyName, ExportFileFrequencyName)
	WHERE 
		[ExportFileFrequencyID] = @ExportFileFrequencyID

	RETURN @@Error
GO
