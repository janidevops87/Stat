/******************************************************************************
**	File: ExportFile.sql
**	Name: ExportFile
**	Desc: Table Constraint for ExportFile
**	Auth: Bret Knoll
**	Date: 2/25/09
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	02/25/09	Bret Knoll		Initial Table Constraint
*******************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K'
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'ExportFile'))
BEGIN
	ALTER TABLE dbo.ExportFile ADD 
		CONSTRAINT PK_ExportFile Primary KEY CLUSTERED (ExportFileID) ON [Primary]
END


 PRINT 'Drop All Default Constraints from ExportFile'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'ExportFile')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE ExportFile DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'ExportFile')
END


IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ExportFile_CloseCaseTriggerID')
BEGIN
	PRINT 'Creating Default Constraint DF_ExportFile_CloseCaseTriggerID'
	ALTER TABLE dbo.ExportFile ADD CONSTRAINT
		DF_ExportFile_CloseCaseTriggerID DEFAULT((0)) FOR CloseCaseTriggerID
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ExportFile_CloseCaseOverride')
BEGIN
	PRINT 'Creating Default Constraint DF_ExportFile_CloseCaseOverride'
	ALTER TABLE dbo.ExportFile ADD CONSTRAINT
		DF_ExportFile_CloseCaseOverride DEFAULT((0)) FOR CloseCaseOverride
END

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ExportFile_ExportFileFrequencyQuantity')
BEGIN
	PRINT 'Creating Default Constraint DF_ExportFile_ExportFileFrequencyQuantity'
	ALTER TABLE dbo.ExportFile ADD CONSTRAINT
		DF_ExportFile_ExportFileFrequencyQuantity DEFAULT((1)) FOR ExportFileFrequencyQuantity
END
