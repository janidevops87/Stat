 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorMedSoc.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorMedSoc**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorMedSoc]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorMedSoc]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorMedSoc'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorMedSoc'  
 GO
   create procedure "spu_Audit_TcssDonorMedSoc"  
   (   
   @TcssDonorMedSocId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListHistoryOfDiabetesId int  
,@TcssListHistoryOfCancerId int  
,@TcssListHypertensionHistoryId int  
,@TcssListCompliantWithTreatmentId int  
,@TcssListHistoryOfCoronaryArteryDiseaseId int  
,@TcssListHistoryOfGastrointestinalDiseaseId int  
,@TcssListChestTraumaId int  
,@TcssListCigaretteUseId int  
,@TcssListCigaretteUseContinuedId int  
,@TcssListOtherDrugUseId int  
,@TcssListHeavyAlcoholUseId int  
,@TcssListDonorMeetCdcGuidelinesId int  
,@Comments varchar(5000) 
,@PKC1 int 
,@Bitmap binary(3)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListHistoryOfDiabetesId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListHistoryOfCancerId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListHypertensionHistoryId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --TcssListCompliantWithTreatmentId  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TcssListHistoryOfCoronaryArteryDiseaseId  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --TcssListHistoryOfGastrointestinalDiseaseId  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListChestTraumaId  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListCigaretteUseId  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --TcssListCigaretteUseContinuedId  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --TcssListOtherDrugUseId  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListHeavyAlcoholUseId  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListDonorMeetCdcGuidelinesId  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --Comments   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHistoryOfDiabetesId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHistoryOfCancerId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHypertensionHistoryId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCompliantWithTreatmentId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHistoryOfCoronaryArteryDiseaseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHistoryOfGastrointestinalDiseaseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListChestTraumaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCigaretteUseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCigaretteUseContinuedId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListOtherDrugUseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHeavyAlcoholUseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorMeetCdcGuidelinesId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comments AS VARCHAR(1)), '')
   insert into DBO.TcssDonorMedSoc  
   (   "TcssDonorMedSocId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListHistoryOfDiabetesId" 
,"TcssListHistoryOfCancerId" 
,"TcssListHypertensionHistoryId" 
,"TcssListCompliantWithTreatmentId" 
,"TcssListHistoryOfCoronaryArteryDiseaseId" 
,"TcssListHistoryOfGastrointestinalDiseaseId" 
,"TcssListChestTraumaId" 
,"TcssListCigaretteUseId" 
,"TcssListCigaretteUseContinuedId" 
,"TcssListOtherDrugUseId" 
,"TcssListHeavyAlcoholUseId" 
,"TcssListDonorMeetCdcGuidelinesId" 
,"Comments"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListHistoryOfDiabetesId, 0) = 0 THEN -2 ELSE @TcssListHistoryOfDiabetesId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListHistoryOfCancerId, 0) = 0 THEN -2 ELSE @TcssListHistoryOfCancerId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListHypertensionHistoryId, 0) = 0 THEN -2 ELSE @TcssListHypertensionHistoryId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@TcssListCompliantWithTreatmentId, 0) = 0 THEN -2 ELSE @TcssListCompliantWithTreatmentId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TcssListHistoryOfCoronaryArteryDiseaseId, 0) = 0 THEN -2 ELSE @TcssListHistoryOfCoronaryArteryDiseaseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@TcssListHistoryOfGastrointestinalDiseaseId, 0) = 0 THEN -2 ELSE @TcssListHistoryOfGastrointestinalDiseaseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListChestTraumaId, 0) = 0 THEN -2 ELSE @TcssListChestTraumaId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListCigaretteUseId, 0) = 0 THEN -2 ELSE @TcssListCigaretteUseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@TcssListCigaretteUseContinuedId, 0) = 0 THEN -2 ELSE @TcssListCigaretteUseContinuedId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@TcssListOtherDrugUseId, 0) = 0 THEN -2 ELSE @TcssListOtherDrugUseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListHeavyAlcoholUseId, 0) = 0 THEN -2 ELSE @TcssListHeavyAlcoholUseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListDonorMeetCdcGuidelinesId, 0) = 0 THEN -2 ELSE @TcssListDonorMeetCdcGuidelinesId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@Comments, '') = '' THEN 'ILB'  ELSE @Comments END  ) 
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  