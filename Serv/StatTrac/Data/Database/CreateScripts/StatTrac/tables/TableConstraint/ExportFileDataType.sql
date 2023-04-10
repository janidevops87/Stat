  /******************************************************************************
**	File: ExportFileDataType.sql
**	Name: ExportFileDataType
**	Desc: Table Constraint for ExportFileDataType
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
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'ExportFileDataType'))
BEGIN
	ALTER TABLE dbo.ExportFileDataType ADD 
		CONSTRAINT PK_ExportFileDataType Primary KEY CLUSTERED (ExportFileDataTypeID) ON [Primary]
END

PRINT 'Drop All Default Constraints from ExportFileDataType'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'ExportFileDataType')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE ExportFileDataType DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'ExportFileDataType')
END
