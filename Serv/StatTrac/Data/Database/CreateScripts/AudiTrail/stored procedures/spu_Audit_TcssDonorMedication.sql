 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorMedication.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorMedication**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorMedication]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spu_Audit_TcssDonorMedication]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorMedication'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorMedication'  
 GO
   create procedure "spu_Audit_TcssDonorMedication"  
   (   @TcssDonorMedicationId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListMedicationId int  
,@StartDate smalldatetime  
,@StopDateTime smalldatetime  
,@Dose decimal  
,@TcssListMedicationDoseUnitId int  
,@Duration int  
,@PKC1 int 
,@Bitmap binary(2)  )  AS  IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListMedicationId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --StartDate  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --StopDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Dose  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TcssListMedicationDoseUnitId  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --Duration   
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListMedicationId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@StartDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@StopDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Dose AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListMedicationDoseUnitId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Duration AS VARCHAR(1)), '')
   insert into DBO.TcssDonorMedication  
   (   "TcssDonorMedicationId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListMedicationId" 
,"StartDate" 
,"StopDateTime" 
,"Dose" 
,"TcssListMedicationDoseUnitId" 
,"Duration"  ) 
 VALUES   
 (   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListMedicationId, 0) = 0 THEN -2 ELSE @TcssListMedicationId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@StartDate, '') = '' THEN '1900-01-01'  ELSE @StartDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@StopDateTime, '') = '' THEN '1900-01-01'  ELSE @StopDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Dose, 0) = 0 THEN -2 ELSE @Dose END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TcssListMedicationDoseUnitId, 0) = 0 THEN -2 ELSE @TcssListMedicationDoseUnitId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@Duration, 0) = 0 THEN -2 ELSE @Duration END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  