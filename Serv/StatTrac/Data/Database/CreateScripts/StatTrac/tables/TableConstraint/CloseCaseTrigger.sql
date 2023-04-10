 /******************************************************************************
**	File: CloseCaseTrigger.sql
**	Name: CloseCaseTrigger
**	Desc: Table Constraint for CloseCaseTrigger
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
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'CloseCaseTrigger'))
BEGIN
	ALTER TABLE dbo.CloseCaseTrigger ADD 
		CONSTRAINT PK_CloseCaseTrigger Primary KEY CLUSTERED (CloseCaseTriggerID) ON [Primary]
END

PRINT 'Drop All Default Constraints from CloseCaseTrigger'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'CloseCaseTrigger')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE CloseCaseTrigger DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'CloseCaseTrigger')
END
