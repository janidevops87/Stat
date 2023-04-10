IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertExportFile]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertExportFile]
			PRINT 'Dropping Procedure: InsertExportFile'
	END

PRINT 'Creating Procedure: InsertExportFile'
GO

CREATE PROCEDURE [dbo].[InsertExportFile]
(
	@ExportFileID int = NULL OUTPUT,
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
**		File: InsertExportFile.sql
**		Name: InsertExportFile
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

	INSERT INTO [ExportFile]
	(
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
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@WebReportGroupID,
		@ExportFileDirectoryPath,
		@ExportFileRecurringDateType,
		@ExportFileLastRefresh,
		@ExportFileOn,
		@ExportFileTypeID,
		GETDATE(),
		@ExportFileFromDate,
		@ExportFileToDate,
		@ExportFileName,
		@ExportFileFrequency,
		@ExportFileDateType,
		@ExportFileOccursAt,
		@ExportFileFileDateType,
		@ExportFileSeparateFiles,
		@ExportFileTZ,
		@UpdatedFlag,
		@CloseCaseTriggerID,
		@CloseCaseOverride,
		@ExportFileFrequencyQuantity,
		@LastStatEmployeeID,
		1-- @AuditLogTypeID
	)

	SELECT @ExportFileID = SCOPE_IDENTITY();

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
		[ExportFileID] = IsNull(@ExportFileID, ExportFileID)

	RETURN @@Error
GO
