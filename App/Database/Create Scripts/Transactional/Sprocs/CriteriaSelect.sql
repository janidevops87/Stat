

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSelect'
		DROP Procedure CriteriaSelect
	END
GO

PRINT 'Creating Procedure CriteriaSelect'
GO
CREATE Procedure CriteriaSelect
(
		@CriteriaID int = null output,
		@DonorCategoryID int = null
)
AS
/******************************************************************************
**	File: CriteriaSelect.sql
**	Name: CriteriaSelect
**	Desc: Selects multiple rows of Criteria Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
**  06/16/2011		ccarroll			Changed criteria status to 1 --Current
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

IF @CriteriaID = 0
	BEGIN
		SET @CriteriaID = Null
	END

IF @DonorCategoryID = 0
	BEGIN
		SET @DonorCategoryID = Null
	END

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
		Criteria.CriteriaDonorTracMap,
		Criteria.LastStatEmployeeID,
		Criteria.AuditLogTypeID,
		Criteria.Inactive,
		Criteria.DefaultGroupForSourceCode,
		Criteria.CriteriaFetalDemiseUpperAge,
		Criteria.CriteriaFetalDemiseLowerAge,
		Criteria.CriteriaMaleUpperWeight,
		Criteria.CriteriaMaleLowerWeight,
		Criteria.CriteriaFemaleUpperWeight,
		Criteria.CriteriaFemaleLowerWeight,
		Criteria.CriteriaFetalDemiseUpperWeight,
		Criteria.CriteriaFetalDemiseLowerWeight,
		Criteria.CriteriaMaleUpperWeightUnit,
		Criteria.CriteriaMaleLowerWeightUnit,
		Criteria.CriteriaFemaleUpperWeightUnit,
		Criteria.CriteriaFemaleLowerWeightUnit,
		Criteria.CriteriaFetalDemiseUpperWeightUnit,
		Criteria.CriteriaFetalDemiseLowerWeightUnit
	FROM 
		dbo.Criteria 
	WHERE
		Criteria.CriteriaStatus = CASE WHEN ISNULL(@CriteriaID, 0 ) = 0 Then 1 ELSE  Criteria.CriteriaStatus END--Current
	AND 
		Criteria.CriteriaID = ISNULL(@CriteriaID, Criteria.CriteriaID)
	AND
		Criteria.DonorCategoryID = ISNULL(@DonorCategoryID, Criteria.DonorCategoryID)
	ORDER BY 2
GO

GRANT EXEC ON CriteriaSelect TO PUBLIC
GO
