 /****************************************************************************
** 
** File:   
** Name: spu_Audit_TcssDonorAbg.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  jim hawkins   Update Audit records for DBO.TcssDonorAbg
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go   
 SET ANSI_NULLS ON     
 go   
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorAbg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN 
 drop procedure [dbo].[spu_Audit_TcssDonorAbg]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorAbg'  
 END   
 go 
 PRINT 'Create Sproc: spu_Audit_TcssDonorAbg'  
 go   
 create procedure "spu_Audit_TcssDonorAbg"  (   @TcssDonorAbgId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Ph decimal  
,@Pco2 decimal  
,@Po2 decimal  
,@Hco3 decimal  
,@O2sat decimal  
,@TcssListVentSettingModeId int  
,@ModeOther varchar(50) 
,@Fio2 decimal  
,@Rate decimal  
,@Vt decimal  
,@Peep decimal  
,@Pip decimal  
,@PKC1 int 
,@Bitmap binary(3)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Ph  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Pco2  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Po2  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --Hco3  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --O2sat  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListVentSettingModeId  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --ModeOther  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --Fio2  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --Rate  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --Vt  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --Peep  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --Pip   
)   
BEGIN  
DECLARE @CheckForBlank VARCHAR(250); 
SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Ph AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Pco2 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Po2 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Hco3 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@O2sat AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListVentSettingModeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ModeOther AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Fio2 AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Rate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Vt AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Peep AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Pip AS VARCHAR(1)), '')--If the only chnage to the record is date time --it is a review not update. IF @CheckForBlank IS NULL BEGIN SET @AuditLogTypeID = 2 END 
insert into DBO.TcssDonorAbg  
(   "TcssDonorAbgId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Ph" 
,"Pco2" 
,"Po2" 
,"Hco3" 
,"O2sat" 
,"TcssListVentSettingModeId" 
,"ModeOther" 
,"Fio2" 
,"Rate" 
,"Vt" 
,"Peep" 
,"Pip"  )  
VALUES   
(   
@PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Ph, 0) = 0 THEN -2 ELSE @Ph END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Pco2, 0) = 0 THEN -2 ELSE @Pco2 END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Po2, 0) = 0 THEN -2 ELSE @Po2 END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@Hco3, 0) = 0 THEN -2 ELSE @Hco3 END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@O2sat, 0) = 0 THEN -2 ELSE @O2sat END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListVentSettingModeId, 0) = 0 THEN -2 ELSE @TcssListVentSettingModeId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@ModeOther, '') = '' THEN 'ILB'  ELSE @ModeOther END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@Fio2, 0) = 0 THEN -2 ELSE @Fio2 END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@Rate, 0) = 0 THEN -2 ELSE @Rate END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@Vt, 0) = 0 THEN -2 ELSE @Vt END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@Peep, 0) = 0 THEN -2 ELSE @Peep END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@Pip, 0) = 0 THEN -2 ELSE @Pip END  )  
END    
 go  
 SET QUOTED_IDENTIFIER OFF   
 go  
 SET ANSI_NULLS ON   
 go  