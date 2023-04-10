IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorFluidBloodSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorFluidBloodSelect'
		DROP Procedure TcssDonorFluidBloodSelect
	END
GO

PRINT 'Creating Procedure TcssDonorFluidBloodSelect'
GO

CREATE PROCEDURE dbo.TcssDonorFluidBloodSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorFluidBloodSelect
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

SELECT 
	tdfb.TcssDonorFluidBloodId,
	tdfb.LastUpdateStatEmployeeId,
	tdfb.LastUpdateDate,
	tdfb.TcssDonorId,
	tdfb.IvFluids,
	tdfb.TcssListDextroseInIvFluidsId,
	tdfb.TcssListSteroidId,
	tdfb.SteroidsDetail,
	tdfb.TcssListDiureticId,
	tdfb.DiureticDetail,
	tdfb.TcssListT3Id,
	tdfb.TcssListT4Id,
	tdfb.TcssListInsulinId,
	tdfb.InsulinBeginDateTime,
	tdfb.InsulinEndDateTime,
	tdfb.TcssListAntihypertensiveId,
	tdfb.TcssListVasodilatorId,
	tdfb.TcssListDdavpId,
	tdfb.TcssListArginineVasopressinId,
	tdfb.ArginlineBeginDateTime,
	tdfb.ArginlineEndDateTime,
	tdfb.TotalParenteralNutrition,
	tdfb.OtherSpecify1,
	tdfb.OtherSpecify2,
	tdfb.OtherSpecify3,
	tdfb.TcssListNumberOfTransfusionId,
	tdfb.TcssListOtherBloodProductId,
	tdfb.OtherBloodProductsDetails,
    tdfb.HeparinBeginDate,
    tdfb.HeparinEndDate,
    tdfb.HeparinDosage,
    tdfb.TcssListHeparinId,
    tdfb.TcssListTotalParenteralNutritionId
FROM dbo.TcssDonorFluidBlood tdfb
WHERE
	tdfb.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorFluidBloodSelect TO PUBLIC
GO
