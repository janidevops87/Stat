
		/******************************************************************************
		**	File: Person(table).sql
		**	Name: AlterPerson
		**	Desc: Create table and add default columns for the table Person
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added this note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop Person Primary Key PK_Person_1__24'

		/****** Object:  Index [PK_Person_1__24]    Script Date: 09/14/2009 17:26:44 ******/
		IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Person]') AND name = N'PK_Person_1__24')
		BEGIN

			IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Person_FSBCase_FK1]') AND type = 'F')
			BEGIN
				ALTER TABLE [dbo].[FSBCase] DROP CONSTRAINT [Person_FSBCase_FK1]
			END

			IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_FsbCaseStatus_FamilyServicesCoordinatorId_Person_PersonId]') AND type = 'F')
			BEGIN
				ALTER TABLE [dbo].[FsbCaseStatus] DROP CONSTRAINT [FK_FsbCaseStatus_FamilyServicesCoordinatorId_Person_PersonId]
			END
			IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_PersonPhone_PersonID_Person_PersonID]') AND type = 'F')
			BEGIN
				ALTER TABLE [dbo].[PersonPhone] DROP CONSTRAINT [FK_PersonPhone_PersonID_Person_PersonID]
			END
			IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssDonorContactInformation_ClinicalCoordinatorId_Person_PersonId]') AND type = 'F')
			BEGIN
				ALTER TABLE [dbo].[TcssDonorContactInformation] DROP CONSTRAINT [FK_TcssDonorContactInformation_ClinicalCoordinatorId_Person_PersonId]
			END
						/****** Object:  Index [PK_Person_1__24]    Script Date: 07/08/2011 08:17:23 ******/
			IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'PK_Person_1__24' and OBJECTPROPERTY(Object_id(N'PK_Person_1__24'),'IsConstraint') is null )
				DROP INDEX [PK_Person_1__24] ON [dbo].[Person] WITH ( ONLINE = OFF )
		

			/****** Object:  Index [PK_Person]    Script Date: 07/08/2011 08:20:45 ******/
			IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'PK_Person_1__24' and OBJECTPROPERTY(Object_id(name),'IsConstraint') = 1 )
				ALTER TABLE [dbo].[Person] DROP CONSTRAINT [PK_Person_1__24]

		END

		
		PRINT 'Drop All Foreign Keys to Person'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'Person')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'Person'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Person]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[Person]
			(
			PersonID int NOT NULL, 
			PersonFirst varchar(50) NULL, 
			PersonMI varchar(1) NULL, 
			PersonLast varchar(50) NULL, 
			PersonTypeID int NULL, 
			OrganizationID int NULL, 
			PersonNotes varchar(255) NULL, 
			PersonBusy smallint NULL, 
			Verified smallint NULL, 
			Inactive smallint NULL, 
			LastModified datetime NULL, 
			PersonBusyUntil smalldatetime NULL, 
			PersonTempNoteActive smallint NULL, 
			PersonTempNoteExpires smalldatetime NULL, 
			PersonTempNote varchar(255) NULL, 
			Unused varchar(30) NULL, 
			UpdatedFlag smallint NULL, 
			AllowInternetScheduleAccess smallint NULL, 
			PersonSecurity int NULL, 
			PersonArchive smallint NULL, 
			LastStatEmployeeID int NULL, 
			AuditLogTypeID int NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON Person TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Person]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE Person Adding Column LastModified'
			ALTER TABLE Person
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Person]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Person Adding Column LastStatEmployeeID'
			ALTER TABLE Person
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Person]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Person Adding Column AuditLogTypeID'
			ALTER TABLE Person
				ADD AuditLogTypeID INT NULL
		END	
		-- check if GenderID, Race and Credential Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Person]')
			AND syscolumns.name = 'GenderID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Person Adding Column GenderID, RaceID, Credential, TrainedRequestorID'
			ALTER TABLE Person
				ADD 
				GenderID INT NULL,
				RaceID INT NULL,
				Credential VARCHAR(25) Null,
				TrainedRequestorID INT NULL
		END	
				
				
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Person SET (LOCK_ESCALATION = TABLE)
		END
		
