IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorFluidBloodInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorFluidBloodInsert'
		DROP Procedure TcssDonorFluidBloodInsert
	END
GO

PRINT 'Creating Procedure TcssDonorFluidBloodInsert'
GO

CREATE PROCEDURE dbo.TcssDonorFluidBloodInsert
(
	@TcssDonorFluidBloodId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@IvFluids varchar(50) = null,
	@TcssListDextroseInIvFluidsId int = null,
	@TcssListSteroidId int = null,
	@SteroidsDetail varchar(50) = null,
	@TcssListDiureticId int = null,
	@DiureticDetail varchar(50) = null,
	@TcssListT3Id int = null,
	@TcssListT4Id int = null,
	@TcssListInsulinId int = null,
	@InsulinBeginDateTime smalldatetime = null,
	@InsulinEndDateTime smalldatetime = null,
	@TcssListAntihypertensiveId int = null,
	@TcssListVasodilatorId int = null,
	@TcssListDdavpId int = null,
	@TcssListArginineVasopressinId int = null,
	@ArginlineBeginDateTime smalldatetime = null,
	@ArginlineEndDateTime smalldatetime = null,
	@TotalParenteralNutrition varchar(50) = null,
	@OtherSpecify1 varchar(40) = null,
	@OtherSpecify2 varchar(40) = null,
	@OtherSpecify3 varchar(40) = null,
	@TcssListNumberOfTransfusionId int = null,
	@TcssListOtherBloodProductId int = null,
	@OtherBloodProductsDetails varchar(500) = null,
	@HeparinId int = null,
    @HeparinBeginDate smalldatetime = null,
    @HeparinEndDate smalldatetime = null,
    @HeparinDosage varchar(50) = null,
    @TcssListHeparinId int = null,
    @TcssListTotalParenteralNutritionId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorFluidBloodInsert
**	Desc: Insert Data into table TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  11/2010     jth				added heparin fields
**   5/11		jth				added @TcssListTotalParenteralNutrition
***************************************************************************************************/

INSERT INTO dbo.TcssDonorFluidBlood
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	IvFluids,
	TcssListDextroseInIvFluidsId,
	TcssListSteroidId,
	SteroidsDetail,
	TcssListDiureticId,
	DiureticDetail,
	TcssListT3Id,
	TcssListT4Id,
	TcssListInsulinId,
	InsulinBeginDateTime,
	InsulinEndDateTime,
	TcssListAntihypertensiveId,
	TcssListVasodilatorId,
	TcssListDdavpId,
	TcssListArginineVasopressinId,
	ArginlineBeginDateTime,
	ArginlineEndDateTime,
	TotalParenteralNutrition,
	OtherSpecify1,
	OtherSpecify2,
	OtherSpecify3,
	TcssListNumberOfTransfusionId,
	TcssListOtherBloodProductId,
	OtherBloodProductsDetails,
    HeparinBeginDate,
    HeparinEndDate,
    HeparinDosage,
    TcssListHeparinId,
    TcssListTotalParenteralNutritionId
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@IvFluids,
	@TcssListDextroseInIvFluidsId,
	@TcssListSteroidId,
	@SteroidsDetail,
	@TcssListDiureticId,
	@DiureticDetail,
	@TcssListT3Id,
	@TcssListT4Id,
	@TcssListInsulinId,
	@InsulinBeginDateTime,
	@InsulinEndDateTime,
	@TcssListAntihypertensiveId,
	@TcssListVasodilatorId,
	@TcssListDdavpId,
	@TcssListArginineVasopressinId,
	@ArginlineBeginDateTime,
	@ArginlineEndDateTime,
	@TotalParenteralNutrition,
	@OtherSpecify1,
	@OtherSpecify2,
	@OtherSpecify3,
	@TcssListNumberOfTransfusionId,
	@TcssListOtherBloodProductId,
	@OtherBloodProductsDetails,
    @HeparinBeginDate,
    @HeparinEndDate,
    @HeparinDosage,
    @TcssListHeparinId,
    @TcssListTotalParenteralNutritionId
)

-- Return the new identity value
SET @TcssDonorFluidBloodId = @@Identity

GO

GRANT EXEC ON TcssDonorFluidBloodInsert TO PUBLIC
GO
