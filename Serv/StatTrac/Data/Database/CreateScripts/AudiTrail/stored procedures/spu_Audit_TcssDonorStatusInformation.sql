 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorStatusInformation.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorStatusInformation**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorStatusInformation]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorStatusInformation]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorStatusInformation'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorStatusInformation'  
 GO
 create procedure "spu_Audit_TcssDonorStatusInformation"  
 (   
 @TcssDonorStatusInformationId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@DateTime smalldatetime  
,@StatEmployeeId int  
,@TcssListStatusId int  
,@Comment varchar(200) 
,@PKC1 int 
,@Bitmap binary(2)  ) 
 AS  
 IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --DateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --StatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListStatusId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Comment   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@StatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListStatusId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comment AS VARCHAR(1)), '')
   insert into DBO.TcssDonorStatusInformation 
   (   "TcssDonorStatusInformationId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"DateTime" 
,"StatEmployeeId" 
,"TcssListStatusId" 
,"Comment"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@DateTime, '') = '' THEN '1900-01-01'  ELSE @DateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@StatEmployeeId, 0) = 0 THEN -2 ELSE @StatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListStatusId, 0) = 0 THEN -2 ELSE @TcssListStatusId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Comment, '') = '' THEN 'ILB'  ELSE @Comment END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  