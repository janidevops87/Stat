  /******************************************************************************
**	File: ExportFileFrequency.sql
**	Name: ExportFileFrequency
**	Desc: Table Constraint for ExportFileFrequency
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
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'ExportFileFrequency'))
BEGIN
	ALTER TABLE dbo.ExportFileFrequency ADD 
		CONSTRAINT PK_ExportFileFrequency Primary KEY CLUSTERED (ExportFileFrequencyID) ON [Primary]
END

PRINT 'Drop All Default Constraints from ExportFileFrequency'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'ExportFileFrequency')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE ExportFileFrequency DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'ExportFileFrequency')
END
