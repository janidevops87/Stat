IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwner]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryOwner]
	PRINT 'Dropping Procedure: GetRegistryOwner'
END
	PRINT 'Creating Procedure: GetRegistryOwner'
GO

CREATE PROCEDURE [dbo].[GetRegistryOwner]
(
	@RegistryOwnerID int = NULL,
	@RegistryOwnerRouteName nvarchar(50)
)
/******************************************************************************
**		File: GetRegistryOwner.sql
**		Name: GetRegistryOwner
**		Desc:  Common Web Registry
**
**		Called by:  
**              
**
**		Auth: Chris Carroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		02/19/2009	Chris Carroll		initial
**		02/18/2010  Chris Carroll		added IDology to select
**		01/07/2011  Chris Carroll		added configurable fields for Enrollment form
**		03/17/2011	Chris Carroll		added CSSFileLocation
**		07/08/2013	Chris Carroll		Changes for CCRST152 - CO/WY
**		09/26/2013	Moonray Schepart	Added fields to support Digital Signing
**		06/05/2014	Moonray Schepart	Added Table to support Enrollment Form Security
*******************************************************************************/
AS

IF @RegistryOwnerID = 0
BEGIN
	SELECT @RegistryOwnerID = Null
END

IF LEN(@RegistryOwnerRouteName) = 0
BEGIN
	SELECT @RegistryOwnerRouteName = Null
END

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	SET NOCOUNT ON;

	SELECT
		[RegistryOwnerID],
		[RegistryOwnerName],
		[SourceCodeID],
		[DisplaySearchPendingSignature],
		[DisplaySearchResultDateField],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		coalesce([IDologyActive], 0) AS IDologyActive,
		[IDologyLogin],
		[IDologyPassword],
		[IDologySpLogin],
		[IDologySpPassword],
		coalesce([EnrollmentFormHideComments], 0) AS EnrollmentFormHideComments,
		coalesce([EnrollmentFormDefaultStateSelection], '') AS EnrollmentFormDefaultStateSelection,
		[RegistryOwnerRouteName],
		coalesce([CSSFileLocation], '') AS CSSFileLocation,
		coalesce([AllowDisplayNoDonors], 0) AS AllowDisplayNoDonors, --if null, set false as default
		coalesce([AllowDonorToPrintVerificationForm], 0) AS AllowDonorToPrintVerificationForm, --if null, set false as default
		coalesce([EnrollmentFormDisplayLicenseOrStateID], 0) AS EnrollmentFormDisplayLicenseOrStateID, --if null, set false as default
		coalesce([EnrollmentFormLimitationsMaxLength], 200) AS EnrollmentFormLimitationsMaxLength, --if null set 200 as default
		coalesce([EnrollmentFormCommentsMaxLength], 100) AS EnrollmentFormCommentsMaxLength, -- if null, set 100 as default
		[CertificateSigningHashAlgorithm],
		[CertificateSubject],
		[IdologyUsesSSN],
		COALESCE([IdologyActiveInPortal],1) AS IdologyActiveInPortal, -- if null, default to 1 (active)
		COALESCE([EnrollmentFormIsPublic],1) AS EnrollmentFormIsPublic -- if null, default to 1 (public)
	
	FROM
			[RegistryOwner]
	WHERE 
		[RegistryOwnerID] = coalesce(@RegistryOwnerID, RegistryOwnerID) AND
		[RegistryOwnerRouteName] = coalesce(@RegistryOwnerRouteName, RegistryOwnerRouteName);


	RETURN @@Error;
GO