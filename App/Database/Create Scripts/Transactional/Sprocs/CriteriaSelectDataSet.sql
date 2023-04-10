  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'CriteriaSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSelectDataSet'
		DROP Procedure CriteriaSelectDataSet
	END
GO

PRINT 'Creating Procedure CriteriaSelectDataSet'
GO

CREATE PROCEDURE dbo.CriteriaSelectDataSet
(
	@CriteriaID int = null,
	@DonorCategoryID int = null
)
AS
/***************************************************************************************************
**	Name: CriteriaSelectDataSet
**	Desc: Select Data for Criteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	12/14/2009	ccarroll		Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
***************************************************************************************************/
	EXEC dbo.CriteriaSelect @CriteriaID, @DonorCategoryID
	EXEC dbo.CriteriaSourceCodeSelect 0, @CriteriaID
	EXEC dbo.CriteriaAgeUnitSelect 
	EXEC dbo.CriteriaWeightUnitSelect
	EXEC dbo.CriteriaOrganizationSelect @CriteriaID
	
GO

GRANT EXEC ON CriteriaSelectDataSet TO PUBLIC
GO   