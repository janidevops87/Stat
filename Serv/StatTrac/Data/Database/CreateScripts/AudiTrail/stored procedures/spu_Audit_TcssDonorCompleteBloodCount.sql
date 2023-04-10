 /****************************************************************************
** 
** File:   
** Name: spu_Audit_TcssDonorCompleteBloodCount.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorCompleteBloodCount
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorCompleteBloodCount]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spu_Audit_TcssDonorCompleteBloodCount]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorCompleteBloodCount'  END   
 go 
 PRINT 'Create Sproc: spu_Audit_TcssDonorCompleteBloodCount'  
 go   
 create procedure "spu_Audit_TcssDonorCompleteBloodCount"  
 (   
 @TcssDonorCompleteBloodCountId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Wbc varchar(50) 
,@Rbc varchar(50) 
,@Hgb varchar(50) 
,@Hct varchar(50) 
,@Plt varchar(50) 
,@Bands decimal  
,@PKC1 int 
,@Bitmap binary(2)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Wbc  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Rbc  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Hgb  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Hct  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --Plt  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --Bands  
 )   
begin
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Wbc AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Rbc AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Hgb AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Hct AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Plt AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Bands AS VARCHAR(1)), '')

   insert into DBO.TcssDonorCompleteBloodCount  
   (   
   "TcssDonorCompleteBloodCountId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Wbc" 
,"Rbc" 
,"Hgb" 
,"Hct" 
,"Plt" 
,"Bands"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Wbc, '') = '' THEN 'ILB'  ELSE @Wbc END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Rbc, '') = '' THEN 'ILB'  ELSE @Rbc END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Hgb, '') = '' THEN 'ILB'  ELSE @Hgb END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Hct, '') = '' THEN 'ILB'  ELSE @Hct END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@Plt, '') = '' THEN 'ILB'  ELSE @Plt END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@Bands, 0) = 0 THEN -2 ELSE @Bands END  
)  
END    
 go  
 SET QUOTED_IDENTIFIER OFF   
 go  
 SET ANSI_NULLS ON   
 go  