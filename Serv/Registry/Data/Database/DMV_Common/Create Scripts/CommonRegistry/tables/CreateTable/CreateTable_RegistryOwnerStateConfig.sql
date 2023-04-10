/******************************************************************************
**		File: CreateTable_RegistryOwnerStateConfig.sql
**		Name: RegistryOwnerStateConfig
**		Desc: Create table: RegistryOwnerStateConfig
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
**		02/08/2010	ccarroll			
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to RegistryOwnerStateConfig'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'RegistryOwnerStateConfig')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryOwnerStateConfig'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
	PRINT 'Creating Table: RegistryOwnerStateConfig'
		CREATE TABLE [dbo].[RegistryOwnerStateConfig](
		[RegistryOwnerStateConfigID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerID] [int] NULL,
		[RegistryOwnerStateID] [int] NULL,
		[RegistryOwnerStateAbbrv] [varchar] (2) NULL,
		[RegistryOwnerStateName] [varchar] (50) NULL,
		[RegistryOwnerStateVerificationForm] [varchar] (50) NULL,
		[RegistryOwnerStateDMVDSN] [varchar] (25) NULL,
		[RegistryOwnerStateActive] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END
	GRANT SELECT ON RegistryOwnerStateConfig TO PUBLIC

		-- check if RegistryOwnerStateIDlblText
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'lblStateIdText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column lblStateIdText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD lblStateIdText  nvarchar(200) NULL
		END
		
		-- check if lblLimitationsText 
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'lblLimitationsText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column lblLimitationsText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD lblLimitationsText  nvarchar(200) NULL
		END
		
		-- check if ContactInformationText  
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'ContactInformationText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column ContactInformationText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD ContactInformationText  nvarchar(2000) NULL
		END
		
		-- check if LegalHeaderText   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'LegalHeaderText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column LegalHeaderText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD LegalHeaderText  nvarchar(2000) NULL
		END	
		
				-- check if LegalIntroText   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'LegalIntroText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column LegalIntroText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD LegalIntroText  nvarchar(2000) NULL
		END	
		
				-- check if LegalText    
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'LegalText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column LegalText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD LegalText  nvarchar(2000) NULL
		END	
		
				-- check if LegalDescriptionlText    
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'LegalDescriptionlText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column LegalDescriptionlText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD LegalDescriptionlText  nvarchar(2000) NULL
		END	


				-- check if WebLegalHeader 
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'WebLegalHeader'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column WebLegalHeader'
			ALTER TABLE RegistryOwnerStateConfig
				ADD WebLegalHeader  nvarchar(2000) NULL
		END	

				-- check if ix.	WebLegalIntroText     
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'WebLegalIntroText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column WebLegalIntroText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD WebLegalIntroText  nvarchar(2000) NULL
		END	

				-- check if x.	WebLegalText    
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'WebLegalText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column WebLegalText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD WebLegalText  nvarchar(2000) NULL
		END	

				-- check if xi.	WebLegalDescriptionlText     
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'WebLegalDescriptionlText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column WebLegalDescriptionlText'
			ALTER TABLE RegistryOwnerStateConfig
				ADD WebLegalDescriptionlText  nvarchar(2000) NULL
		END	
		
		-- check if DisplayInDMVSearchOptions
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'DisableDMVSearchOption'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerStateConfig Adding Column DisableDMVSearchOption'
			ALTER TABLE RegistryOwnerStateConfig
				ADD DisableDMVSearchOption  bit NULL
		END

		-- check length LegalDescriptionlText
		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'LegalDescriptionlText'
			) = 4000
		BEGIN
			PRINT 'ALTERING TABLE: Increasing LegalDescriptionlText to Nvarchar(max) '
			ALTER TABLE RegistryOwnerStateConfig
				ALTER COLUMN LegalDescriptionlText Nvarchar(Max) Null
		END	
				
		-- check length WebLegalDescriptionlText
		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerStateConfig]')
			AND syscolumns.name = 'WebLegalDescriptionlText'
			) = 4000
		BEGIN
			PRINT 'ALTERING TABLE: Increasing WebLegalDescriptionlText to Nvarchar(max) '
			ALTER TABLE RegistryOwnerStateConfig
				ALTER COLUMN WebLegalDescriptionlText Nvarchar(Max) Null
		END	

		
GO