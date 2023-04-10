IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerStateVerificationText]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	BEGIN
		PRINT 'Dropping Procedure GetRegistryOwnerStateVerificationText'
		DROP Procedure GetRegistryOwnerStateVerificationText
	END
GO

PRINT 'Creating Procedure GetRegistryOwnerStateVerificationText'
GO
CREATE Procedure GetRegistryOwnerStateVerificationText
(
		@RegistryOwnerStateConfigID int = null output,
		@RegistryOwnerID int = null,
		@RegistryOwnerStateID int = null,
		@RegistryOwnerStateAbbrv nvarchar(2) = null,
		@RegistryOwnerDMVSource nvarchar(10) = null
)
AS
/******************************************************************************
**	File: GetRegistryOwnerStateVerificationText.sql
**	Name: GetRegistryOwnerStateVerificationText
**	Desc: Selects multiple rows of RegistryOwnerStateConfig Based on Id  fields 
**	Auth: Chris Carroll
**	Date: 02/08/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	02/08/2010		Chris Carroll			Initial Sproc Creation
**	06/03/2014		Moonray Schepart		Added new parameter for MI_SOS Web Portal
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT TOP 1 
		RegistryOwnerStateConfig.RegistryOwnerStateConfigID,
		RegistryOwnerStateConfig.RegistryOwnerID,
		RegistryOwnerStateConfig.RegistryOwnerStateID,
		RegistryOwnerStateConfig.RegistryOwnerStateAbbrv,
		RegistryOwnerStateConfig.RegistryOwnerStateName,
		RegistryOwnerStateConfig.RegistryOwnerStateVerificationForm,
		RegistryOwnerStateConfig.RegistryOwnerStateDMVDSN,
		RegistryOwnerStateConfig.RegistryOwnerStateActive,
		RegistryOwnerStateConfig.CreateDate,
		RegistryOwnerStateConfig.LastModified,
		RegistryOwnerStateConfig.LastStatEmployeeID,
		RegistryOwnerStateConfig.AuditLogTypeID,
		RegistryOwnerStateConfig.lblStateIdText,
		RegistryOwnerStateConfig.lblLimitationsText,
		RegistryOwnerStateConfig.ContactInformationText,
		RegistryOwnerStateConfig.LegalHeaderText,
		RegistryOwnerStateConfig.LegalIntroText,
		RegistryOwnerStateConfig.LegalText,
		RegistryOwnerStateConfig.LegalDescriptionlText,
		RegistryOwnerStateConfig.WebLegalHeader,
		RegistryOwnerStateConfig.WebLegalIntroText,
		RegistryOwnerStateConfig.WebLegalText,
		RegistryOwnerStateConfig.WebLegalDescriptionlText
	FROM 
		dbo.RegistryOwnerStateConfig 
	WHERE 
		RegistryOwnerStateConfig.RegistryOwnerStateConfigID = COALESCE(@RegistryOwnerStateConfigID, RegistryOwnerStateConfig.RegistryOwnerStateConfigID)
	AND
		RegistryOwnerStateConfig.RegistryOwnerID = COALESCE(@RegistryOwnerID, RegistryOwnerStateConfig.RegistryOwnerID)
	AND
		RegistryOwnerStateConfig.RegistryOwnerStateID = COALESCE(@RegistryOwnerStateID, RegistryOwnerStateConfig.RegistryOwnerStateID)
	AND
		RegistryOwnerStateConfig.RegistryOwnerStateAbbrv = COALESCE(@RegistryOwnerStateAbbrv, RegistryOwnerStateConfig.RegistryOwnerStateAbbrv)
	AND
		RegistryOwnerStateConfig.RegistryOwnerStateDMVDSN = COALESCE(@RegistryOwnerDMVSource, RegistryOwnerStateConfig.RegistryOwnerStateDMVDSN)

	ORDER BY 1
GO
