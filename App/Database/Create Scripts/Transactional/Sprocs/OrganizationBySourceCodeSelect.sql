IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'OrganizationBySourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationBySourceCodeSelect'
		DROP Procedure OrganizationBySourceCodeSelect
	END
GO

PRINT 'Creating Procedure OrganizationBySourceCodeSelect'
GO

CREATE PROCEDURE dbo.OrganizationBySourceCodeSelect
(
	@SourceCodeId int
)
AS

/***************************************************************************************************
**	Name: OrganizationBySourceCodeSelect
**	Desc: Update Data in table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SELECT
	Organization.OrganizationID AS ListId,
	Organization.OrganizationName AS FieldValue
FROM SourceCodeOrganization 
	JOIN Organization ON SourceCodeOrganization.OrganizationID = Organization.OrganizationID  
	WHERE SourceCodeOrganization.SourceCodeID = @SourceCodeId 
ORDER BY Organization.OrganizationName ASC
GO

GRANT EXEC ON OrganizationBySourceCodeSelect TO PUBLIC
GO
