  /******************************************************************************
**	File: CloseCaseQueue.sql
**	Name: CloseCaseQueue
**	Desc: Table Constraint for CloseCaseQueue
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
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'CloseCaseQueue'))
BEGIN
	ALTER TABLE dbo.CloseCaseQueue ADD 
		CONSTRAINT PK_CloseCaseQueue Primary KEY CLUSTERED (CloseCaseQueueID) ON [Primary]
END

PRINT 'Drop All Default Constraints from CloseCaseQueue'
DECLARE @sqlScript nvarchar(500), @ConstrainName varchar(500)

SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
	(SELECT Id FROM sysobjects WHERE name = 'CloseCaseQueue')

WHILE (@ConstrainName IS NOT NULL)
BEGIN
	SET @sqlScript = 'ALTER TABLE CloseCaseQueue DROP CONSTRAINT ' + @ConstrainName
	EXEC(@sqlScript)

	SELECT @ConstrainName = NULL
	SELECT TOP 1 @ConstrainName = Name FROM sysobjects WHERE Type='D' AND parent_obj =
		(SELECT Id FROM sysobjects WHERE name = 'CloseCaseQueue')
END

