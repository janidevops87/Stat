 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorLabProfileSummary.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorLabProfileSummary**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorLabProfileSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spu_Audit_TcssDonorLabProfileSummary]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorLabProfileSummary'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorLabProfileSummary'  
 GO
   create procedure "spu_Audit_TcssDonorLabProfileSummary"  (   @TcssDonorLabProfileSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@AlcHbalcInitial varchar(50) 
,@AlcHbalcPeak varchar(50) 
,@AlcHbalcCurrent varchar(50) 
,@AlcHbalcInitialFromDate datetime  
,@AlcHbalcInitialToDate datetime  
,@AlcHbalcPeakFromDate datetime  
,@AlcHbalcPeakToDate datetime  
,@AlcHbalcCurrentFromDate datetime  
,@AlcHbalcCurrentToDate datetime  
,@PKC1 int 
,@Bitmap binary(2)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --AlcHbalcInitial  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AlcHbalcPeak  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AlcHbalcCurrent  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AlcHbalcInitialFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --AlcHbalcInitialToDate  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --AlcHbalcPeakFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --AlcHbalcPeakToDate  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AlcHbalcCurrentFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --AlcHbalcCurrentToDate   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcInitial AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcPeak AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcCurrent AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcInitialFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcInitialToDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcPeakFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcPeakToDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcCurrentFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AlcHbalcCurrentToDate AS VARCHAR(1)), '')
   insert into DBO.TcssDonorLabProfileSummary  
   (   "TcssDonorLabProfileSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"AlcHbalcInitial" 
,"AlcHbalcPeak" 
,"AlcHbalcCurrent" 
,"AlcHbalcInitialFromDate" 
,"AlcHbalcInitialToDate" 
,"AlcHbalcPeakFromDate" 
,"AlcHbalcPeakToDate" 
,"AlcHbalcCurrentFromDate" 
,"AlcHbalcCurrentToDate"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@AlcHbalcInitial, '') = '' THEN 'ILB'  ELSE @AlcHbalcInitial END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AlcHbalcPeak, '') = '' THEN 'ILB'  ELSE @AlcHbalcPeak END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AlcHbalcCurrent, '') = '' THEN 'ILB'  ELSE @AlcHbalcCurrent END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@AlcHbalcInitialFromDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcInitialFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@AlcHbalcInitialToDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcInitialToDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@AlcHbalcPeakFromDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcPeakFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@AlcHbalcPeakToDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcPeakToDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AlcHbalcCurrentFromDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcCurrentFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@AlcHbalcCurrentToDate, '') = '' THEN '1900-01-01'  ELSE @AlcHbalcCurrentToDate END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  