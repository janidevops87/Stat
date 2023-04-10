
		/******************************************************************************
		**	File: WebPerson(Constraint).sql 
		**	Name: WebPerson
		**	Desc: Creates the table WebPerson
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/29/2010		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table WebPerson'
		GO
		IF EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_WebPerson_1__13')
		BEGIN
			DECLARE @tablename nvarchar(100) = 'WebPerson'
			PRINT 'Drop All Foreign Keys to ' 
			PRINT @tablename
		
			WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
							(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
								(SELECT Id FROM sysobjects WHERE name = @tablename)))
			BEGIN
				DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
					@FkTableName varchar(500), @KeyName varchar(500)

				SELECT @TableNameId = Id FROM sysobjects WHERE name = @tablename
				SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
				SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
				SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
				
				SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
				EXEC(@sqlScript)
			END						
			ALTER TABLE dbo.WebPerson
				DROP CONSTRAINT PK_WebPerson_1__13
		END
		GO


		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_WebPerson')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_WebPerson'
			ALTER TABLE dbo.WebPerson ADD CONSTRAINT PK_WebPerson PRIMARY KEY Clustered (WebPersonId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_WebPerson_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_WebPerson_LastModified'
			ALTER TABLE dbo.WebPerson ADD CONSTRAINT DF_WebPerson_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebPerson SET (LOCK_ESCALATION = TABLE)
		END

