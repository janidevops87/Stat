 /****************************************************************************
** 
** File:   
** Name: spu_Audit_TcssDonorAbgSummary.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorAbgSummary
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorAbgSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spu_Audit_TcssDonorAbgSummary]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorAbgSummary'  
 END   
 go 
 PRINT 'Create Sproc: spu_Audit_TcssDonorAbgSummary'  
 go   
 create procedure "spu_Audit_TcssDonorAbgSummary"  
 (   @TcssDonorAbgSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@HowManyDaysVented int  
,@PKC1 int 
,@Bitmap binary(1)  )  AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --HowManyDaysVented  
 )   
begin 
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HowManyDaysVented AS VARCHAR(1)), '')

 insert into DBO.TcssDonorAbgSummary  
 (   
 "TcssDonorAbgSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"HowManyDaysVented"  
)  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@HowManyDaysVented, 0) = 0 THEN -2 ELSE @HowManyDaysVented END 
 )  
END    
 go  
 SET QUOTED_IDENTIFIER OFF   
 go  
 SET ANSI_NULLS ON   
 go  