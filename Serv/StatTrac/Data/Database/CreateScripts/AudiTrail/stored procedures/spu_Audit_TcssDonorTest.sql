 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorTest.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorTest**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorTest]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorTest]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorTest'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorTest'  
 GO
   create procedure "spu_Audit_TcssDonorTest"  (   @TcssDonorTestId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListTestTypeId int  
,@TestDateTime smalldatetime  
,@Interpretation varchar(5000) 
,@PKC1 int 
,@Bitmap binary(2)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListTestTypeId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TestDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Interpretation   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListTestTypeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TestDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Interpretation AS VARCHAR(1)), '')
   insert into DBO.TcssDonorTest  
   (   "TcssDonorTestId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListTestTypeId" 
,"TestDateTime" 
,"Interpretation"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListTestTypeId, 0) = 0 THEN -2 ELSE @TcssListTestTypeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TestDateTime, '') = '' THEN '1900-01-01'  ELSE @TestDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Interpretation, '') = '' THEN 'ILB'  ELSE @Interpretation END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  