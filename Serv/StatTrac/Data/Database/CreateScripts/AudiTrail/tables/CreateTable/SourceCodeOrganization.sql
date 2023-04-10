 
		/******************************************************************************
		**	File: SourceCodeOrganization(table).sql
		**	Name: AlterSourceCodeOrganization
		**	Desc: Create table and add default columns for the table SourceCodeOrganization
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added this note for development build inclusion (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to SourceCodeOrganization'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'SourceCodeOrganization')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'SourceCodeOrganization'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[SourceCodeOrganization]
			(
			SourceCodeOrganizationID int  NOT NULL, 
			SourceCodeID int NULL, 
			OrganizationID int NULL, 
			LastModified datetime NULL, 
			UpdatedFlag smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON SourceCodeOrganization TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeOrganization Adding Column LastModified'
			ALTER TABLE SourceCodeOrganization
				ADD LastModified DATETIME
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeOrganization Adding Column LastStatEmployeeID'
			ALTER TABLE SourceCodeOrganization
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeOrganization Adding Column AuditLogTypeID'
			ALTER TABLE SourceCodeOrganization
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeOrganization SET (LOCK_ESCALATION = TABLE)
		END
		
