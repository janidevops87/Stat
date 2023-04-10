 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorCulture.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorCulture**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorCulture]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spu_Audit_TcssDonorCulture]PRINT 'Drop Sproc: spu_Audit_TcssDonorCulture'  END   
 go 
 PRINT 'Create Sproc: spu_Audit_TcssDonorCulture'  
 go   
 create procedure "spu_Audit_TcssDonorCulture"  
 (   @TcssDonorCultureId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@TcssListCultureTypeId int  
,@TcssListCultureResultId int  
,@Comment varchar(2500) 
,@PKC1 int 
,@Bitmap binary(2)  )  AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListCultureTypeId  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListCultureResultId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Comment   
)   
 begin
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCultureTypeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCultureResultId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Comment AS VARCHAR(1)), '')

 insert into DBO.TcssDonorCulture  (   "TcssDonorCultureId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"TcssListCultureTypeId" 
,"TcssListCultureResultId" 
,"Comment"  )  
VALUES   
(  
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListCultureTypeId, 0) = 0 THEN -2 ELSE @TcssListCultureTypeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListCultureResultId, 0) = 0 THEN -2 ELSE @TcssListCultureResultId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Comment, '') = '' THEN 'ILB'  ELSE @Comment END  )  
END    
 go  
 SET QUOTED_IDENTIFIER OFF   
 go  
 SET ANSI_NULLS ON   
 go  