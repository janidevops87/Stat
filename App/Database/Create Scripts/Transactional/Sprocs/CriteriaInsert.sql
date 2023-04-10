

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaInsert')
	BEGIN
		PRINT 'Dropping Procedure CriteriaInsert'
		DROP Procedure CriteriaInsert
	END
GO

PRINT 'Creating Procedure CriteriaInsert'
GO
CREATE Procedure CriteriaInsert
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
**	File: CriteriaInsert.sql
**	Name: CriteriaInsert
**	Desc: Inserts Criteria Based on Id field 
**	Auth: ccarroll
**	Date: 12/17/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/17/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Criteria
	(
		CriteriaGroupName,
		DonorCategoryID,
		CriteriaMaleUpperAge,
		CriteriaMaleLowerAge,
		CriteriaFemaleUpperAge,
		CriteriaFemaleLowerAge,
		CriteriaGeneralRuleout,
		Unused1,
		CriteriaMaleNotAppropriate,
		LastModified,
		CriteriaFemaleNotAppropriate,
		CriteriaReferNonPotential,
		Unused2,
		CriteriaLowerWeight,
		CriteriaUpperWeight,
		CriteriaLowerAgeUnit,
		CriteriaDisableAppropriate,
		Unused3,
		Unused4,
		Unused5,
		Unused6,
		CriteriaMaleUpperAgeUnit,
		CriteriaMaleLowerAgeUnit,
		CriteriaFemaleUpperAgeUnit,
		CriteriaFemaleLowerAgeUnit,
		UpdatedFlag,
		DynamicDonorCategoryID,
		CriteriaStatus,
		WorkingStatusUpdatedFlag,
		WorkingCriteriaId,
		CriteriaDonorTracMap,
		LastStatEmployeeID,
		AuditLogTypeID,
		Inactive,
		DefaultGroupForSourceCode,
		CriteriaFetalDemiseUpperAge,
		CriteriaFetalDemiseLowerAge,
		CriteriaMaleUpperWeight,
		CriteriaMaleLowerWeight,
		CriteriaFemaleUpperWeight,
		CriteriaFemaleLowerWeight,
		CriteriaFetalDemiseUpperWeight,
		CriteriaFetalDemiseLowerWeight,
		CriteriaMaleUpperWeightUnit,
		CriteriaMaleLowerWeightUnit,
		CriteriaFemaleUpperWeightUnit,
		CriteriaFemaleLowerWeightUnit,
		CriteriaFetalDemiseUpperWeightUnit,
		CriteriaFetalDemiseLowerWeightUnit
	)
VALUES
	(
		@CriteriaGroupName,
		@DonorCategoryID,
		@CriteriaMaleUpperAge,
		@CriteriaMaleLowerAge,
		@CriteriaFemaleUpperAge,
		@CriteriaFemaleLowerAge,
		@CriteriaGeneralRuleout,
		@Unused1,
		@CriteriaMaleNotAppropriate,
		@LastModified,
		@CriteriaFemaleNotAppropriate,
		@CriteriaReferNonPotential,
		@Unused2,
		@CriteriaLowerWeight,
		@CriteriaUpperWeight,
		@CriteriaLowerAgeUnit,
		@CriteriaDisableAppropriate,
		@Unused3,
		@Unused4,
		@Unused5,
		@Unused6,
		@CriteriaMaleUpperAgeUnit,
		@CriteriaMaleLowerAgeUnit,
		@CriteriaFemaleUpperAgeUnit,
		@CriteriaFemaleLowerAgeUnit,
		@UpdatedFlag,
		@DynamicDonorCategoryID,
		@CriteriaStatus,
		@WorkingStatusUpdatedFlag,
		@WorkingCriteriaId,
		@CriteriaDonorTracMap,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */,
		@Inactive,
		@DefaultGroupForSourceCode,
		@CriteriaFetalDemiseUpperAge,
		@CriteriaFetalDemiseLowerAge,
		@CriteriaMaleUpperWeight,
		@CriteriaMaleLowerWeight,
		@CriteriaFemaleUpperWeight,
		@CriteriaFemaleLowerWeight,
		@CriteriaFetalDemiseUpperWeight,
		@CriteriaFetalDemiseLowerWeight,
		@CriteriaMaleUpperWeightUnit,
		@CriteriaMaleLowerWeightUnit,
		@CriteriaFemaleUpperWeightUnit,
		@CriteriaFemaleLowerWeightUnit,
		@CriteriaFetalDemiseUpperWeightUnit,
		@CriteriaFetalDemiseLowerWeightUnit
	)

SET @CriteriaID = SCOPE_IDENTITY()

EXEC CriteriaSelect @CriteriaID

GO

GRANT EXEC ON CriteriaInsert TO PUBLIC
GO
