 
		/******************************************************************************
		**	File: OrganizationSourceCode(table).sql
		**	Name: OrganizationSourceCode
		**	Desc: This table is being dropped. It was created many years ago accidentally and not removed. 
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		**	Revisions:
		**  10/29/2010	bret	remove table
		*******************************************************************************/
		
		/****** Object:  Table [dbo].[OrganizationSourceCode]    Script Date: 10/29/2010 11:35:05 ******/
		-- delete the previous table and create a new table 
		IF  EXISTS (
					SELECT * FROM sys.objects 
			JOIN sys.columns ON sys.objects.object_id = sys.columns.object_id
			WHERE sys.objects.object_id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]') AND type in (N'U')
			and sys.columns.name = 'SourceCodeID'
		)
		BEGIN
			PRINT 'DROP Original Unused TABLE [dbo].[OrganizationSourceCode]'
			DROP TABLE [dbo].[OrganizationSourceCode]
		END


/******************************************************************************
		**	File: OrganizationSourceCode(table).sql
		**	Name: AlterOrganizationSourceCode
		**	Desc: Create table and add default columns for the table OrganizationSourceCode
		**	Auth: Bret Knoll
		**	Date: 11/12/2010
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to OrganizationSourceCode'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'OrganizationSourceCode')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'OrganizationSourceCode'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			PRINT 'CREATE TABLE [dbo].[OrganizationSourceCode]';
			CREATE TABLE [dbo].[OrganizationSourceCode]
			(			
			OrganizationID int NOT NULL, 
			SourceCodeList nvarchar(1000) NULL, 
			LastModified smalldatetime NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON OrganizationSourceCode TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE OrganizationSourceCode Adding Column LastModified'
			ALTER TABLE OrganizationSourceCode
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE OrganizationSourceCode Adding Column LastStatEmployeeID'
			ALTER TABLE OrganizationSourceCode
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE OrganizationSourceCode Adding Column AuditLogTypeID'
			ALTER TABLE OrganizationSourceCode
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE OrganizationSourceCode SET (LOCK_ESCALATION = TABLE)
		END

