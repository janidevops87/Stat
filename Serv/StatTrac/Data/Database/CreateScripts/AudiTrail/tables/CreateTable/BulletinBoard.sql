		/******************************************************************************
		**	File: BulletinBoard.sql
		**	Name: BulletinBoard
		**	Desc: Create table and add default columns for the table BulletinBoard
		**	Auth: ccarroll
		**	Date: 09/13/2010
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to BulletinBoard'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'BulletinBoard')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'BulletinBoard'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[BulletinBoard]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[BulletinBoard]
			(
			[BulletinBoardID] int  NOT NULL,
			[Organization] nvarchar(80) NULL,
			[Alert] nvarchar(255) NULL,
			[CreateDate] datetime NULL,
			[OrganizationID] int Null
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON BulletinBoard TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[BulletinBoard]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE BulletinBoard Adding Column LastModified'
			ALTER TABLE BulletinBoard
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[BulletinBoard]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE BulletinBoard Adding Column LastStatEmployeeID'
			ALTER TABLE BulletinBoard
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[BulletinBoard]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE BulletinBoard Adding Column AuditLogTypeID'
			ALTER TABLE BulletinBoard
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE BulletinBoard SET (LOCK_ESCALATION = TABLE)
		END
		
