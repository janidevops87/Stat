
		/******************************************************************************
		**	File: StatEmployee(table).sql
		**	Name: AlterStatEmployee
		**	Desc: Create table and add default columns for the table StatEmployee
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to StatEmployee'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'StatEmployee')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'StatEmployee'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[StatEmployee]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[StatEmployee]
			(
			StatEmployeeID int  NOT NULL, 
			StatEmployeeFirstName varchar(50) NULL, 
			StatEmployeeLastName varchar(50) NULL, 
			StatEmployeeUserID varchar(50) NULL, 
			StatEmployeePassword varchar(50) NULL, 
			LastModified datetime NULL, 
			AllowCallDelete smallint NULL, 
			AllowMaintainAccess smallint NULL, 
			AllowSecurityAccess smallint NULL, 
			AllowLicenseAccess smallint NULL, 
			PersonID int NULL, 
			StatEmployeeEmail varchar(30) NULL, 
			AllowStopTimerAccess smallint NULL, 
			AllowIncompleteAccess smallint NULL, 
			AllowScheduleAccess smallint NULL, 
			UpdatedFlag smallint NULL, 
			AllowRecoveryAccess smallint NULL, 
			AllowInternetAccess smallint NULL, 
			IntranetSecurityLevel smallint NULL, 
			AllowEmployeeMaintTC smallint NULL, 
			AllowEmployeeMaintFS smallint NULL, 
			AllowEmployeeMaintAdmin smallint NULL, 
			AllowEmployeeScheduleTC smallint NULL, 
			AllowEmployeeScheduleFS smallint NULL, 
			AllowQAReview smallint NULL, 
			AllowRecycleCase smallint NULL, 
			AllowCloseReferral smallint NULL, 
			AllowASPSave int NULL, 
			AllowViewDeletedLogEvents smallint NULL, 
			LastStatEmployeeID int NULL, 
			AuditLogTypeID int NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON StatEmployee TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[StatEmployee]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE StatEmployee Adding Column LastModified'
			ALTER TABLE StatEmployee
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[StatEmployee]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE StatEmployee Adding Column LastStatEmployeeID'
			ALTER TABLE StatEmployee
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[StatEmployee]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE StatEmployee Adding Column AuditLogTypeID'
			ALTER TABLE StatEmployee
				ADD AuditLogTypeID INT NULL
		END			
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE StatEmployee SET (LOCK_ESCALATION = TABLE)
		END
		
