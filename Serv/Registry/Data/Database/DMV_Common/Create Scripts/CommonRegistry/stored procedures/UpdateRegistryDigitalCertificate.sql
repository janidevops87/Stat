 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistryDigitalCertificate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistryDigitalCertificate]
	PRINT 'Dropping Procedure: UpdateRegistryDigitalCertificate'
END
	PRINT 'Creating Procedure: UpdateRegistryDigitalCertificate'
GO

CREATE PROCEDURE [dbo].[UpdateRegistryDigitalCertificate]
(
	@RegistryID int = NULL,
	@RegistryDigitalCertificateData varbinary(8000) = NULL,
	@LastStatEmployeeID int = NULL,
	@HashAlgorithmAtTimeOfSigning nvarchar(50),
	@SignaturePublicKey nvarchar(max),
	@Signature varbinary(8000)
)
/******************************************************************************
**		File: UpdateRegistryDigitalCertificate.sql
**		Name: UpdateRegistryDigitalCertificate
**		Desc: Common Registry: NEOB
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	ccarroll	initial
**		09/25/2013	mschepart	Added fields for Digital Signature
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [RegistryDigitalCertificate]
	SET
		[RegistryDigitalCertificateData] = @RegistryDigitalCertificateData,
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = @LastStatEmployeeID,
		[AuditLogTypeID] = 3,  --Modify
		[HashAlgorithmAtTimeofSigning] = @HashAlgorithmAtTimeOfSigning,
		[SignaturePublicKey] = @SignaturePublicKey,
		[Signature] = @Signature
	WHERE 
		[RegistryID] = @RegistryID

	RETURN @@Error
GO