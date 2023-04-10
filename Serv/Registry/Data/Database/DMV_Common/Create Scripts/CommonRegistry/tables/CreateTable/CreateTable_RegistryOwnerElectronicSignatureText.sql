		/******************************************************************************
		**	File: RegistryOwnerElectronicSignatureText(table).sql
		**	Name: AlterRegistryOwnerElectronicSignatureText
		**	Desc: Create table and add default columns for the table RegistryOwnerElectronicSignatureText
		**	Auth: ccarroll 
		**	Date: 2/8/2010
		**	3/21/2011 ccarroll	 Added DivFooter
		**  07/09/2013 ccarroll Increase column size to Nvarchar(max)
		**	09/03/2015 mmaitan	Added EmailMailboxAccount
		*******************************************************************************/
		PRINT 'Drop All Foreign Keys to RegistryOwnerElectronicSignatureText'
		WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
						(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
							(SELECT Id FROM sysobjects WHERE name = 'RegistryOwnerElectronicSignatureText')))
		BEGIN
			DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
				@FkTableName varchar(500), @KeyName varchar(500)

			SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryOwnerElectronicSignatureText'
			SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
			SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
			SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
			
			SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
			EXEC(@sqlScript)
		END				
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			CREATE TABLE [dbo].[RegistryOwnerElectronicSignatureText]
			(
			ID int IDENTITY(1,1) NOT NULL, 
			RegistryOwnerID int NULL, 
			LanguageCode nvarchar(2) NULL,
			LblName nvarchar(200) NULL, 
			LblAddress nvarchar(200) NULL, 
			LblEmail nvarchar(200) NULL, 
			AddLblConfirmation nvarchar(200) NULL, 
			AddCbxConfirmation nvarchar(200) NULL, 
			AddBtnRegistration nvarchar(200) NULL, 
			AddEmailSubject nvarchar(200) NULL, 
			AddEmailBody nvarchar(1000) NULL, 
			AddEmailInvitationSubject nvarchar(1000) NULL, 
			AddEmailInvitationBody nvarchar(1000) NULL, 
			RemoveLblConfirmation nvarchar(200) NULL, 
			RemoveCbxConfirmation nvarchar(200) NULL, 
			RemoveBtnRegistration nvarchar(200) NULL, 
			RemoveEmailSubject nvarchar(1000) NULL, 
			RemoveEmailBody nvarchar(1000) NULL,
			EmailFrom nvarchar(100) NULL,
			CertificateAuthority nvarchar(200) NULL,
			FailureMessage nvarchar(1000) NULL,
			EmailMailboxAccount nvarchar(100) NULL
			) ON [PRIMARY]			
		END
		ELSE
		BEGIN
			if not exists(select top 1 * from sys.columns
				where object_id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
				and name = 'EmailMailboxAccount')
			begin
				alter table RegistryOwnerElectronicSignatureText
				add [EmailMailboxAccount] nvarchar(100)
			end
			else
			begin
				alter table RegistryOwnerElectronicSignatureText
				alter column [EmailMailboxAccount] nvarchar(100)
			end
		END;
		GRANT SELECT ON RegistryOwnerElectronicSignatureText TO PUBLIC

		-- check if Lastmodified Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'LastModified'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column LastModified'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD LastModified DATETIME
		END	
		-- check if LastStatEmployee Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'LastStatEmployeeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column LastStatEmployeeID'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD LastStatEmployeeID INT NULL
		END			
		-- check if AuditLogTypeID Exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'AuditLogTypeID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column AuditLogTypeID'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD AuditLogTypeID INT NULL
		END	
		--check if DivFooter exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'DivFooter'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column DivFooter'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD DivFooter Nvarchar(Max) Null
		END

		--check if AddDivConfirmationNotes exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'AddDivConfirmationNotes'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column AddDivConfirmationNotes'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD AddDivConfirmationNotes Nvarchar(Max) Null
		END
		
		--check if RemoveDivConfirmationNotes exists
		IF  NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'RemoveDivConfirmationNotes'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Adding Column RemoveDivConfirmationNotes'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ADD RemoveDivConfirmationNotes Nvarchar(Max) Null
		END


		-- Increase size AddLblConfirmation
		IF  EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'AddLblConfirmation' AND syscolumns.length = 400
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Increase Column size: AddLblConfirmation'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ALTER COLUMN AddLblConfirmation Nvarchar(Max) Null
		END

		-- Increase size RemoveLblConfirmation
		IF  EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwnerElectronicSignatureText]')
			AND syscolumns.name = 'RemoveLblConfirmation' AND syscolumns.length = 400
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwnerElectronicSignatureText Increase Column size: RemoveLblConfirmation'
			ALTER TABLE RegistryOwnerElectronicSignatureText
				ALTER COLUMN RemoveLblConfirmation Nvarchar(Max) Null
		END		
		
									
GO