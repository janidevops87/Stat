 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorFluidBlood.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorFluidBlood**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorFluidBlood]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
   BEGIN drop procedure [dbo].[spi_Audit_TcssDonorFluidBlood]
   PRINT 'Drop Sproc: spi_Audit_TcssDonorFluidBlood'  
   END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorFluidBlood'  
 go
 create procedure "spi_Audit_TcssDonorFluidBlood"  
 (   @TcssDonorFluidBloodId int  
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
,@TcssListTotalParenteralNutritionId int   )  AS  
BEGIN 
insert into DBO.TcssDonorFluidBlood  (   "TcssDonorFluidBloodId" 
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
(    @TcssDonorFluidBloodId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@IvFluids  
,@TcssListDextroseInIvFluidsId  
,@TcssListSteroidId  
,@SteroidsDetail  
,@TcssListDiureticId  
,@TcssListT3Id  
,@TcssListT4Id  
,@TcssListInsulinId  
,@InsulinBeginDateTime  
,@InsulinEndDateTime  
,@TcssListAntihypertensiveId  
,@TcssListVasodilatorId  
,@TcssListDdavpId  
,@TcssListArginineVasopressinId  
,@ArginlineBeginDateTime  
,@ArginlineEndDateTime  
,@TotalParenteralNutrition  
,@OtherSpecify1  
,@OtherSpecify2  
,@OtherSpecify3  
,@TcssListNumberOfTransfusionId  
,@TcssListOtherBloodProductId  
,@OtherBloodProductsDetails  
,@DiureticDetail  
,@HeparinBeginDate  
,@HeparinEndDate  
,@HeparinDosage  
,@TcssListHeparinId  
,@TcssListTotalParenteralNutritionId   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  