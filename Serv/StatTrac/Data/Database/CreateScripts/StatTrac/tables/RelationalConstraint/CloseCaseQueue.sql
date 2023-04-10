/******************************************************************************
**	File: CloseCaseQueue.sql
**	Name: CloseCaseQueue
**	Desc: Relational Constraints for CloseCaseQueue
**	Auth: Bret Knoll
**	Date: 02/26/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	02/26/2009	Bret Knoll	Initial Relational Constraints
*******************************************************************************/

PRINT 'Drop All Foreign Keys to CloseCaseQueue'
WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
				(SELECT MAX(constid) FROM sysforeignkeys WHERE Fkeyid = 
					(SELECT Id FROM sysobjects WHERE name = 'CloseCaseQueue')))
BEGIN
	DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
		@FkTableName varchar(500), @KeyName varchar(500)

	SELECT @TableNameId = Id FROM sysobjects WHERE name = 'CloseCaseQueue'
	SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE Fkeyid = @TableNameId
	SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
	SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
	
	SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
	EXEC(@sqlScript)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_CloseCaseQueue_Call')
	BEGIN
		PRINT 'Adding Foreign Key FK_CloseCaseQueue_Call'
		ALTER TABLE dbo.CloseCaseQueue ADD CONSTRAINT
			FK_CloseCaseQueue_Call FOREIGN KEY
			(
			CallID
			) REFERENCES dbo.Call
			(
			CallID
			)
	END
GO
