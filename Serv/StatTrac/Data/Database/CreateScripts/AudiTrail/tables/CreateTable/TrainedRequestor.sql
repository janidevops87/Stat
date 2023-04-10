
		/******************************************************************************
		**	File: TrainedRequestor(table).sql
		**	Name: AlterTrainedRequestor
		**	Desc: Create table and add default columns for the table TrainedRequestor
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:		Author:			Description:
		**	--------	--------		----------------------------------
		**  07/14/10	Bret Knoll		Adding to release 
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to TrainedRequestor'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'TrainedRequestor')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'TrainedRequestor'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[TrainedRequestor]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[TrainedRequestor]
			(
			TrainedRequestorID int  NOT NULL, 
			TrainedRequestor varchar(50) NULL, 
			LastModified datetime NULL, 
			LastStatEmployeeID int NULL, 
			AuditLogTypeID int NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON TrainedRequestor TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TrainedRequestor]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE TrainedRequestor Adding Column LastModified'
			ALTER TABLE TrainedRequestor
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TrainedRequestor]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE TrainedRequestor Adding Column LastStatEmployeeID'
			ALTER TABLE TrainedRequestor
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[TrainedRequestor]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE TrainedRequestor Adding Column AuditLogTypeID'
			ALTER TABLE TrainedRequestor
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE TrainedRequestor SET (LOCK_ESCALATION = TABLE)
		END
		
