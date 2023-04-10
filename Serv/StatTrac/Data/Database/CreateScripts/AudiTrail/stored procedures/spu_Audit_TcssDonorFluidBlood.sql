 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorFluidBlood.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorFluidBlood**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
GO   
SET ANSI_NULLS ON    
GO   
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorFluidBlood]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
BEGIN drop procedure [dbo].[spu_Audit_TcssDonorFluidBlood]
PRINT 'Drop Sproc: spu_Audit_TcssDonorFluidBlood'  
END   
GO 
PRINT 'Create Sproc: spu_Audit_TcssDonorFluidBlood'  
GO   
create procedure "spu_Audit_TcssDonorFluidBlood"  (   @TcssDonorFluidBloodId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@IvFluids varchar(50) 
,@TcssListDextroseInIvFluidsId int  
,@TcssListSteroidId int  
,@SteroidsDetail varchar(50) 
,@TcssListDiureticId int  
,@TcssListT3Id int  
,@TcssListT4Id int  
,@TcssListInsulinId int  
,@InsulinBeginDateTime smalldatetime  
,@InsulinEndDateTime smalldatetime  
,@TcssListAntihypertensiveId int  
,@TcssListVasodilatorId int  
,@TcssListDdavpId int  
,@TcssListArginineVasopressinId int  
,@ArginlineBeginDateTime smalldatetime  
,@ArginlineEndDateTime smalldatetime  
,@TotalParenteralNutrition varchar(50) 
,@OtherSpecify1 varchar(40) 
,@OtherSpecify2 varchar(40) 
,@OtherSpecify3 varchar(40) 
,@TcssListNumberOfTransfusionId int  
,@TcssListOtherBloodProductId int  
,@OtherBloodProductsDetails varchar(500) 
,@DiureticDetail varchar(50) 
,@HeparinBeginDate smalldatetime  
,@HeparinEndDate smalldatetime  
,@HeparinDosage varchar(50) 
,@TcssListHeparinId int  
,@TcssListTotalParenteralNutritionId int  
,@PKC1 int 
,@Bitmap binary(5)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --IvFluids  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListDextroseInIvFluidsId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListSteroidId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --SteroidsDetail  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TcssListDiureticId  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --TcssListT3Id  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListT4Id  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListInsulinId  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --InsulinBeginDateTime  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --InsulinEndDateTime  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListAntihypertensiveId  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListVasodilatorId  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --TcssListDdavpId  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --TcssListArginineVasopressinId  
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --ArginlineBeginDateTime  
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --ArginlineEndDateTime  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --TotalParenteralNutrition  
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --OtherSpecify1  
AND SUBSTRING(@Bitmap, 3, 1) & 64 <> 64 --OtherSpecify2  
AND SUBSTRING(@Bitmap, 3, 1) & 128 <> 128 --OtherSpecify3  
AND SUBSTRING(@Bitmap, 4, 1) & 1 <> 1 --TcssListNumberOfTransfusionId  
AND SUBSTRING(@Bitmap, 4, 1) & 2 <> 2 --TcssListOtherBloodProductId  
AND SUBSTRING(@Bitmap, 4, 1) & 4 <> 4 --OtherBloodProductsDetails  
AND SUBSTRING(@Bitmap, 4, 1) & 8 <> 8 --DiureticDetail  
AND SUBSTRING(@Bitmap, 4, 1) & 16 <> 16 --HeparinBeginDate  
AND SUBSTRING(@Bitmap, 4, 1) & 32 <> 32 --HeparinEndDate  
AND SUBSTRING(@Bitmap, 4, 1) & 64 <> 64 --HeparinDosage  
AND SUBSTRING(@Bitmap, 4, 1) & 128 <> 128 --TcssListHeparinId  
AND SUBSTRING(@Bitmap, 5, 1) & 1 <> 1 --TcssListTotalParenteralNutritionId   
)   
BEGIN   
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@IvFluids AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDextroseInIvFluidsId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListSteroidId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SteroidsDetail AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDiureticId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListT3Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListT4Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListInsulinId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@InsulinBeginDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@InsulinEndDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListAntihypertensiveId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListVasodilatorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDdavpId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListArginineVasopressinId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ArginlineBeginDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ArginlineEndDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TotalParenteralNutrition AS VARCHAR(1)), '') 
+ ISNULL(CAST(@OtherSpecify1 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@OtherSpecify2 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@OtherSpecify3 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListNumberOfTransfusionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListOtherBloodProductId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@OtherBloodProductsDetails AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DiureticDetail AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HeparinBeginDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HeparinEndDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HeparinDosage AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHeparinId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListTotalParenteralNutritionId AS VARCHAR(1)), '')
insert into DBO.TcssDonorFluidBlood  
(   "TcssDonorFluidBloodId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"IvFluids" 
,"TcssListDextroseInIvFluidsId" 
,"TcssListSteroidId" 
,"SteroidsDetail" 
,"TcssListDiureticId" 
,"TcssListT3Id" 
,"TcssListT4Id" 
,"TcssListInsulinId" 
,"InsulinBeginDateTime" 
,"InsulinEndDateTime" 
,"TcssListAntihypertensiveId" 
,"TcssListVasodilatorId" 
,"TcssListDdavpId" 
,"TcssListArginineVasopressinId" 
,"ArginlineBeginDateTime" 
,"ArginlineEndDateTime" 
,"TotalParenteralNutrition" 
,"OtherSpecify1" 
,"OtherSpecify2" 
,"OtherSpecify3" 
,"TcssListNumberOfTransfusionId" 
,"TcssListOtherBloodProductId" 
,"OtherBloodProductsDetails" 
,"DiureticDetail" 
,"HeparinBeginDate" 
,"HeparinEndDate" 
,"HeparinDosage" 
,"TcssListHeparinId" 
,"TcssListTotalParenteralNutritionId"  )  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END,  
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END,  
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END,  
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@IvFluids, '') = '' THEN 'ILB'  ELSE @IvFluids END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListDextroseInIvFluidsId, 0) = 0 THEN -2 ELSE @TcssListDextroseInIvFluidsId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListSteroidId, 0) = 0 THEN -2 ELSE @TcssListSteroidId END,  
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@SteroidsDetail, '') = '' THEN 'ILB'  ELSE @SteroidsDetail END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TcssListDiureticId, 0) = 0 THEN -2 ELSE @TcssListDiureticId END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@TcssListT3Id, 0) = 0 THEN -2 ELSE @TcssListT3Id END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListT4Id, 0) = 0 THEN -2 ELSE @TcssListT4Id END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListInsulinId, 0) = 0 THEN -2 ELSE @TcssListInsulinId END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@InsulinBeginDateTime, '') = '' THEN '1900-01-01'  ELSE @InsulinBeginDateTime END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@InsulinEndDateTime, '') = '' THEN '1900-01-01'  ELSE @InsulinEndDateTime END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListAntihypertensiveId, 0) = 0 THEN -2 ELSE @TcssListAntihypertensiveId END,  
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListVasodilatorId, 0) = 0 THEN -2 ELSE @TcssListVasodilatorId END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@TcssListDdavpId, 0) = 0 THEN -2 ELSE @TcssListDdavpId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@TcssListArginineVasopressinId, 0) = 0 THEN -2 ELSE @TcssListArginineVasopressinId END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@ArginlineBeginDateTime, '') = '' THEN '1900-01-01'  ELSE @ArginlineBeginDateTime END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@ArginlineEndDateTime, '') = '' THEN '1900-01-01'  ELSE @ArginlineEndDateTime END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@TotalParenteralNutrition, '') = '' THEN 'ILB'  ELSE @TotalParenteralNutrition END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@OtherSpecify1, '') = '' THEN 'ILB'  ELSE @OtherSpecify1 END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@OtherSpecify2, '') = '' THEN 'ILB'  ELSE @OtherSpecify2 END,  
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 128 = 128 AND ISNULL(@OtherSpecify3, '') = '' THEN 'ILB'  ELSE @OtherSpecify3 END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 1 = 1 AND ISNULL(@TcssListNumberOfTransfusionId, 0) = 0 THEN -2 ELSE @TcssListNumberOfTransfusionId END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 2 = 2 AND ISNULL(@TcssListOtherBloodProductId, 0) = 0 THEN -2 ELSE @TcssListOtherBloodProductId END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 4 = 4 AND ISNULL(@OtherBloodProductsDetails, '') = '' THEN 'ILB'  ELSE @OtherBloodProductsDetails END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 8 = 8 AND ISNULL(@DiureticDetail, '') = '' THEN 'ILB'  ELSE @DiureticDetail END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 16 = 16 AND ISNULL(@HeparinBeginDate, '') = '' THEN '1900-01-01'  ELSE @HeparinBeginDate END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 32 = 32 AND ISNULL(@HeparinEndDate, '') = '' THEN '1900-01-01'  ELSE @HeparinEndDate END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 64 = 64 AND ISNULL(@HeparinDosage, '') = '' THEN 'ILB'  ELSE @HeparinDosage END,  
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 128 = 128 AND ISNULL(@TcssListHeparinId, 0) = 0 THEN -2 ELSE @TcssListHeparinId END,  
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 1 = 1 AND ISNULL(@TcssListTotalParenteralNutritionId, 0) = 0 THEN -2 ELSE @TcssListTotalParenteralNutritionId END
)
END

GO  

SET QUOTED_IDENTIFIER OFF   
GO  

SET ANSI_NULLS ON   
GO  