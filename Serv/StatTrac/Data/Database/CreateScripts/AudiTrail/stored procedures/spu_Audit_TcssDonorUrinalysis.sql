 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorUrinalysis.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorUrinalysis**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorUrinalysis]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spu_Audit_TcssDonorUrinalysis]
	 PRINT 'Drop Sproc: spu_Audit_TcssDonorUrinalysis'  
 END   
 GO
 PRINT 'Create Sproc: spu_Audit_TcssDonorUrinalysis'  
 GO
   create procedure "spu_Audit_TcssDonorUrinalysis"  
   (   @TcssDonorUrinalysisId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Color varchar(10) 
,@AppearanceId varchar(10) 
,@Ph decimal  
,@SpecificGravity decimal  
,@TcssListUrinalysisProteinId int  
,@TcssListUrinalysisGlucoseId int  
,@TcssListUrinalysisBloodId int  
,@TcssListUrinalysisRbcId int  
,@TcssListUrinalysisWbcId int  
,@TcssListUrinalysisEpithId int  
,@TcssListUrinalysisCastId int  
,@TcssListUrinalysisBacteriaId int  
,@TcssListUrinalysisLeukocyteId int  
,@TcssUrinalysisProtein varchar(50) 
,@TcssUrinalysisGlucose varchar(50) 
,@TcssUrinalysisBlood varchar(50) 
,@TcssUrinalysisRbc varchar(50) 
,@TcssUrinalysisWbc varchar(50) 
,@TcssUrinalysisEpith varchar(50) 
,@TcssUrinalysisCast varchar(50) 
,@TcssUrinalysisBacteria varchar(50) 
,@TcssUrinalysisLeukocyte varchar(50) 
,@PKC1 int 
,@Bitmap binary(4)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --SampleDateTime  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --Color  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AppearanceId  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --Ph  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --SpecificGravity  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --TcssListUrinalysisProteinId  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --TcssListUrinalysisGlucoseId  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --TcssListUrinalysisBloodId  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --TcssListUrinalysisRbcId  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --TcssListUrinalysisWbcId  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListUrinalysisEpithId  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListUrinalysisCastId  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --TcssListUrinalysisBacteriaId  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --TcssListUrinalysisLeukocyteId  
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --TcssUrinalysisProtein  
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --TcssUrinalysisGlucose  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --TcssUrinalysisBlood  
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --TcssUrinalysisRbc  
AND SUBSTRING(@Bitmap, 3, 1) & 64 <> 64 --TcssUrinalysisWbc  
AND SUBSTRING(@Bitmap, 3, 1) & 128 <> 128 --TcssUrinalysisEpith  
AND SUBSTRING(@Bitmap, 4, 1) & 1 <> 1 --TcssUrinalysisCast  
AND SUBSTRING(@Bitmap, 4, 1) & 2 <> 2 --TcssUrinalysisBacteria  
AND SUBSTRING(@Bitmap, 4, 1) & 4 <> 4 --TcssUrinalysisLeukocyte  
)   
 BEGIN
 DECLARE @CheckForBlank VARCHAR(250); SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SampleDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Color AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AppearanceId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Ph AS VARCHAR(1)), '') 
+ ISNULL(CAST(@SpecificGravity AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisProteinId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisGlucoseId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisBloodId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisRbcId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisWbcId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisEpithId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisCastId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisBacteriaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListUrinalysisLeukocyteId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisProtein AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisGlucose AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisBlood AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisRbc AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisWbc AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisEpith AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisCast AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisBacteria AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssUrinalysisLeukocyte AS VARCHAR(1)), '')
   insert into DBO.TcssDonorUrinalysis  
   (   "TcssDonorUrinalysisId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Color" 
,"AppearanceId" 
,"Ph" 
,"SpecificGravity" 
,"TcssListUrinalysisProteinId" 
,"TcssListUrinalysisGlucoseId" 
,"TcssListUrinalysisBloodId" 
,"TcssListUrinalysisRbcId" 
,"TcssListUrinalysisWbcId" 
,"TcssListUrinalysisEpithId" 
,"TcssListUrinalysisCastId" 
,"TcssListUrinalysisBacteriaId" 
,"TcssListUrinalysisLeukocyteId" 
,"TcssUrinalysisProtein" 
,"TcssUrinalysisGlucose" 
,"TcssUrinalysisBlood" 
,"TcssUrinalysisRbc" 
,"TcssUrinalysisWbc" 
,"TcssUrinalysisEpith" 
,"TcssUrinalysisCast" 
,"TcssUrinalysisBacteria" 
,"TcssUrinalysisLeukocyte"  )  
VALUES   
(   @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SampleDateTime, '') = '' THEN '1900-01-01'  ELSE @SampleDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@Color, '') = '' THEN 'ILB'  ELSE @Color END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AppearanceId, '') = '' THEN 'ILB'  ELSE @AppearanceId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@Ph, 0) = 0 THEN -2 ELSE @Ph END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@SpecificGravity, 0) = 0 THEN -2 ELSE @SpecificGravity END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@TcssListUrinalysisProteinId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisProteinId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@TcssListUrinalysisGlucoseId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisGlucoseId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@TcssListUrinalysisBloodId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisBloodId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@TcssListUrinalysisRbcId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisRbcId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@TcssListUrinalysisWbcId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisWbcId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListUrinalysisEpithId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisEpithId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListUrinalysisCastId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisCastId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@TcssListUrinalysisBacteriaId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisBacteriaId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@TcssListUrinalysisLeukocyteId, 0) = 0 THEN -2 ELSE @TcssListUrinalysisLeukocyteId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@TcssUrinalysisProtein, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisProtein END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@TcssUrinalysisGlucose, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisGlucose END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@TcssUrinalysisBlood, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisBlood END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@TcssUrinalysisRbc, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisRbc END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@TcssUrinalysisWbc, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisWbc END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 128 = 128 AND ISNULL(@TcssUrinalysisEpith, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisEpith END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 1 = 1 AND ISNULL(@TcssUrinalysisCast, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisCast END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 2 = 2 AND ISNULL(@TcssUrinalysisBacteria, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisBacteria END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 4 = 4 AND ISNULL(@TcssUrinalysisLeukocyte, '') = '' THEN 'ILB'  ELSE @TcssUrinalysisLeukocyte END  )  
END    
 GO
  SET QUOTED_IDENTIFIER OFF   
 GO
  SET ANSI_NULLS ON   
 GO
  