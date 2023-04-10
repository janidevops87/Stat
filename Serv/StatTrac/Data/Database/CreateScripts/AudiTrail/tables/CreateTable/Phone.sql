
		/******************************************************************************
		**	File: Phone.sql
		**	Name: AlterPhone
		**	Desc: Create table and add default columns for the table Phone
		**	Auth: Bret Knoll
		**	Date: 8/7/2009
		**	Revisions:
		**  ccarroll 07/09/2010 added this note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to Phone'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'Phone')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'Phone'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Phone]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[Phone]
			(
			PhoneID int  NOT NULL, 
			PhoneAreaCode varchar(3) NULL, 
			PhonePrefix varchar(3) NULL, 
			PhoneNumber varchar(4) NULL, 
			PhonePin varchar(10) NULL, 
			PhoneTypeID int NULL, 
			Verified smallint NULL, 
			Inactive smallint NULL, 
			LastModified datetime NULL, 
			Unused varchar(100) NULL, 
			UpdatedFlag smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON Phone TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Phone]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE Phone Adding Column LastModified'
			ALTER TABLE Phone
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Phone]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Phone Adding Column LastStatEmployeeID'
			ALTER TABLE Phone
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Phone]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Phone Adding Column AuditLogTypeID'
			ALTER TABLE Phone
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Phone SET (LOCK_ESCALATION = TABLE)
		END
		
