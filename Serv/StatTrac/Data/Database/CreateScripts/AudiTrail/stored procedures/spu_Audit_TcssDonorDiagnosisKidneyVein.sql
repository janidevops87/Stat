 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisKidneyVein.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisKidneyVein**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisKidneyVein]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisKidneyVein]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisKidneyVein'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisKidneyVein'  
 go
   create procedure "spu_Audit_TcssDonorDiagnosisKidneyVein"  
   (   @TcssDonorDiagnosisKidneyVeinId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyVeinId int  
,@Length float  
,@Diameter float  
,@Distance float  
,@VeinsOnVenaCava int  
,@PKC1 int 
,@Bitmap binary(2)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListKidneyId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListKidneyVeinId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Length  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Diameter  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Distance  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --VeinsOnVenaCava  
)   
 begin   
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListKidneyVeinId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Length AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Diameter AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Distance AS VARCHAR(1)), '') 
+ ISNULL(CAST(@VeinsOnVenaCava AS VARCHAR(1)), '')
 insert into DBO.TcssDonorDiagnosisKidneyVein  
 (   "TcssDonorDiagnosisKidneyVeinId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyVeinId" 
,"Length" 
,"Diameter" 
,"Distance" 
,"VeinsOnVenaCava"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListKidneyId, 0) = 0 THEN -2 ELSE @TcssListKidneyId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListKidneyVeinId, 0) = 0 THEN -2 ELSE @TcssListKidneyVeinId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Length, 0) = 0 THEN -2 ELSE @Length END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Diameter, 0) = 0 THEN -2 ELSE @Diameter END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Distance, 0) = 0 THEN -2 ELSE @Distance END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@VeinsOnVenaCava, 0) = 0 THEN -2 ELSE @VeinsOnVenaCava END  ) 
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  