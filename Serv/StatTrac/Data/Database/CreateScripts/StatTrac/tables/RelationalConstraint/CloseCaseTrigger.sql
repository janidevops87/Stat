/******************************************************************************
**	File: CloseCaseTrigger.sql
**	Name: CloseCaseTrigger
**	Desc: Relational Constraints for CloseCaseTrigger
**	Auth: Bret Knoll
**	Date: 02/26/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	02/26/2009	Bret Knoll	Initial Relational Constraints
*******************************************************************************/

PRINT 'Drop All Foreign Keys to CloseCaseTrigger'
WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
				(SELECT MAX(constid) FROM sysforeignkeys WHERE Fkeyid = 
					(SELECT Id FROM sysobjects WHERE name = 'CloseCaseTrigger')))
BEGIN
	DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
		@FkTableName varchar(500), @KeyName varchar(500)

	SELECT @TableNameId = Id FROM sysobjects WHERE name = 'CloseCaseTrigger'
	SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE Fkeyid = @TableNameId
	SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
	SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
	
	SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
	EXEC(@sqlScript)
END

