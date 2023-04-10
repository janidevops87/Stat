
		/******************************************************************************
		**	File: PersonType(table).sql
		**	Name: AlterPersonType
		**	Desc: Create table and add default columns for the table PersonType
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added this note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'DROP OLD Primary Key'
/****** Object:  Index [PK_PersonType_1__13]    Script Date: 09/15/2009 09:07:32 ******/
		IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[PersonType]') AND name = N'PK_PersonType_1__13' AND OBJECTPROPERTY(Object_id(name),'IsConstraint') = 1 )
		ALTER TABLE [dbo].[PersonType] DROP CONSTRAINT [PK_PersonType_1__13]

		/****** Object:  Index [PK_Person_1__24]    Script Date: 07/08/2011 08:17:23 ******/
		IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'PK_Organization_1__24' and OBJECTPROPERTY(Object_id(name),'IsConstraint') is null )
			DROP INDEX [PK_PersonType_1__13] ON [dbo].[PersonType] WITH ( ONLINE = OFF )		
		PRINT 'Drop All Foreign Keys to PersonType'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'PersonType')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'PersonType'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[PersonType]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[PersonType]
			(
			PersonTypeID int  NOT NULL, 
			PersonTypeName varchar(50) NULL, 
			Verified smallint NULL, 
			Inactive smallint NULL, 
			LastModified datetime NULL, 
			PersonTypeProcurmentAgency smallint NULL, 
			UpdatedFlag smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON PersonType TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonType]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonType Adding Column LastModified'
			ALTER TABLE PersonType
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonType]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonType Adding Column LastStatEmployeeID'
			ALTER TABLE PersonType
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonType]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonType Adding Column AuditLogTypeID'
			ALTER TABLE PersonType
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PersonType SET (LOCK_ESCALATION = TABLE)
		END
		
