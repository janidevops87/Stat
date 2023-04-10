 /******************************************************************************
**		File: CreateTable_RegistryGUID.sql
**		Name: RegistryGUID
**		Desc: Create table: RegistryGUID
**
**		Auth: ccarroll
**		Date: 12/10/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/10/2010	ccarroll			initial
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to RegistryGUID'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'RegistryGUID')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryGUID'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryGUID]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
	PRINT 'Creating Table: RegistryGUID'
		CREATE TABLE [dbo].[RegistryGUID](
		[RegistryGUIDID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryImportLogID] [int] NULL,
		[RegistryID] [int] NULL,
		[GUID] [uniqueidentifier] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL
		) ON [PRIMARY]
	END
	
	GRANT SELECT ON RegistryGUID TO PUBLIC
	
		-- Add Columns here 
		--IF NOT EXISTS (
		--	select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryGUID]')
		--	AND syscolumns.name = 'GUID'
		--	)
		--BEGIN
		--	PRINT 'ALTERING TABLE RegistryGUID Adding Column GUID'
		--	ALTER TABLE RegistryGUID
		--		ADD GUID uniqueidentifier NULL
		--END

GO