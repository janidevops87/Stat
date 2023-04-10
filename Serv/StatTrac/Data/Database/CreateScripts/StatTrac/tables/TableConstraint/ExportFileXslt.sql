  /******************************************************************************
**	File: ExportFileXslt.sql
**	Name: ExportFileXslt
**	Desc: Table Constraint for ExportFileXslt
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
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'ExportFileXslt'))
BEGIN
	ALTER TABLE dbo.ExportFileXslt ADD 
		CONSTRAINT PK_ExportFileXslt Primary KEY CLUSTERED (ExportFileXsltID) ON [Primary]
END

PRINT 'Drop All Default Constraints from ExportFileXslt'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'ExportFileXslt')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE ExportFileXslt DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'ExportFileXslt')
END
