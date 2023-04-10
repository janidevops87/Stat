 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistryDigitalCertificate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistryDigitalCertificate]
			PRINT 'Dropping Procedure: InsertRegistryDigitalCertificate'
	END

PRINT 'Creating Procedure: InsertRegistryDigitalCertificate'
GO

CREATE PROCEDURE [dbo].[InsertRegistryDigitalCertificate]
(
	@RegistryDigitalCertificateID int = NULL OUTPUT,
	@RegistryID int = NULL,
	@RegistryDigitalCertificateData varbinary(8000) = NULL,
	@LastStatEmployeeID int = NULL,
	@HashAlgorithmAtTimeOfSigning nvarchar(50),
	@SignaturePublicKey nvarchar(max),
	@Signature varbinary(8000)
)
/******************************************************************************
**		File: InsertRegistryDigitalCertificate.sql
**		Name: InsertRegistryDigitalCertificate
**		Desc: Common Registry: NEOB
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 01/23/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	ccarroll	initial
**		09/25/2013	mschepart	Added fields for Digital Signature
*******************************************************************************/
AS
	SET NOCOUNT ON;

	INSERT INTO [RegistryDigitalCertificate]
	(
		[RegistryID],
		[RegistryDigitalCertificateData],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[HashAlgorithmAtTimeofSigning],
		[SignaturePublicKey],
		[Signature]
	)
	VALUES
	(
		@RegistryID,
		@RegistryDigitalCertificateData,
		GetDate(),
		GetDate(),
		@LastStatEmployeeID,
		1 , --Create, AuditLogTypeID
		@HashAlgorithmAtTimeOfSigning,
		@SignaturePublicKey,
		@Signature
	);

	SELECT @RegistryDigitalCertificateID = SCOPE_IDENTITY();

	RETURN @@Error;
GO