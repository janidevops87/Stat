 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorVitalSignSummary.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorVitalSignSummary**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorVitalSignSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spu_Audit_TcssDonorVitalSignSummary]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorVitalSignSummary'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorVitalSignSummary'  
 GO
   create procedure "spu_Audit_TcssDonorVitalSignSummary"  
   (   @TcssDonorVitalSignSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@Sao2Initial varchar(50) 
,@Sao2Peak varchar(50) 
,@Sao2Current varchar(50) 
,@Sao2InitialFromDate datetime  
,@Sao2InitialToDate datetime  
,@Sao2PeakFromDate datetime  
,@Sao2PeakToDate datetime  
,@Sao2CurrentFromDate datetime  
,@Sao2CurrentToDate datetime  
,@PKC1 int 
,@Bitmap binary(2)  ) 
 AS  
 IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --Sao2Initial  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Sao2Peak  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Sao2Current  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Sao2InitialFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Sao2InitialToDate  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --Sao2PeakFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --Sao2PeakToDate  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --Sao2CurrentFromDate  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --Sao2CurrentToDate  
 )   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2Initial AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2Peak AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2Current AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2InitialFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2InitialToDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2PeakFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2PeakToDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2CurrentFromDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Sao2CurrentToDate AS VARCHAR(1)), '')
insert into DBO.TcssDonorVitalSignSummary  
(   "TcssDonorVitalSignSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"Sao2Initial" 
,"Sao2Peak" 
,"Sao2Current" 
,"Sao2InitialFromDate" 
,"Sao2InitialToDate" 
,"Sao2PeakFromDate" 
,"Sao2PeakToDate" 
,"Sao2CurrentFromDate" 
,"Sao2CurrentToDate"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Sao2Initial, '') = '' THEN 'ILB'  ELSE @Sao2Initial END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Sao2Peak, '') = '' THEN 'ILB'  ELSE @Sao2Peak END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Sao2Current, '') = '' THEN 'ILB'  ELSE @Sao2Current END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Sao2InitialFromDate, '') = '' THEN '1900-01-01'  ELSE @Sao2InitialFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Sao2InitialToDate, '') = '' THEN '1900-01-01'  ELSE @Sao2InitialToDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@Sao2PeakFromDate, '') = '' THEN '1900-01-01'  ELSE @Sao2PeakFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@Sao2PeakToDate, '') = '' THEN '1900-01-01'  ELSE @Sao2PeakToDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@Sao2CurrentFromDate, '') = '' THEN '1900-01-01'  ELSE @Sao2CurrentFromDate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@Sao2CurrentToDate, '') = '' THEN '1900-01-01'  ELSE @Sao2CurrentToDate END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  