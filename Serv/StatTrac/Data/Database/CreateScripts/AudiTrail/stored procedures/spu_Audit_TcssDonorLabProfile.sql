 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorLabProfile.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorLabProfile**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorLabProfile]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spu_Audit_TcssDonorLabProfile]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorLabProfile'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorLabProfile'  
 go
   create procedure 
   "spu_Audit_TcssDonorLabProfile"  
   (   @TcssDonorLabProfileId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@PKC1 int 
,@Bitmap binary(1)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime   
)   
 begin
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '')
 insert into DBO.TcssDonorLabProfile  
   (   "TcssDonorLabProfileId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END  )  
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  