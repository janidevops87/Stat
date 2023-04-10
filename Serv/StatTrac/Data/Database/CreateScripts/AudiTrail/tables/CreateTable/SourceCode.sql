
		/******************************************************************************
		**	File: SourceCode(table).sql
		**	Name: AlterSourceCode
		**	Desc: Create table and add default columns for the table SourceCode
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Revision
		**  ccarroll 07/09/2010 added note for development build (GenerateSQL)
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to SourceCode'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'SourceCode')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int , @FkId int , @KeyId int , 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'SourceCode'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SourceCode]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[SourceCode]
			(
			SourceCodeID int  NOT NULL, 
			SourceCodeName varchar(10) NULL, 
			SourceCodeDescription varchar(200) NULL, 
			LastModified datetime NULL, 
			SourceCodeType int NULL, 
			SourceCodeDefaultAlert varchar(255) NULL, 
			SourceCodeLineCheckInstruc varchar(255) NULL, 
			SourceCodeLineCheckInterval int NULL, 
			SourceCode1Start varchar(5) NULL, 
			SourceCode1End varchar(5) NULL, 
			SourceCode2Start varchar(5) NULL, 
			SourceCode2End varchar(5) NULL, 
			SourceCode3Start varchar(5) NULL, 
			SourceCode3End varchar(5) NULL, 
			SourceCode4Start varchar(5) NULL, 
			SourceCode4End varchar(5) NULL, 
			SourceCode5Start varchar(5) NULL, 
			SourceCode5End varchar(5) NULL, 
			SourceCode6Start varchar(5) NULL, 
			SourceCode6End varchar(5) NULL, 
			SourceCode7Start varchar(5) NULL, 
			SourceCode7End varchar(5) NULL, 
			SourceCodeDisabledInterval smallint NULL, 
			SourceCodeNameUnAbbrev varchar(100) NULL, 
			SourceCodeRotationActive smallint NULL, 
			SourcecodeRotationAlias varchar(50) NULL, 
			SourcecodeRotationTrue smallint NULL, 
			SourcecodeDonorTracClient smallint NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON SourceCode TO PUBLIC

		-- check if SourceCodeDefault exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCode')
					AND sys.columns.name = 'SourceCodeDefault'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding New Columns'
			ALTER TABLE SourceCode
				ADD SourceCodeDefault INT DEFAULT(0) NULL
		END

		-- check if Inactive exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCode')
					AND sys.columns.name = 'Inactive'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding New Columns'
			ALTER TABLE SourceCode
				ADD Inactive INT DEFAULT(0) NULL
		END

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCode]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding Column LastModified'
			ALTER TABLE SourceCode
				ADD LastModified DATETIME NULL
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCode]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding Column LastStatEmployeeID'
			ALTER TABLE SourceCode
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[SourceCode]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding Column AuditLogTypeID'
			ALTER TABLE SourceCode
				ADD AuditLogTypeID INT NULL
		END
		-- check if SourceCodeOrgID exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCode')
					AND sys.columns.name = 'SourceCodeOrgID'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding New Columns'
			ALTER TABLE SourceCode
				ADD SourceCodeOrgID INT NULL
		END
		
		-- check if SourceCodeCallTypeID exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCode')
					AND sys.columns.name = 'SourceCodeCallTypeID'
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding New Columns'
			ALTER TABLE SourceCode
				ADD SourceCodeCallTypeID INT NULL
		END
		
		-- check if SourceCodeDefaultAlert nvarchar(MAX) data type exists
		IF NOT EXISTS (
					select * from sys.columns where object_id in (select object_id from sys.objects where name = 'SourceCode')
					AND sys.columns.name = 'SourceCodeDefaultAlert' AND sys.columns.system_type_id = 231
					)
		BEGIN
			PRINT 'ALTERING TABLE SourceCode Adding New Columns'
			ALTER TABLE SourceCode
				Alter column SourceCodeDefaultAlert nvarchar(max) NULL
		END		
					
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCode SET (LOCK_ESCALATION = TABLE)
		END
