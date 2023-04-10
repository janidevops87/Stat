
		/******************************************************************************
		**	File: SourceCodeTransplantCenter(table).sql
		**	Name: AlterSourceCodeTransplantCenter
		**	Desc: Create table and add default columns for the table SourceCodeTransplantCenter
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to SourceCodeTransplantCenter'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'SourceCodeTransplantCenter')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'SourceCodeTransplantCenter'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[SourceCodeTransplantCenter]
			(
			SourceCodeTransplantCenterID int NULL, 
			SourceCodeID int NULL, 
			OrganizationID int NULL, 
			TransplantCode varchar(50) NULL 
			) ON [PRIMARY]			
		END	

		-- check if OrganizationName Exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCodeTransplantCenter')
					AND sys.columns.name = 'OrganizationName'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding New Columns'
			ALTER TABLE SourceCodeTransplantCenter
				ADD OrganizationName nvarchar(80) NULL
		END

		-- check if OrganType Exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCodeTransplantCenter')
					AND sys.columns.name = 'OrganType'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding New Columns'
			ALTER TABLE SourceCodeTransplantCenter
				ADD OrganType nvarchar(50) NULL
		END


		-- check if MessageOrganizationID Exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCodeTransplantCenter')
					AND sys.columns.name = 'MessageOrganizationID'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding New Columns'
			ALTER TABLE SourceCodeTransplantCenter
				ADD MessageOrganizationID INT NULL
		END


		-- check if MessageOrganizationName Exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCodeTransplantCenter')
					AND sys.columns.name = 'MessageOrganizationName'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding New Columns'
			ALTER TABLE SourceCodeTransplantCenter
				ADD MessageOrganizationName nvarchar(80) NULL
		END


		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding Column LastModified'
			ALTER TABLE SourceCodeTransplantCenter
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding Column LastStatEmployeeID'
			ALTER TABLE SourceCodeTransplantCenter
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCodeTransplantCenter Adding Column AuditLogTypeID'
			ALTER TABLE SourceCodeTransplantCenter
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeTransplantCenter SET (LOCK_ESCALATION = TABLE)
		END
		
		GRANT SELECT ON SourceCodeTransplantCenter TO PUBLIC
