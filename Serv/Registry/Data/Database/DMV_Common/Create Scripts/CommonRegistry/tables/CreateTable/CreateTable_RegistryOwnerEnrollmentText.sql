		/******************************************************************************
		**	File: RegistryOwnerEnrollmentText(table).sql
		**	Name: AlterRegistryOwnerEnrollmentText
		**	Desc: Create table and add default columns for the table RegistryOwnerEnrollmentText
		**	Auth: ccarroll 
		**	Date: 2/8/2010
		**	Revision History
		**	01/11/2011 ccarroll		Increased DivInstruction, ConfirmationPanelAdd to Nvarchar(max)
		**  03/21/2011 ccarroll		Added DivFooter
		**  07/08/2013 ccarroll		Added DivCityStateZipText, DivStateIdInformation, LblLicenseOrStateId 
		**	01/20/2014 mschepart	Alter column DivSubmitInstruction to max length
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to RegistryOwnerEnrollmentText'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'RegistryOwnerEnrollmentText')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryOwnerEnrollmentText'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[RegistryOwnerEnrollmentText]
			(
			ID int IDENTITY(1,1) NOT NULL, 
			RegistryOwnerID int NULL, 
			LanguageCode nvarchar(2) NULL, 
			HeaderImageURL nvarchar(200) NULL, 
			HeaderImageWidth nvarchar(10) NULL, 
			HeaderImageHeight nvarchar(10) NULL, 
			DivInstruction nvarchar(1000) NULL, 
			DivRegistrationSelection nvarchar(200) NULL, 
			LblSelectOne nvarchar(200) NULL, 
			RdoAdd nvarchar(200) NULL, 
			RdoRemove nvarchar(200) NULL, 
			DivNameInstruction nvarchar(200) NULL, 
			LblFirstName nvarchar(200) NULL, 
			LblLastName nvarchar(200) NULL, 
			LblMiddleName nvarchar(200) NULL, 
			LblGender nvarchar(200) NULL, 
			RdoMale nvarchar(200) NULL, 
			RdoFemale nvarchar(200) NULL, 
			LblDateOfBirth nvarchar(200) NULL, 
			DivResidentialAddress nvarchar(200) NULL, 
			LblStreetAddress nvarchar(200) NULL, 
			LblAddress2 nvarchar(200) NULL, 
			LblCityStateZip nvarchar(200) NULL, 
			DivContactInformation nvarchar(200) NULL, 
			LblEmailAddress nvarchar(200) NULL, 
			DivEmailConfirmation nvarchar(200) NULL, 
			DivSSN nvarchar(200) NULL, 
			LblLastFourSSN nvarchar(200) NULL, 
			DivLimitations nvarchar(200) NULL, 
			DivLimitationsInstructions nvarchar(1000) NULL, 
			LblEventCategoryMessage nvarchar(200) NULL, 
			LblComment nvarchar(200) NULL, 
			DivInformationContacts nvarchar(1000) NULL, 
			DivSubmitInstruction nvarchar(200) NULL, 
			BtnRegisterNow nvarchar(200) NULL, 
			ConfirmationPanelAdd nvarchar(1000) NULL, 
			ConfirmationPanelRemove nvarchar(1000) NULL
			) ON [PRIMARY]			
		END	
		GRANT SELECT ON RegistryOwnerEnrollmentText TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column LastModified'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD LastModified DATETIME
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column LastStatEmployeeID'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column AuditLogTypeID'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD AuditLogTypeID INT NULL
		END			

		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'DivInstruction'
			) = 2000
		BEGIN
			PRINT 'ALTERING TABLE: Increasing DivInstruction to Nvarchar(max) '
			ALTER TABLE RegistryOwnerEnrollmentText
				ALTER COLUMN DivInstruction Nvarchar(Max) Null
		END			

		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'ConfirmationPanelAdd'
			) = 2000
		BEGIN
			PRINT 'ALTERING TABLE: Increasing ConfirmationPanelAdd to Nvarchar(max) '
			ALTER TABLE RegistryOwnerEnrollmentText
				ALTER COLUMN ConfirmationPanelAdd Nvarchar(Max) Null
		END	
		--check if DivFooter exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'DivFooter'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column DivFooter'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD DivFooter Nvarchar(Max) Null
		END					
		--check if DivCityStateZipText  exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'DivCityStateZipText'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column DivCityStateZipText'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD DivCityStateZipText Nvarchar(Max) Null
		END	


		--check if DivStateIdInformation  exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'DivStateIdInformation'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column DivStateIdInformation'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD DivStateIdInformation Nvarchar(Max) Null
		END	
		--check if LblLicenseOrStateID  exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'LblLicenseOrStateID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerEnrollmentText Adding Column LblLicenseOrStateID'
			ALTER TABLE RegistryOwnerEnrollmentText
				ADD LblLicenseOrStateID Nvarchar(Max) Null
		END	

		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'DivSubmitInstruction'
			) = 400
		BEGIN
			PRINT 'ALTERING TABLE: Increasing DivSubmitInstruction to Nvarchar(max) '
			ALTER TABLE RegistryOwnerEnrollmentText
				ALTER COLUMN DivSubmitInstruction Nvarchar(Max) Null
		END	

		IF  (select [length] from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerEnrollmentText]')
			AND syscolumns.name = 'RdoRemove'
			) = 400
		BEGIN
			PRINT 'ALTERING TABLE: Increasing RdoRemove to Nvarchar(max) '
			ALTER TABLE RegistryOwnerEnrollmentText
				ALTER COLUMN RdoRemove Nvarchar(Max) Null
		END	
GO


