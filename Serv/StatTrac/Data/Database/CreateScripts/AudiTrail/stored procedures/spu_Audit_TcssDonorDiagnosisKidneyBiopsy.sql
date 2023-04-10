 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisKidneyBiopsy.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisKidneyBiopsy**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
   SET ANSI_NULLS ON     
go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisKidneyBiopsy]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
   BEGIN drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisKidneyBiopsy]
   PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisKidneyBiopsy'  
   END   
go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisKidneyBiopsy'  
go
   create procedure "spu_Audit_TcssDonorDiagnosisKidneyBiopsy"  
 (   @TcssDonorDiagnosisKidneyBiopsyId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@DateTime datetime  
,@Flow varchar(50) 
,@PressureSystolic varchar(50) 
,@PressureDiastolic varchar(50) 
,@Resistance varchar(50) 
,@PKC1 int 
,@Bitmap binary(2)  )  AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListKidneyId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --DateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Flow  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --PressureSystolic  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --PressureDiastolic  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --Resistance   
)   
BEGIN
DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Flow AS VARCHAR(1)), '') 
+ ISNULL(CAST(@PressureSystolic AS VARCHAR(1)), '') 
+ ISNULL(CAST(@PressureDiastolic AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Resistance AS VARCHAR(1)), '')
insert into DBO.TcssDonorDiagnosisKidneyBiopsy  
(   "TcssDonorDiagnosisKidneyBiopsyId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"DateTime" 
,"Flow" 
,"PressureSystolic" 
,"PressureDiastolic" 
,"Resistance"  )  VALUES   (   @PKC1, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListKidneyId, 0) = 0 THEN -2 ELSE @TcssListKidneyId END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@DateTime, '') = '' THEN '1900-01-01'  ELSE @DateTime END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Flow, '') = '' THEN 'ILB'  ELSE @Flow END, CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@PressureSystolic, '') = '' THEN 'ILB'  ELSE @PressureSystolic END, CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@PressureDiastolic, '') = '' THEN 'ILB'  ELSE @PressureDiastolic END, CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@Resistance, '') = '' THEN 'ILB'  ELSE @Resistance END  )  END    
go
  SET QUOTED_IDENTIFIER OFF   
go
  SET ANSI_NULLS ON   
go
  