 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorDiagnosisIntestine.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorDiagnosisIntestine**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorDiagnosisIntestine]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spu_Audit_TcssDonorDiagnosisIntestine]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorDiagnosisIntestine'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorDiagnosisIntestine'  
 go
 create procedure "spu_Audit_TcssDonorDiagnosisIntestine"  (   @TcssDonorDiagnosisIntestineId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@Comment varchar(5000) 
,@PKC1 int 
,@Bitmap binary(1)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --Comment   
)   
 begin   
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comment AS VARCHAR(1)), '')

 insert into DBO.TcssDonorDiagnosisIntestine  
 (   "TcssDonorDiagnosisIntestineId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"Comment"  )  VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Comment, '') = '' THEN 'ILB'  ELSE @Comment END  )  
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  