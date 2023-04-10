IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteExportFileFrequency]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteExportFileFrequency]
	PRINT 'Dropping Procedure: DeleteExportFileFrequency'
END
	PRINT 'Creating Procedure: DeleteExportFileFrequency'
GO

CREATE PROCEDURE [dbo].[DeleteExportFileFrequency]
(
	@ExportFileFrequencyID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteExportFileFrequency.sql
**		Name: DeleteExportFileFrequency
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
	FROM   [ExportFileFrequency]
	WHERE  
		[ExportFileFrequencyID] = @ExportFileFrequencyID

	RETURN @@Error
GO
