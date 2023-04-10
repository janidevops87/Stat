

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectCriteria')
	BEGIN
		PRINT 'Dropping Procedure SelectCriteria'
		PRINT GETDATE()
		DROP Procedure SelectCriteria
	END
GO

PRINT 'Creating Procedure SelectCriteria'
PRINT GETDATE()
GO
CREATE Procedure SelectCriteria
(
		@CriteriaID int = null output,
		@DonorCategoryID int = null,
		@DynamicDonorCategoryID int = null,
		@WorkingCriteriaId int = null					
)
AS
/******************************************************************************
**	File: SelectCriteria.sql
**	Name: SelectCriteria
**	Desc: Selects multiple rows of Criteria Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Criteria.CriteriaID,
		Criteria.CriteriaGroupName,
		Criteria.DonorCategoryID,
		Criteria.CriteriaMaleUpperAge,
		Criteria.CriteriaMaleLowerAge,
		Criteria.CriteriaFemaleUpperAge,
		Criteria.CriteriaFemaleLowerAge,
		Criteria.CriteriaGeneralRuleout,
		Criteria.Unused1,
		Criteria.CriteriaMaleNotAppropriate,
		Criteria.LastModified,
		Criteria.CriteriaFemaleNotAppropriate,
		Criteria.CriteriaReferNonPotential,
		Criteria.Unused2,
		Criteria.CriteriaLowerWeight,
		Criteria.CriteriaUpperWeight,
		Criteria.CriteriaLowerAgeUnit,
		Criteria.CriteriaDisableAppropriate,
		Criteria.Unused3,
		Criteria.Unused4,
		Criteria.Unused5,
		Criteria.Unused6,
		Criteria.CriteriaMaleUpperAgeUnit,
		Criteria.CriteriaMaleLowerAgeUnit,
		Criteria.CriteriaFemaleUpperAgeUnit,
		Criteria.CriteriaFemaleLowerAgeUnit,
		Criteria.UpdatedFlag,
		Criteria.DynamicDonorCategoryID,
		Criteria.CriteriaStatus,
		Criteria.WorkingStatusUpdatedFlag,
		Criteria.WorkingCriteriaId,
		Criteria.CriteriaDonorTracMap
	FROM 
		dbo.Criteria 
	WHERE 
		Criteria.CriteriaID = ISNULL(@CriteriaID, Criteria.CriteriaID)
	AND
		Criteria.DonorCategoryID = ISNULL(@DonorCategoryID, Criteria.DonorCategoryID)
	AND
		Criteria.DynamicDonorCategoryID = ISNULL(@DynamicDonorCategoryID, Criteria.DynamicDonorCategoryID)
	AND
		Criteria.WorkingCriteriaId = ISNULL(@WorkingCriteriaId, Criteria.WorkingCriteriaId)				

GO

GRANT EXEC ON SelectCriteria TO PUBLIC
GO
