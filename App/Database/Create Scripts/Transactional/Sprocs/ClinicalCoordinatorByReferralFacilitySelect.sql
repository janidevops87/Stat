 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ClinicalCoordinatorByReferralFacilitySelect')
	BEGIN
		PRINT 'Dropping Procedure ClinicalCoordinatorByReferralFacilitySelect'
		DROP Procedure ClinicalCoordinatorByReferralFacilitySelect
	END
GO

PRINT 'Creating Procedure ClinicalCoordinatorByReferralFacilitySelect'
GO

CREATE PROCEDURE dbo.ClinicalCoordinatorByReferralFacilitySelect
(
	@OrganizationId int
)
AS

/***************************************************************************************************
**	Name: ClinicalCoordinatorByReferralFacilitySelect
**	Desc: Update Data in table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT
	Person.PersonID AS ListId, 
	IsNull(Person.PersonFirst + ' ', '') + IsNull(PersonLast, '') AS FieldValue
FROM Person 
	JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID 
WHERE Person.OrganizationID = @OrganizationId -- referring facility or TransplantCenter 
ORDER BY FieldValue ASC


GO

GRANT EXEC ON ClinicalCoordinatorByReferralFacilitySelect TO PUBLIC
GO


 