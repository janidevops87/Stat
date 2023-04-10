 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorVitalSign.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorVitalSign**   
*******************************************************************************/SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorVitalSign]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorVitalSign]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorVitalSign'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorVitalSign'  
 GO
   create procedure "spu_Audit_TcssDonorVitalSign"  
   (   @TcssDonorVitalSignId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@FromDateTime smalldatetime  
,@ToDateTime smalldatetime  
,@PKC1 int 
,@Bitmap binary(1)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --FromDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --ToDateTime   
)   
BEGIN
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@FromDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ToDateTime AS VARCHAR(1)), '')
insert into DBO.TcssDonorVitalSign  
(   "TcssDonorVitalSignId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"FromDateTime" 
,"ToDateTime"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@FromDateTime, '') = '' THEN '1900-01-01'  ELSE @FromDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@ToDateTime, '') = '' THEN '1900-01-01'  ELSE @ToDateTime END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  