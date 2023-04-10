 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorLabValues.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorLabValues**   
*******************************************************************************/SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorLabValues]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorLabValues]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorLabValues'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorLabValues'  
 GO
   create procedure "spu_Audit_TcssDonorLabValues"  
   (   @TcssDonorLabValuesId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Cpk varchar(50) 
,@Ckmb varchar(50) 
,@TroponinL varchar(50) 
,@TroponinT varchar(50) 
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Cpk  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Ckmb  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --TroponinL  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TroponinT   
)   
 BEGIN
DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Cpk AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Ckmb AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TroponinL AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TroponinT AS VARCHAR(1)), '')
   insert into DBO.TcssDonorLabValues  
   (   "TcssDonorLabValuesId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Cpk" 
,"Ckmb" 
,"TroponinL" 
,"TroponinT"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Cpk, '') = '' THEN 'ILB'  ELSE @Cpk END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Ckmb, '') = '' THEN 'ILB'  ELSE @Ckmb END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@TroponinL, '') = '' THEN 'ILB'  ELSE @TroponinL END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TroponinT, '') = '' THEN 'ILB'  ELSE @TroponinT END  ) 
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  