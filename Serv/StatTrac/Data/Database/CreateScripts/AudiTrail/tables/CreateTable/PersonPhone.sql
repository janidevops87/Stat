
		/******************************************************************************
		**	File: PersonPhone(table).sql
		**	Name: AlterPersonPhone
		**	Desc: Create table and add default columns for the table PersonPhone
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added this note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to PersonPhone'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'PersonPhone')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'PersonPhone'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[PersonPhone]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[PersonPhone]
			(
			PersonPhoneID int  NOT NULL, 
			PersonID int NULL, 
			PhoneID int NULL, 
			Unused int NULL, 
			PersonPhonePin varchar(10) NULL, 
			LastModified datetime NULL, 
			PhoneAlphaPagerEmail varchar(100) NULL, 
			UpdatedFlag smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON PersonPhone TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column LastModified'
			ALTER TABLE PersonPhone
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column LastStatEmployeeID'
			ALTER TABLE PersonPhone
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column AuditLogTypeID'
			ALTER TABLE PersonPhone
				ADD AuditLogTypeID INT NULL
		END			
		-- check if PagerTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'PagerTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column PagerTypeID'
			ALTER TABLE PersonPhone
				ADD PagerTypeID INT NULL
		END	
		-- check if EmailTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'EmailTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column EmailTypeID'
			ALTER TABLE PersonPhone
				ADD EmailTypeID INT NULL
		END			
 -- check if AutoResponseID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[PersonPhone]')
			AND syscolumns.name = 'AutoResponse'
			)
		BEGIN
			PRINT 'ALTERING TABLE PersonPhone Adding Column AutoResponse'
			ALTER TABLE PersonPhone
				ADD AutoResponse int DEFAULT(0) NULL
		END											
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PersonPhone SET (LOCK_ESCALATION = TABLE)
		END
		
