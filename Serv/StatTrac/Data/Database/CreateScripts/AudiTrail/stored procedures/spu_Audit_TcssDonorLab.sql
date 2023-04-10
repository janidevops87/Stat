 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorLab.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorLab**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorLab]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spu_Audit_TcssDonorLab]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorLab'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorLab'  
 go
 create procedure "spu_Audit_TcssDonorLab"  
 (   @TcssDonorLabId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListToxicologyScreenId int  
,@Results varchar(500) 
,@OtherLabs varchar(500) 
,@HbA1c decimal  
,@HbA1cDateTime smalldatetime  
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListToxicologyScreenId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Results  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --OtherLabs  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --HbA1c  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --HbA1cDateTime   
)   
 begin  
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListToxicologyScreenId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Results AS VARCHAR(1)), '') 
+ ISNULL(CAST(@OtherLabs AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HbA1c AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HbA1cDateTime AS VARCHAR(1)), '')
 insert into DBO.TcssDonorLab  
 (   "TcssDonorLabId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListToxicologyScreenId" 
,"Results" 
,"OtherLabs" 
,"HbA1c" 
,"HbA1cDateTime"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListToxicologyScreenId, 0) = 0 THEN -2 ELSE @TcssListToxicologyScreenId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Results, '') = '' THEN 'ILB'  ELSE @Results END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@OtherLabs, '') = '' THEN 'ILB'  ELSE @OtherLabs END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@HbA1c, 0) = 0 THEN -2 ELSE @HbA1c END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@HbA1cDateTime, '') = '' THEN '1900-01-01'  ELSE @HbA1cDateTime END  )  
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  