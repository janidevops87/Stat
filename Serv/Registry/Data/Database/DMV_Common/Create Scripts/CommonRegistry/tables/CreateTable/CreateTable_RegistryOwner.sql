/******************************************************************************
**		File: CreateTable_RegistryOwner.sql
**		Name: RegistryOwner
**		Desc: Create table: RegistryOwner
**
**		Auth: Chris Carroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	Chris Carroll		initial
**		01/07/2011	Chris Carroll		Added fields for Registry Owner:
**										EnrollmentFormHideComments, EnrollmentFormDefaultStateSelection
**										and RegistryOwnerRouteName
**		03/17/2011	Chris Carroll		Added column for CSSFileLocation
**		07/08/2013	Chris Carroll		New fields for CCRST152 CO/WY
**		09/25/2013  Moonray Schepart    New Field for CertificateSigningHashAlgorithm 
**		06/06/2014  Moonray Schepart    New Fields Enrollment Form Security when Authenticated
**										and For Idology Bypass when Authenticated 
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to RegistryOwner'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'RegistryOwner')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryOwner'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryOwner]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
	PRINT 'Creating Table: RegistryOwner'
		CREATE TABLE [dbo].[RegistryOwner](
		[RegistryOwnerID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerName] [varchar](255) NULL,
		[SourceCodeID] [int] NULL,
		[DisplaySearchPendingSignature] [bit] NULL,
		[DisplaySearchResultDateField] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		) ON [PRIMARY]
	END
	GRANT SELECT ON RegistryOwner TO PUBLIC
	
		-- check if RegistryOwnerIDologyActive
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IDologyActive'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologyActive'
			ALTER TABLE RegistryOwner
				ADD IDologyActive bit NULL
		END


		-- check if RegistryOwnerIDologyLogin
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IDologyLogin'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologyLogin'
			ALTER TABLE RegistryOwner
				ADD IDologyLogin nvarchar(200) NULL
		END

		-- check if RegistryOwnerIDologyPassword
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IDologyPassword'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologyPassword'
			ALTER TABLE RegistryOwner
				ADD IDologyPassword nvarchar(200) NULL
		END

		-- check if RegistryOwnerIDologySpLogin
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IDologySpLogin'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologySpLogin'
			ALTER TABLE RegistryOwner
				ADD IDologySpLogin nvarchar(200) NULL
		END

		-- check if RegistryOwnerIDologySpPassword
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IDologySpPassword'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologySpPassword'
			ALTER TABLE RegistryOwner
				ADD IDologySpPassword nvarchar(200) NULL
		END


		-- check if EnrollmentFormHideComments
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormHideComments'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormHideComments'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormHideComments bit NULL
		END
		
		-- check if EnrollmentFormDefaultStateSelection
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormDefaultStateSelection'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormDefaultStateSelection'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormDefaultStateSelection nvarchar(2) NULL
		END
		-- check if RegistryOwnerRouteName
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'RegistryOwnerRouteName'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerRouteName'
			ALTER TABLE RegistryOwner
				ADD RegistryOwnerRouteName nvarchar(50) NULL
		END
		
		-- check if CSSFileLocation
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'CSSFileLocation'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column CSSFileLocation'
			ALTER TABLE RegistryOwner
				ADD CSSFileLocation nvarchar(250) NULL
		END

		-- check if AllowDisplayNoDonors  
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'AllowDisplayNoDonors'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column AllowDisplayNoDonors'
			ALTER TABLE RegistryOwner
				ADD AllowDisplayNoDonors bit NULL
		END

		-- check if AllowDonorToPrintVerificationForm  
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'AllowDonorToPrintVerificationForm'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column AllowDonorToPrintVerificationForm'
			ALTER TABLE RegistryOwner
				ADD AllowDonorToPrintVerificationForm bit NULL
		END

		-- check if EnrollmentFormDisplayLicenseOrStateID 
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormDisplayLicenseOrStateID'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormDisplayLicenseOrStateID'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormDisplayLicenseOrStateID  bit NULL
		END


		-- check if EnrollmentFormLimitationsMaxLength   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormLimitationsMaxLength'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormLimitationsMaxLength'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormLimitationsMaxLength  int NULL
		END
				-- check if EnrollmentFormCommentsMaxLength   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormCommentsMaxLength'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormCommentsMaxLength'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormCommentsMaxLength  int NULL
		END
		
		-- check if CertificateSigningHashAlgorithm   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'CertificateSigningHashAlgorithm'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column CertificateSigningHashAlgorithm'
			ALTER TABLE RegistryOwner
				ADD CertificateSigningHashAlgorithm  nvarchar(50) NULL
		END

		-- check if CertificateSubject   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'CertificateSubject'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column CertificateSubject'
			ALTER TABLE RegistryOwner
				ADD CertificateSubject  nvarchar(200) NULL
		END

		-- check if IdologyUsesSSN
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IdologyUsesSSN'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column RegistryOwnerIDologyActive'
			ALTER TABLE RegistryOwner
				ADD IdologyUsesSSN bit NULL
		END

		-- check if IdologyActiveInPortal
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'IdologyActiveInPortal'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column IdologyActiveInPortal'
			ALTER TABLE RegistryOwner
				ADD IdologyActiveInPortal bit NULL default 1 -- active
		END

		-- check if EnrollmentFormIsPublic
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'EnrollmentFormIsPublic'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column EnrollmentFormIsPublic'
			ALTER TABLE RegistryOwner
				ADD EnrollmentFormIsPublic bit NULL default 1 -- public
		END		

		-- check if RegistryOwnerIDologyActive
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryOwner]')
			AND syscolumns.name = 'CaptchaOn'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryOwner Adding Column CaptchaOn'
			ALTER TABLE RegistryOwner
				ADD CaptchaOn bit NOT NULL DEFAULT 1
		END
GO