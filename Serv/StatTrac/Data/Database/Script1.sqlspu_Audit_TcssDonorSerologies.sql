 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorSerologies.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorSerologies**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorSerologies]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spu_Audit_TcssDonorSerologies]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorSerologies'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorSerologies'  
 GO
   create procedure "spu_Audit_TcssDonorSerologies"  (   @TcssDonorSerologiesId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListSerologyQuestionId int  
,@TcssListSerologyAnswerId int  
,@PKC1 int 
,@Bitmap binary(1)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListSerologyQuestionId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --TcssListSerologyAnswerId   
)   
 BEGIN
DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListSerologyQuestionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListSerologyAnswerId AS VARCHAR(1)), '')
   insert into DBO.TcssDonorSerologies  
(   "TcssDonorSerologiesId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListSerologyQuestionId" 
,"TcssListSerologyAnswerId"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListSerologyQuestionId, 0) = 0 THEN -2 ELSE @TcssListSerologyQuestionId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@TcssListSerologyAnswerId, 0) = 0 THEN -2 ELSE @TcssListSerologyAnswerId END  
) 
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  