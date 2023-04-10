
		/******************************************************************************
		**	File: SourceCodeASP(table).sql
		**	Name: AlterSourceCodeASP
		**	Desc: Create table and add default columns for the table SourceCodeASP
		**	Auth: ccarroll
		**	Date: 7/26/2010
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to SourceCodeASP'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'SourceCodeASP')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'SourceCodeASP'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SourceCodeASP]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[SourceCodeASP]
			(
			SourceCodeASPId int  NOT NULL, 
			SourceCodeId int NULL, 
			ASP int NULL, 
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON SourceCodeASP TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeASP]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeASP Adding Column LastModified'
			ALTER TABLE SourceCodeASP
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeASP]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeASP Adding Column LastStatEmployeeID'
			ALTER TABLE SourceCodeASP
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeASP]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeASP Adding Column AuditLogTypeID'
			ALTER TABLE SourceCodeASP
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeASP SET (LOCK_ESCALATION = TABLE)
		END
		
