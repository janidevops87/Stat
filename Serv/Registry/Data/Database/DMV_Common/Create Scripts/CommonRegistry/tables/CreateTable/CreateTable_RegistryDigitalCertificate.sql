/******************************************************************************
**		File: CreateTable_RegistryDigitalCertificate.sql
**		Name: RegistryDigitalCertificate
**		Desc: Create table: RegistryDigitalCertificate
**
**		Auth: ccarroll
**		Date: 02/25/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/25/2009	ccarroll			initial
**		09/25/2013  mschepart			Added fields in support of Digital Signature
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegistryDigitalCertificate')
	BEGIN
		PRINT 'Table Exists: RegistryDigitalCertificate updating..'
		/*** Add Table script changes here ***/
		
	END  ELSE 
	BEGIN
	PRINT 'Creating Table: RegistryDigitalCertificate'
		CREATE TABLE [dbo].[RegistryDigitalCertificate](
		[RegistryDigitalCertificateID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryID] [int] NULL,
		[RegistryDigitalCertificateData] [varbinary] (8000) NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

	GRANT SELECT ON RegistryDigitalCertificate TO PUBLIC
	
		-- check if HashAlgorithmAtTimeofSigning 
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryDigitalCertificate]')
			AND syscolumns.name = 'HashAlgorithmAtTimeofSigning'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryDigitalCertificate Adding Column HashAlgorithmAtTimeofSigning'
			ALTER TABLE RegistryDigitalCertificate
				ADD HashAlgorithmAtTimeofSigning nvarchar(50) null
		END
		-- check if SignaturePublicKey   
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryDigitalCertificate]')
			AND syscolumns.name = 'SignaturePublicKey'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryDigitalCertificate Adding Column SignaturePublicKey'
			ALTER TABLE RegistryDigitalCertificate
				ADD SignaturePublicKey nvarchar(max) null
		END
		-- check if Signature    
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[RegistryDigitalCertificate]')
			AND syscolumns.name = 'Signature'
			)
		BEGIN
			PRINT 'ALTERING TABLE RegistryDigitalCertificate Adding Column Signature'
			ALTER TABLE RegistryDigitalCertificate
				ADD [Signature] varbinary(8000) null
		END
	GO