
		/******************************************************************************
		**	File: SecurityRule(table).sql
		**	Name: AlterSecurityRule
		**	Desc: Create table and add default columns for the table SecurityRule
		**	Auth: Bret Knoll
		**	Date: 9/4/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to SecurityRule'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'SecurityRule')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'SecurityRule'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SecurityRule]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[SecurityRule]
			(
			SecurityRuleID int  NOT NULL, 
			SecurityRule nvarchar(100) NULL, 
			Expression nvarchar(4000) NULL, 
			LastModified datetime NULL, 
			LastStatEmployeeID int NULL, 
			AuditLogTypeID int NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON SecurityRule TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SecurityRule]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE SecurityRule Adding Column LastModified'
			ALTER TABLE SecurityRule
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SecurityRule]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SecurityRule Adding Column LastStatEmployeeID'
			ALTER TABLE SecurityRule
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SecurityRule]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SecurityRule Adding Column AuditLogTypeID'
			ALTER TABLE SecurityRule
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SecurityRule SET (LOCK_ESCALATION = TABLE)
		END
		
