 /******************************************************************************  

**  File:  
**  Name: spu_Audit_TcssDonorLabProfileDetail.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorLabProfileDetail**   
*******************************************************************************/SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorLabProfileDetail]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
BEGIN
drop procedure [dbo].[spu_Audit_TcssDonorLabProfileDetail]
PRINT 'Drop Sproc: spu_Audit_TcssDonorLabProfileDetail'  
END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorLabProfileDetail'  
 GO
   create procedure "spu_Audit_TcssDonorLabProfileDetail"  
   (   @TcssDonorLabProfileDetailId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssDonorLabProfileId int  
,@TcssListLabId int  
,@Answer varchar(50) 
,@PKC1 int 
,@Bitmap binary(2)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssDonorLabProfileId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListLabId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Answer   
)   
BEGIN
DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorLabProfileId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListLabId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Answer AS VARCHAR(1)), '')
   insert into DBO.TcssDonorLabProfileDetail  (   "TcssDonorLabProfileDetailId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssDonorLabProfileId" 
,"TcssListLabId" 
,"Answer"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssDonorLabProfileId, 0) = 0 THEN -2 ELSE @TcssDonorLabProfileId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListLabId, 0) = 0 THEN -2 ELSE @TcssListLabId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Answer, '') = '' THEN 'ILB'  ELSE @Answer END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  