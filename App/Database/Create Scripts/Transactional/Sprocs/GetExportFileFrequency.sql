IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFileFrequency]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFileFrequency]
	PRINT 'Dropping Procedure: GetExportFileFrequency'
END
	PRINT 'Creating Procedure: GetExportFileFrequency'
GO

CREATE PROCEDURE [dbo].[GetExportFileFrequency]
(
	@ExportFileFrequencyID int = NULL
)
/******************************************************************************
**		File: GetExportFileFrequency.sql
**		Name: GetExportFileFrequency
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
		[ExportFileFrequencyID],
		[ExportFileFrequencyName]
	
	FROM
			[ExportFileFrequency]
	WHERE 
		[ExportFileFrequencyID] = IsNull(@ExportFileFrequencyID, ExportFileFrequencyID)


	RETURN @@Error
GO

