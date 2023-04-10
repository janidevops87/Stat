 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisLung.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisLung**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
   SET ANSI_NULLS ON     
go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisLung]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisLung]PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisLung'  END   
go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisLung'  
go
   create procedure "spu_Audit_TcssDonorDiagnosisLung"  (   @TcssDonorDiagnosisLungId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@DateIntubated datetime  
,@LengthOfRightLung decimal  
,@LengthOfLeftLung decimal  
,@AorticKnobWidth decimal  
,@DiaphragmWidth decimal  
,@DistanceRcpaToLcpa decimal  
,@ChestCircLandmark decimal  
,@TcssListDiagnosisLungChestXrayId int  
,@LeftLungComments varchar(500) 
,@RightLungComments varchar(5000) 
,@DonorPredictedTotalLungCapacity decimal  
,@PKC1 int 
,@Bitmap binary(3)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --DateIntubated  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --LengthOfRightLung  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --LengthOfLeftLung  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AorticKnobWidth  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --DiaphragmWidth  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --DistanceRcpaToLcpa  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --ChestCircLandmark  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListDiagnosisLungChestXrayId  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --LeftLungComments  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --RightLungComments  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --DonorPredictedTotalLungCapacity  
 )   
 begin
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DateIntubated AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LengthOfRightLung AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LengthOfLeftLung AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AorticKnobWidth AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DiaphragmWidth AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DistanceRcpaToLcpa AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ChestCircLandmark AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDiagnosisLungChestXrayId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LeftLungComments AS VARCHAR(1)), '') 
+ ISNULL(CAST(@RightLungComments AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DonorPredictedTotalLungCapacity AS VARCHAR(1)), '')
   insert into DBO.TcssDonorDiagnosisLung  (   "TcssDonorDiagnosisLungId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"DateIntubated" 
,"LengthOfRightLung" 
,"LengthOfLeftLung" 
,"AorticKnobWidth" 
,"DiaphragmWidth" 
,"DistanceRcpaToLcpa" 
,"ChestCircLandmark" 
,"TcssListDiagnosisLungChestXrayId" 
,"LeftLungComments" 
,"RightLungComments" 
,"DonorPredictedTotalLungCapacity"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@DateIntubated, '') = '' THEN '1900-01-01'  ELSE @DateIntubated END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LengthOfRightLung, 0) = 0 THEN -2 ELSE @LengthOfRightLung END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LengthOfLeftLung, 0) = 0 THEN -2 ELSE @LengthOfLeftLung END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@AorticKnobWidth, 0) = 0 THEN -2 ELSE @AorticKnobWidth END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@DiaphragmWidth, 0) = 0 THEN -2 ELSE @DiaphragmWidth END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@DistanceRcpaToLcpa, 0) = 0 THEN -2 ELSE @DistanceRcpaToLcpa END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@ChestCircLandmark, 0) = 0 THEN -2 ELSE @ChestCircLandmark END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListDiagnosisLungChestXrayId, 0) = 0 THEN -2 ELSE @TcssListDiagnosisLungChestXrayId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@LeftLungComments, '') = '' THEN 'ILB'  ELSE @LeftLungComments END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@RightLungComments, '') = '' THEN 'ILB'  ELSE @RightLungComments END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@DonorPredictedTotalLungCapacity, 0) = 0 THEN -2 ELSE @DonorPredictedTotalLungCapacity END  )  
END    
go
  SET QUOTED_IDENTIFIER OFF   
go
  SET ANSI_NULLS ON   
go
  