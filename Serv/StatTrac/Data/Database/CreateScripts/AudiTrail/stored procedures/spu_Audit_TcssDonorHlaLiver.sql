 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorHlaLiver.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorHlaLiver**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorHlaLiver]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spu_Audit_TcssDonorHlaLiver]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorHlaLiver'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorHlaLiver'  
 go
   create procedure "spu_Audit_TcssDonorHlaLiver"  
   (   @TcssDonorHlaLiverId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListPreliminaryCrossmatchId int  
,@PreAdmissionHistory varchar(500) 
,@TcssListHlaA1Id int  
,@TcssListHlaA2Id int  
,@TcssListHlaB1Id int  
,@TcssListHlaB2Id int  
,@TcssListHlaBw4Id int  
,@TcssListHlaBw6Id int  
,@TcssListHlaC1Id int  
,@TcssListHlaC2Id int  
,@TcssListHlaDr1Id int  
,@TcssListHlaDr2Id int  
,@TcssListHlaDr51Id int  
,@TcssListHlaDr52Id int  
,@TcssListHlaDr53Id int  
,@TcssListHlaDq1Id int  
,@TcssListHlaDq2Id int  
,@PKC1 int 
,@Bitmap binary(3)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListPreliminaryCrossmatchId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --PreAdmissionHistory  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --TcssListHlaA1Id  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --TcssListHlaA2Id  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TcssListHlaB1Id  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --TcssListHlaB2Id  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListHlaBw4Id  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListHlaBw6Id  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --TcssListHlaC1Id  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --TcssListHlaC2Id  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListHlaDr1Id  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListHlaDr2Id  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --TcssListHlaDr51Id  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --TcssListHlaDr52Id  
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --TcssListHlaDr53Id  
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --TcssListHlaDq1Id  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --TcssListHlaDq2Id   
)   
 begin   
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListPreliminaryCrossmatchId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@PreAdmissionHistory AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaA1Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaA2Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaB1Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaB2Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaBw4Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaBw6Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaC1Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaC2Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDr1Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDr2Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDr51Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDr52Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDr53Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDq1Id AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHlaDq2Id AS VARCHAR(1)), '')
 insert into DBO.TcssDonorHlaLiver  
 (   "TcssDonorHlaLiverId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListPreliminaryCrossmatchId" 
,"PreAdmissionHistory" 
,"TcssListHlaA1Id" 
,"TcssListHlaA2Id" 
,"TcssListHlaB1Id" 
,"TcssListHlaB2Id" 
,"TcssListHlaBw4Id" 
,"TcssListHlaBw6Id" 
,"TcssListHlaC1Id" 
,"TcssListHlaC2Id" 
,"TcssListHlaDr1Id" 
,"TcssListHlaDr2Id" 
,"TcssListHlaDr51Id" 
,"TcssListHlaDr52Id" 
,"TcssListHlaDr53Id" 
,"TcssListHlaDq1Id" 
,"TcssListHlaDq2Id"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListPreliminaryCrossmatchId, 0) = 0 THEN -2 ELSE @TcssListPreliminaryCrossmatchId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@PreAdmissionHistory, '') = '' THEN 'ILB'  ELSE @PreAdmissionHistory END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@TcssListHlaA1Id, 0) = 0 THEN -2 ELSE @TcssListHlaA1Id END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@TcssListHlaA2Id, 0) = 0 THEN -2 ELSE @TcssListHlaA2Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TcssListHlaB1Id, 0) = 0 THEN -2 ELSE @TcssListHlaB1Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@TcssListHlaB2Id, 0) = 0 THEN -2 ELSE @TcssListHlaB2Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListHlaBw4Id, 0) = 0 THEN -2 ELSE @TcssListHlaBw4Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListHlaBw6Id, 0) = 0 THEN -2 ELSE @TcssListHlaBw6Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@TcssListHlaC1Id, 0) = 0 THEN -2 ELSE @TcssListHlaC1Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@TcssListHlaC2Id, 0) = 0 THEN -2 ELSE @TcssListHlaC2Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListHlaDr1Id, 0) = 0 THEN -2 ELSE @TcssListHlaDr1Id END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListHlaDr2Id, 0) = 0 THEN -2 ELSE @TcssListHlaDr2Id END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@TcssListHlaDr51Id, 0) = 0 THEN -2 ELSE @TcssListHlaDr51Id END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@TcssListHlaDr52Id, 0) = 0 THEN -2 ELSE @TcssListHlaDr52Id END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@TcssListHlaDr53Id, 0) = 0 THEN -2 ELSE @TcssListHlaDr53Id END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@TcssListHlaDq1Id, 0) = 0 THEN -2 ELSE @TcssListHlaDq1Id END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@TcssListHlaDq2Id, 0) = 0 THEN -2 ELSE @TcssListHlaDq2Id END  )  
END    
 go
  SET QUOTED_IDENTIFIER OFF   
 go
  SET ANSI_NULLS ON   
 go
  