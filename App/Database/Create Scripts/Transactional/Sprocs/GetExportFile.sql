IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFile]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFile]
	PRINT 'Dropping Procedure: GetExportFile'
END
	PRINT 'Creating Procedure: GetExportFile'
GO

CREATE PROCEDURE [dbo].[GetExportFile]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetExportFile.sql
**		Name: GetExportFile
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
		[ExportFileID],
		[OrganizationID],
		[WebReportGroupID],
		[ExportFileDirectoryPath],
		[ExportFileRecurringDateType],
		[ExportFileLastRefresh],
		[ExportFileOn],
		[ExportFileTypeID],
		[LastModified],
		[ExportFileFromDate],
		[ExportFileToDate],
		[ExportFileName],
		[ExportFileFrequency],
		[ExportFileDateType],
		[ExportFileOccursAt],
		[ExportFileFileDateType],
		[ExportFileSeparateFiles],
		[ExportFileTZ],
		[UpdatedFlag],
		[CloseCaseTriggerID],
		[CloseCaseOverride],
		[ExportFileFrequencyQuantity],
		[LastStatEmployeeID]
	
	FROM
		[ExportFile]
	WHERE
		( ISNULL(@ExportFileID, 0) > 0
		AND
		[ExportFileID] = @ExportFileID
		)
	OR (
		 ISNULL(@ExportFileID, 0) = 0
		AND		
		 ExportFileOn = 1 
		AND
		OrganizationID = ISNULL(@OrganizationID, OrganizationID)
		)
		


	RETURN @@Error
GO
