
IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaUpdate'
		DROP Procedure CriteriaUpdate
	END
GO

PRINT 'Creating Procedure CriteriaUpdate'
GO
CREATE Procedure CriteriaUpdate
(
		@CriteriaID int = null output,
		@CriteriaGroupName varchar(80) = null,
		@DonorCategoryID int = null,
		@CriteriaMaleUpperAge smallint = null,
		@CriteriaMaleLowerAge smallint = null,
		@CriteriaFemaleUpperAge smallint = null,
		@CriteriaFemaleLowerAge smallint = null,
		@CriteriaGeneralRuleout varchar(255) = null,
		@Unused1 varchar(255) = null,
		@CriteriaMaleNotAppropriate smallint = null,
		@LastModified datetime = null,
		@CriteriaFemaleNotAppropriate smallint = null,
		@CriteriaReferNonPotential smallint = null,
		@Unused2 smallint = null,
		@CriteriaLowerWeight float = null,
		@CriteriaUpperWeight float = null,
		@CriteriaLowerAgeUnit varchar(6) = null,
		@CriteriaDisableAppropriate smallint = null,
		@Unused3 smallint = null,
		@Unused4 smallint = null,
		@Unused5 smallint = null,
		@Unused6 smallint = null,
		@CriteriaMaleUpperAgeUnit varchar(6) = null,
		@CriteriaMaleLowerAgeUnit varchar(6) = null,
		@CriteriaFemaleUpperAgeUnit varchar(6) = null,
		@CriteriaFemaleLowerAgeUnit varchar(6) = null,
		@UpdatedFlag smallint = null,
		@DynamicDonorCategoryID int = null,
		@CriteriaStatus smallint = null,
		@WorkingStatusUpdatedFlag smallint = null,
		@WorkingCriteriaId int = null,
		@CriteriaDonorTracMap int = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@Inactive smallint = null,
		@DefaultGroupForSourceCode smallint = null,
		@CriteriaFetalDemiseUpperAge int = null,
		@CriteriaFetalDemiseLowerAge int = null,
		@CriteriaMaleUpperWeight float = null,
		@CriteriaMaleLowerWeight float = null,
		@CriteriaFemaleUpperWeight float = null,
		@CriteriaFemaleLowerWeight float = null,
		@CriteriaFetalDemiseUpperWeight float = null,
		@CriteriaFetalDemiseLowerWeight float = null,
		@CriteriaMaleUpperWeightUnit nvarchar(20) = null,
		@CriteriaMaleLowerWeightUnit nvarchar(20) = null,
		@CriteriaFemaleUpperWeightUnit nvarchar(20) = null,
		@CriteriaFemaleLowerWeightUnit nvarchar(20) = null,
		@CriteriaFetalDemiseUpperWeightUnit nvarchar(20) = null,
		@CriteriaFetalDemiseLowerWeightUnit nvarchar(20) = null					
)
AS
/******************************************************************************
**	File: CriteriaUpdate.sql
**	Name: CriteriaUpdate
**	Desc: Updates Criteria Based on Id field 
**	Auth: ccarroll
**	Date: 1/20/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/20/2010		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.Criteria 	
SET 
		CriteriaGroupName = @CriteriaGroupName,
		DonorCategoryID = @DonorCategoryID,
		CriteriaMaleUpperAge = @CriteriaMaleUpperAge,
		CriteriaMaleLowerAge = @CriteriaMaleLowerAge,
		CriteriaFemaleUpperAge = @CriteriaFemaleUpperAge,
		CriteriaFemaleLowerAge = @CriteriaFemaleLowerAge,
		CriteriaGeneralRuleout = @CriteriaGeneralRuleout,
		Unused1 = @Unused1,
		CriteriaMaleNotAppropriate = @CriteriaMaleNotAppropriate,
		LastModified = GetDate(),
		CriteriaFemaleNotAppropriate = @CriteriaFemaleNotAppropriate,
		CriteriaReferNonPotential = @CriteriaReferNonPotential,
		Unused2 = @Unused2,
		CriteriaLowerWeight = @CriteriaLowerWeight,
		CriteriaUpperWeight = @CriteriaUpperWeight,
		CriteriaLowerAgeUnit = @CriteriaLowerAgeUnit,
		CriteriaDisableAppropriate = @CriteriaDisableAppropriate,
		Unused3 = @Unused3,
		Unused4 = @Unused4,
		Unused5 = @Unused5,
		Unused6 = @Unused6,
		CriteriaMaleUpperAgeUnit = @CriteriaMaleUpperAgeUnit,
		CriteriaMaleLowerAgeUnit = @CriteriaMaleLowerAgeUnit,
		CriteriaFemaleUpperAgeUnit = @CriteriaFemaleUpperAgeUnit,
		CriteriaFemaleLowerAgeUnit = @CriteriaFemaleLowerAgeUnit,
		UpdatedFlag = @UpdatedFlag,
		DynamicDonorCategoryID = @DynamicDonorCategoryID,
		CriteriaStatus = @CriteriaStatus,
		WorkingStatusUpdatedFlag = @WorkingStatusUpdatedFlag,
		WorkingCriteriaId = @WorkingCriteriaId,
		CriteriaDonorTracMap = @CriteriaDonorTracMap,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */,
		Inactive = @Inactive,
		DefaultGroupForSourceCode = @DefaultGroupForSourceCode,
		CriteriaFetalDemiseUpperAge = @CriteriaFetalDemiseUpperAge,
		CriteriaFetalDemiseLowerAge = @CriteriaFetalDemiseLowerAge,
		CriteriaMaleUpperWeight = @CriteriaMaleUpperWeight,
		CriteriaMaleLowerWeight = @CriteriaMaleLowerWeight,
		CriteriaFemaleUpperWeight = @CriteriaFemaleUpperWeight,
		CriteriaFemaleLowerWeight = @CriteriaFemaleLowerWeight,
		CriteriaFetalDemiseUpperWeight = @CriteriaFetalDemiseUpperWeight,
		CriteriaFetalDemiseLowerWeight = @CriteriaFetalDemiseLowerWeight,
		CriteriaMaleUpperWeightUnit = @CriteriaMaleUpperWeightUnit,
		CriteriaMaleLowerWeightUnit = @CriteriaMaleLowerWeightUnit,
		CriteriaFemaleUpperWeightUnit = @CriteriaFemaleUpperWeightUnit,
		CriteriaFemaleLowerWeightUnit = @CriteriaFemaleLowerWeightUnit,
		CriteriaFetalDemiseUpperWeightUnit = @CriteriaFetalDemiseUpperWeightUnit,
		CriteriaFetalDemiseLowerWeightUnit = @CriteriaFetalDemiseLowerWeightUnit
WHERE 
	CriteriaID = @CriteriaID 				

GO

GRANT EXEC ON CriteriaUpdate TO PUBLIC
GO
