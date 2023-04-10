IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerEnrollmentConfirmationText]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	BEGIN
		PRINT 'Dropping Procedure GetRegistryOwnerEnrollmentConfirmationText'
		DROP Procedure GetRegistryOwnerEnrollmentConfirmationText
	END
GO

PRINT 'Creating Procedure GetRegistryOwnerEnrollmentConfirmationText'
GO
CREATE Procedure GetRegistryOwnerEnrollmentConfirmationText
(
		@RegistryOwnerID int = null,
		@LanguageCode nvarchar(2) = null
			
)
AS
/******************************************************************************
**	File: GetRegistryOwnerEnrollmentConfirmationText.sql
**	Name: GetRegistryOwnerEnrollmentConfirmationText
**	Desc: Selects single row of RegistryOwnerEnrollmentText
**	Auth: ccarroll
**	Date: 2/8/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	2/8/2010		ccarroll		Initial Sproc Creation
**	3/21/2011		ccarroll		Added DivFooter column
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT TOP 1
		RegistryOwnerEnrollmentText.ID,
		RegistryOwnerEnrollmentText.RegistryOwnerID,
		RegistryOwnerEnrollmentText.LanguageCode,
		RegistryOwnerEnrollmentText.ConfirmationPanelAdd,
		RegistryOwnerEnrollmentText.ConfirmationPanelRemove,
		IsNull(RegistryOwnerEnrollmentText.DivFooter, '') AS DivFooter,
		RegistryOwnerEnrollmentText.LastModified,
		RegistryOwnerEnrollmentText.LastStatEmployeeID,
		RegistryOwnerEnrollmentText.AuditLogTypeID
	FROM 
		dbo.RegistryOwnerEnrollmentText
	WHERE 
		RegistryOwnerEnrollmentText.RegistryOwnerID = ISNULL(@RegistryOwnerID, RegistryOwnerEnrollmentText.RegistryOwnerID)
	AND
		RegistryOwnerEnrollmentText.LanguageCode = ISNULL(@LanguageCode, RegistryOwnerEnrollmentText.LanguageCode)
 
	ORDER BY 1
GO
