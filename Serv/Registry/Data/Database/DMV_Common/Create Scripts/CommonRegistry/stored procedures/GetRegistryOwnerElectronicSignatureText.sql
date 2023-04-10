
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerElectronicSignatureText]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	BEGIN
		PRINT 'Dropping Procedure GetRegistryOwnerElectronicSignatureText'
		DROP Procedure GetRegistryOwnerElectronicSignatureText
	END
GO

PRINT 'Creating Procedure GetRegistryOwnerElectronicSignatureText'
GO
CREATE Procedure GetRegistryOwnerElectronicSignatureText
(
		@RegistryOwnerID int = null,
		@LanguageCode nvarchar(2) = null					
)
AS
/******************************************************************************
**	File: GetRegistryOwnerElectronicSignatureText.sql
**	Name: GetRegistryOwnerElectronicSignatureText
**	Desc: Selects multiple rows of GetRegistryOwnerElectronicSignatureText Based on Id  fields 
**	Auth: ccarroll
**	Date: 2/8/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	2/8/2010		ccarroll			Initial Sproc Creation
**	3/21/2011		ccarroll			Added column DivFooter
**	07/12/2013		ccarroll			Added AddDivConfirmationNotes, RemoveDivConfirmationNotes
**	08/31/2015		mmaitan				Added EmailMailboxAccount
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT TOP 1
		RegistryOwnerElectronicSignatureText.ID,
		RegistryOwnerElectronicSignatureText.RegistryOwnerID,
		RegistryOwnerElectronicSignatureText.LanguageCode,
		RegistryOwnerElectronicSignatureText.LblName,
		RegistryOwnerElectronicSignatureText.LblAddress,
		RegistryOwnerElectronicSignatureText.LblEmail,
		RegistryOwnerElectronicSignatureText.AddLblConfirmation,
		RegistryOwnerElectronicSignatureText.AddCbxConfirmation,
		RegistryOwnerElectronicSignatureText.AddBtnRegistration,
		RegistryOwnerElectronicSignatureText.AddEmailSubject,
		RegistryOwnerElectronicSignatureText.AddEmailBody,
		RegistryOwnerElectronicSignatureText.AddEmailInvitationSubject,
		RegistryOwnerElectronicSignatureText.AddEmailInvitationBody,
		RegistryOwnerElectronicSignatureText.RemoveLblConfirmation,
		RegistryOwnerElectronicSignatureText.RemoveCbxConfirmation,
		RegistryOwnerElectronicSignatureText.RemoveBtnRegistration,
		RegistryOwnerElectronicSignatureText.RemoveEmailSubject,
		RegistryOwnerElectronicSignatureText.RemoveEmailBody,
		RegistryOwnerElectronicSignatureText.EmailFrom,
		RegistryOwnerElectronicSignatureText.CertificateAuthority,
		RegistryOwnerElectronicSignatureText.FailureMessage,
		coalesce(RegistryOwnerElectronicSignatureText.DivFooter, '') AS DivFooter,
		RegistryOwnerElectronicSignatureText.LastModified,
		RegistryOwnerElectronicSignatureText.LastStatEmployeeID,
		RegistryOwnerElectronicSignatureText.AuditLogTypeID,
		coalesce(RegistryOwnerElectronicSignatureText.AddDivConfirmationNotes, '') AS AddDivConfirmationNotes,
		coalesce(RegistryOwnerElectronicSignatureText.RemoveDivConfirmationNotes, '') AS RemoveDivConfirmationNotes,
		RegistryOwnerElectronicSignatureText.EmailMailboxAccount
	FROM RegistryOwnerElectronicSignatureText
	
	WHERE 
		RegistryOwnerElectronicSignatureText.RegistryOwnerID = coalesce(@RegistryOwnerID, RegistryOwnerElectronicSignatureText.RegistryOwnerID)
	AND
		RegistryOwnerElectronicSignatureText.LanguageCode = coalesce(@LanguageCode, RegistryOwnerElectronicSignatureText.LanguageCode)
	
	ORDER BY 1
GO
