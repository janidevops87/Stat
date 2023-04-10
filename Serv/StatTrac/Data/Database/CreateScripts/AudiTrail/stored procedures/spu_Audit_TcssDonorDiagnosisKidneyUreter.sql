 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisKidneyUreter.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisKidneyUreter**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisKidneyUreter]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisKidneyUreter]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisKidneyUreter'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisKidneyUreter'  
 go
   create procedure "spu_Audit_TcssDonorDiagnosisKidneyUreter"  
   (   @TcssDonorDiagnosisKidneyUreterId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyUreterId int  
,@Length float  
,@TcssListKidneyUreterTissueQualityId int  
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListKidneyId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListKidneyUreterId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Length  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --TcssListKidneyUreterTissueQualityId   
)   
 begin  
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyUreterId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Length AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyUreterTissueQualityId AS VARCHAR(1)), '')

 insert into DBO.TcssDonorDiagnosisKidneyUreter  
 (   "TcssDonorDiagnosisKidneyUreterId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyUreterId" 
,"Length" 
,"TcssListKidneyUreterTissueQualityId"  )  
VALUES   (   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListKidneyId, 0) = 0 THEN -2 ELSE @TcssListKidneyId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListKidneyUreterId, 0) = 0 THEN -2 ELSE @TcssListKidneyUreterId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Length, 0) = 0 THEN -2 ELSE @Length END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@TcssListKidneyUreterTissueQualityId, 0) = 0 THEN -2 ELSE @TcssListKidneyUreterTissueQualityId END  ) 
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  