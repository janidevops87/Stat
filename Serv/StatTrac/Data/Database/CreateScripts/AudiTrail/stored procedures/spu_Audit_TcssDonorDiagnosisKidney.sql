 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisKidney.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisKidney**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON     
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisKidney]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisKidney]
PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisKidney'  
END   
go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisKidney'  
 go
  create procedure "spu_Audit_TcssDonorDiagnosisKidney"  (   @TcssDonorDiagnosisKidneyId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyAorticCuffId int  
,@TcssListKidneyFullVenaId int  
,@Length float  
,@Width float  
,@TcssListKidneyAorticPlaqueId int  
,@TcssListKidneyArterialPlaqueId int  
,@TcssListKidneyInfarctedAreaId int  
,@TcssListKidneyCapsularTearId int  
,@TcssListKidneySubcapsularId int  
,@TcssListKidneyHematomaId int  
,@TcssListKidneyFatCleanedId int  
,@TcssListKidneyCystsDiscolorationId int  
,@TcssListKidneyHorseshoeShapeId int  
,@TcssListKidneyRecoveryBiopsyId int  
,@GlomeruliObserved varchar(50) 
,@GlomeruliSclerosed varchar(50) 
,@SclerosedPercent decimal  
,@TcssListKidneyBiopsyId int  
,@Comment varchar(5000) 
,@TcssListKidneyPumpDeviceId int  
,@TcssListKidneyPumpSolutionId int  
,@BiopsyType varchar(20) 
,@PKC1 int 
,@Bitmap binary(4)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListKidneyId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListKidneyAorticCuffId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListKidneyFullVenaId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Length  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Width  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --TcssListKidneyAorticPlaqueId  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListKidneyArterialPlaqueId  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListKidneyInfarctedAreaId  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --TcssListKidneyCapsularTearId  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --TcssListKidneySubcapsularId  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListKidneyHematomaId  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListKidneyFatCleanedId  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --TcssListKidneyCystsDiscolorationId  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --TcssListKidneyHorseshoeShapeId  
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --TcssListKidneyRecoveryBiopsyId  
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --GlomeruliObserved  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --GlomeruliSclerosed  
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --SclerosedPercent  
AND SUBSTRING(@Bitmap, 3, 1) & 64 <> 64 --TcssListKidneyBiopsyId  
AND SUBSTRING(@Bitmap, 3, 1) & 128 <> 128 --Comment  
AND SUBSTRING(@Bitmap, 4, 1) & 1 <> 1 --TcssListKidneyPumpDeviceId  
AND SUBSTRING(@Bitmap, 4, 1) & 2 <> 2 --TcssListKidneyPumpSolutionId  
AND SUBSTRING(@Bitmap, 4, 1) & 4 <> 4 --BiopsyType   
)   
 begin   
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyAorticCuffId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyFullVenaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Length AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Width AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyAorticPlaqueId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyArterialPlaqueId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyInfarctedAreaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyCapsularTearId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneySubcapsularId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyHematomaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyFatCleanedId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyCystsDiscolorationId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyHorseshoeShapeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyRecoveryBiopsyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@GlomeruliObserved AS VARCHAR(1)), '') 
+ ISNULL(CAST(@GlomeruliSclerosed AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SclerosedPercent AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyBiopsyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comment AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyPumpDeviceId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyPumpSolutionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@BiopsyType AS VARCHAR(1)), '')

 insert into DBO.TcssDonorDiagnosisKidney  
 (   "TcssDonorDiagnosisKidneyId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyAorticCuffId" 
,"TcssListKidneyFullVenaId" 
,"Length" 
,"Width" 
,"TcssListKidneyAorticPlaqueId" 
,"TcssListKidneyArterialPlaqueId" 
,"TcssListKidneyInfarctedAreaId" 
,"TcssListKidneyCapsularTearId" 
,"TcssListKidneySubcapsularId" 
,"TcssListKidneyHematomaId" 
,"TcssListKidneyFatCleanedId" 
,"TcssListKidneyCystsDiscolorationId" 
,"TcssListKidneyHorseshoeShapeId" 
,"TcssListKidneyRecoveryBiopsyId" 
,"GlomeruliObserved" 
,"GlomeruliSclerosed" 
,"SclerosedPercent" 
,"TcssListKidneyBiopsyId" 
,"Comment" 
,"TcssListKidneyPumpDeviceId" 
,"TcssListKidneyPumpSolutionId" 
,"BiopsyType"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListKidneyId, 0) = 0 THEN -2 ELSE @TcssListKidneyId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListKidneyAorticCuffId, 0) = 0 THEN -2 ELSE @TcssListKidneyAorticCuffId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListKidneyFullVenaId, 0) = 0 THEN -2 ELSE @TcssListKidneyFullVenaId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Length, 0) = 0 THEN -2 ELSE @Length END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Width, 0) = 0 THEN -2 ELSE @Width END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@TcssListKidneyAorticPlaqueId, 0) = 0 THEN -2 ELSE @TcssListKidneyAorticPlaqueId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListKidneyArterialPlaqueId, 0) = 0 THEN -2 ELSE @TcssListKidneyArterialPlaqueId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListKidneyInfarctedAreaId, 0) = 0 THEN -2 ELSE @TcssListKidneyInfarctedAreaId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@TcssListKidneyCapsularTearId, 0) = 0 THEN -2 ELSE @TcssListKidneyCapsularTearId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@TcssListKidneySubcapsularId, 0) = 0 THEN -2 ELSE @TcssListKidneySubcapsularId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListKidneyHematomaId, 0) = 0 THEN -2 ELSE @TcssListKidneyHematomaId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListKidneyFatCleanedId, 0) = 0 THEN -2 ELSE @TcssListKidneyFatCleanedId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@TcssListKidneyCystsDiscolorationId, 0) = 0 THEN -2 ELSE @TcssListKidneyCystsDiscolorationId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@TcssListKidneyHorseshoeShapeId, 0) = 0 THEN -2 ELSE @TcssListKidneyHorseshoeShapeId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@TcssListKidneyRecoveryBiopsyId, 0) = 0 THEN -2 ELSE @TcssListKidneyRecoveryBiopsyId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@GlomeruliObserved, '') = '' THEN 'ILB'  ELSE @GlomeruliObserved END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@GlomeruliSclerosed, '') = '' THEN 'ILB'  ELSE @GlomeruliSclerosed END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@SclerosedPercent, 0) = 0 THEN -2 ELSE @SclerosedPercent END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@TcssListKidneyBiopsyId, 0) = 0 THEN -2 ELSE @TcssListKidneyBiopsyId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 128 = 128 AND ISNULL(@Comment, '') = '' THEN 'ILB'  ELSE @Comment END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 1 = 1 AND ISNULL(@TcssListKidneyPumpDeviceId, 0) = 0 THEN -2 ELSE @TcssListKidneyPumpDeviceId END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 2 = 2 AND ISNULL(@TcssListKidneyPumpSolutionId, 0) = 0 THEN -2 ELSE @TcssListKidneyPumpSolutionId END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 4 = 4 AND ISNULL(@BiopsyType, '') = '' THEN 'ILB'  ELSE @BiopsyType END  )  
END    
go
SET QUOTED_IDENTIFIER OFF   
go
SET ANSI_NULLS ON   
go
  