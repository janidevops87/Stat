IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorFluidBloodUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorFluidBloodUpdate'
		DROP Procedure TcssDonorFluidBloodUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorFluidBloodUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorFluidBloodUpdate
(
	@TcssDonorFluidBloodId int,
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
    @HeparinBeginDate smalldatetime = null,
    @HeparinEndDate smalldatetime = null,
    @HeparinDosage varchar(50) = null,
    @TcssListHeparinId int = null,
    @TcssListTotalParenteralNutritionId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorFluidBloodUpdate
**	Desc: Update Data in table TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  11/2010     jth				added heparin fields
**   5/11		jth				added @TcssListTotalParenteralNutrition
***************************************************************************************************/

UPDATE dbo.TcssDonorFluidBlood
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	IvFluids = @IvFluids,
	TcssListDextroseInIvFluidsId = @TcssListDextroseInIvFluidsId,
	TcssListSteroidId = @TcssListSteroidId,
	SteroidsDetail = @SteroidsDetail,
	TcssListDiureticId = @TcssListDiureticId,
	DiureticDetail = @DiureticDetail,
	TcssListT3Id = @TcssListT3Id,
	TcssListT4Id = @TcssListT4Id,
	TcssListInsulinId = @TcssListInsulinId,
	InsulinBeginDateTime = @InsulinBeginDateTime,
	InsulinEndDateTime = @InsulinEndDateTime,
	TcssListAntihypertensiveId = @TcssListAntihypertensiveId,
	TcssListVasodilatorId = @TcssListVasodilatorId,
	TcssListDdavpId = @TcssListDdavpId,
	TcssListArginineVasopressinId = @TcssListArginineVasopressinId,
	ArginlineBeginDateTime = @ArginlineBeginDateTime,
	ArginlineEndDateTime = @ArginlineEndDateTime,
	TotalParenteralNutrition = @TotalParenteralNutrition,
	OtherSpecify1 = @OtherSpecify1,
	OtherSpecify2 = @OtherSpecify2,
	OtherSpecify3 = @OtherSpecify3,
	TcssListNumberOfTransfusionId = @TcssListNumberOfTransfusionId,
	TcssListOtherBloodProductId = @TcssListOtherBloodProductId,
	OtherBloodProductsDetails = @OtherBloodProductsDetails,
    HeparinBeginDate = @HeparinBeginDate,
    HeparinEndDate = @HeparinEndDate,
    HeparinDosage = @HeparinDosage,
    TcssListHeparinId = @TcssListHeparinId,
    TcssListTotalParenteralNutritionId = @TcssListTotalParenteralNutritionId
WHERE
	TcssDonorFluidBloodId = @TcssDonorFluidBloodId
GO

GRANT EXEC ON TcssDonorFluidBloodUpdate TO PUBLIC
GO
