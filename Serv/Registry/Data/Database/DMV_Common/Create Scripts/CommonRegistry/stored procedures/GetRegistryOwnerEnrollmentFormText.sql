IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerEnrollmentFormText]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	BEGIN
		PRINT 'Dropping Procedure GetRegistryOwnerEnrollmentFormText'
		DROP Procedure GetRegistryOwnerEnrollmentFormText
	END
GO

PRINT 'Creating Procedure GetRegistryOwnerEnrollmentFormText'
GO
CREATE Procedure GetRegistryOwnerEnrollmentFormText
(
		@RegistryOwnerID int = null,
		@LanguageCode nvarchar(2) = null
			
)
AS
/******************************************************************************
**	File: GetRegistryOwnerEnrollmentFormText.sql
**	Name: GetRegistryOwnerEnrollmentFormText
**	Desc: Selects single row of RegistryOwnerEnrollmentFormText
**	Auth: ccarroll
**	Date: 2/8/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	2/8/2010		ccarroll			Initial Sproc Creation
**	3/21/2011		ccarroll			Added DivFooter column
**  7/11/2013		ccarroll			Added columns for CCRST152 (CO/WY)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT TOP 1 
		RegistryOwnerEnrollmentText.ID,
		RegistryOwnerEnrollmentText.RegistryOwnerID,
		RegistryOwnerEnrollmentText.LanguageCode,
		RegistryOwnerEnrollmentText.HeaderImageURL,
		RegistryOwnerEnrollmentText.HeaderImageWidth,
		RegistryOwnerEnrollmentText.HeaderImageHeight,
		RegistryOwnerEnrollmentText.DivInstruction,
		RegistryOwnerEnrollmentText.DivRegistrationSelection,
		RegistryOwnerEnrollmentText.LblSelectOne,
		RegistryOwnerEnrollmentText.RdoAdd,
		RegistryOwnerEnrollmentText.RdoRemove,
		RegistryOwnerEnrollmentText.DivNameInstruction,
		RegistryOwnerEnrollmentText.LblFirstName,
		RegistryOwnerEnrollmentText.LblLastName,
		RegistryOwnerEnrollmentText.LblMiddleName,
		RegistryOwnerEnrollmentText.LblGender,
		RegistryOwnerEnrollmentText.RdoMale,
		RegistryOwnerEnrollmentText.RdoFemale,
		RegistryOwnerEnrollmentText.LblDateOfBirth,
		RegistryOwnerEnrollmentText.DivResidentialAddress,
		RegistryOwnerEnrollmentText.LblStreetAddress,
		RegistryOwnerEnrollmentText.LblAddress2,
		RegistryOwnerEnrollmentText.LblCityStateZip,
		RegistryOwnerEnrollmentText.DivContactInformation,
		RegistryOwnerEnrollmentText.LblEmailAddress,
		RegistryOwnerEnrollmentText.DivEmailConfirmation,
		RegistryOwnerEnrollmentText.DivSSN,
		RegistryOwnerEnrollmentText.LblLastFourSSN,
		RegistryOwnerEnrollmentText.DivLimitations,
		RegistryOwnerEnrollmentText.DivLimitationsInstructions,
		RegistryOwnerEnrollmentText.LblEventCategoryMessage,
		RegistryOwnerEnrollmentText.LblComment,
		RegistryOwnerEnrollmentText.DivInformationContacts,
		RegistryOwnerEnrollmentText.DivSubmitInstruction,
		RegistryOwnerEnrollmentText.BtnRegisterNow,
		RegistryOwnerEnrollmentText.ConfirmationPanelAdd,
		RegistryOwnerEnrollmentText.ConfirmationPanelRemove,
		coalesce(RegistryOwnerEnrollmentText.DivFooter, '') AS DivFooter,
		RegistryOwnerEnrollmentText.LastModified,
		RegistryOwnerEnrollmentText.LastStatEmployeeID,
		RegistryOwnerEnrollmentText.AuditLogTypeID,
		coalesce(RegistryOwnerEnrollmentText.DivCityStateZipText, '') AS DivCityStateZipText,
		coalesce(RegistryOwnerEnrollmentText.DivStateIdInformation, '') AS DivStateIdInformation,
		coalesce(RegistryOwnerEnrollmentText.LblLicenseOrStateID, '') AS LblLicenseOrStateID

	FROM 
		dbo.RegistryOwnerEnrollmentText
	WHERE 
		RegistryOwnerEnrollmentText.RegistryOwnerID = coalesce(@RegistryOwnerID, RegistryOwnerEnrollmentText.RegistryOwnerID)
	AND
		RegistryOwnerEnrollmentText.LanguageCode = coalesce(@LanguageCode, RegistryOwnerEnrollmentText.LanguageCode)

	ORDER BY 1
GO
