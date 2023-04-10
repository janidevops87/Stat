 
		/******************************************************************************
		**	File: TransplantCenter(table).sql
		**	Name: TransplantCenter
		**	Desc: Create table and add default columns for the table TransplantCenter
		**	Auth: ccarroll
		**	Date: 04/20/2010
		**	Revisions:
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to TransplantCenter'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'TransplantCenter')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'TransplantCenter'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[TransplantCenter]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[TransplantCenter]
			(
			TransplantCenterID int  NOT NULL, 
			Code nvarchar(50) NULL,
			OrganizationName nvarchar(80) NULL,
			OrganType nvarchar(50) NULL 
			) ON [PRIMARY]			
		END	

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TransplantCenter]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE TransplantCenter Adding Column LastModified'
			ALTER TABLE TransplantCenter
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TransplantCenter]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE TransplantCenter Adding Column LastStatEmployeeID'
			ALTER TABLE TransplantCenter
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TransplantCenter]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE TransplantCenter Adding Column AuditLogTypeID'
			ALTER TABLE TransplantCenter
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE TransplantCenter SET (LOCK_ESCALATION = TABLE)
		END
		
		GRANT SELECT ON TransplantCenter TO PUBLIC
