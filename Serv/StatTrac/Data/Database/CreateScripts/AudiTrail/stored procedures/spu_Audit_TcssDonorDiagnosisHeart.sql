 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisHeart.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisHeart**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisHeart]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisHeart]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisHeart'  
 END   
 go 
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisHeart'  
 go   
 create procedure "spu_Audit_TcssDonorDiagnosisHeart"  
 (   @TcssDonorDiagnosisHeartId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@LvEjectionFraction decimal  
,@TcssListDiagnosisHeartMethodId int  
,@ShorteningFraction decimal  
,@SeptalWallThickness int  
,@LvPosteriorWallThickness int  
,@Comment varchar(5000) 
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LvEjectionFraction  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListDiagnosisHeartMethodId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --ShorteningFraction  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --SeptalWallThickness  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --LvPosteriorWallThickness  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --Comment   
)   
 begin  
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LvEjectionFraction AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDiagnosisHeartMethodId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ShorteningFraction AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SeptalWallThickness AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LvPosteriorWallThickness AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comment AS VARCHAR(1)), '')

 insert into DBO.TcssDonorDiagnosisHeart  
 (   
 "TcssDonorDiagnosisHeartId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"LvEjectionFraction" 
,"TcssListDiagnosisHeartMethodId" 
,"ShorteningFraction" 
,"SeptalWallThickness" 
,"LvPosteriorWallThickness" 
,"Comment"  
)  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LvEjectionFraction, 0) = 0 THEN -2 ELSE @LvEjectionFraction END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListDiagnosisHeartMethodId, 0) = 0 THEN -2 ELSE @TcssListDiagnosisHeartMethodId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@ShorteningFraction, 0) = 0 THEN -2 ELSE @ShorteningFraction END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@SeptalWallThickness, 0) = 0 THEN -2 ELSE @SeptalWallThickness END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@LvPosteriorWallThickness, 0) = 0 THEN -2 ELSE @LvPosteriorWallThickness END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@Comment, '') = '' THEN 'ILB'  ELSE @Comment END  )  
END    
 go  
 SET QUOTED_IDENTIFIER OFF   
 go  
 SET ANSI_NULLS ON   
 go  