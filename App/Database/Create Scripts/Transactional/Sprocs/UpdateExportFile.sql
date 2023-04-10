IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateExportFile]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateExportFile]
	PRINT 'Dropping Procedure: UpdateExportFile'
END
	PRINT 'Creating Procedure: UpdateExportFile'
GO

CREATE PROCEDURE [dbo].[UpdateExportFile]
(
	@ExportFileID int,
	@OrganizationID int = NULL,
	@WebReportGroupID int = NULL,
	@ExportFileDirectoryPath varchar(255) = NULL,
	@ExportFileRecurringDateType int = NULL,
	@ExportFileLastRefresh datetime = NULL,
	@ExportFileOn tinyint = NULL,
	@ExportFileTypeID smallint = NULL,
	@LastModified datetime = NULL,
	@ExportFileFromDate datetime = NULL,
	@ExportFileToDate datetime = NULL,
	@ExportFileName varchar(30) = NULL,
	@ExportFileFrequency smallint = NULL,
	@ExportFileDateType smallint = NULL,
	@ExportFileOccursAt varchar(255) = NULL,
	@ExportFileFileDateType smallint = NULL,
	@ExportFileSeparateFiles smallint = NULL,
	@ExportFileTZ varchar(2) = NULL,
	@UpdatedFlag smallint = NULL,
	@CloseCaseTriggerID int = NULL,
	@CloseCaseOverride int = NULL,
	@ExportFileFrequencyQuantity int = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateExportFile.sql
**		Name: UpdateExportFile
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
	
	UPDATE [ExportFile]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[WebReportGroupID] = IsNull(@WebReportGroupID, WebReportGroupID),
		[ExportFileDirectoryPath] = IsNull(@ExportFileDirectoryPath, ExportFileDirectoryPath),
		[ExportFileRecurringDateType] = IsNull(@ExportFileRecurringDateType, ExportFileRecurringDateType),
		[ExportFileLastRefresh] = IsNull(@ExportFileLastRefresh, ExportFileLastRefresh),
		[ExportFileOn] = IsNull(@ExportFileOn, ExportFileOn),
		[ExportFileTypeID] = IsNull(@ExportFileTypeID, ExportFileTypeID),
		[LastModified] = GetDate(),
		[ExportFileFromDate] = IsNull(@ExportFileFromDate, ExportFileFromDate),
		[ExportFileToDate] = IsNull(@ExportFileToDate, ExportFileToDate),
		[ExportFileName] = IsNull(@ExportFileName, ExportFileName),
		[ExportFileFrequency] = IsNull(@ExportFileFrequency, ExportFileFrequency),
		[ExportFileDateType] = IsNull(@ExportFileDateType, ExportFileDateType),
		[ExportFileOccursAt] = IsNull(@ExportFileOccursAt, ExportFileOccursAt),
		[ExportFileFileDateType] = IsNull(@ExportFileFileDateType, ExportFileFileDateType),
		[ExportFileSeparateFiles] = IsNull(@ExportFileSeparateFiles, ExportFileSeparateFiles),
		[ExportFileTZ] = IsNull(@ExportFileTZ, ExportFileTZ),
		[UpdatedFlag] = IsNull(@UpdatedFlag, UpdatedFlag),
		[CloseCaseTriggerID] = IsNull(@CloseCaseTriggerID, CloseCaseTriggerID),
		[CloseCaseOverride] = IsNull(@CloseCaseOverride, CloseCaseOverride),
		[ExportFileFrequencyQuantity] = IsNull(@ExportFileFrequencyQuantity, ExportFileFrequencyQuantity),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --IsNull(@AuditLogTypeID, AuditLogTypeID)
	WHERE 
		[ExportFileID] = @ExportFileID

	RETURN @@Error
GO
