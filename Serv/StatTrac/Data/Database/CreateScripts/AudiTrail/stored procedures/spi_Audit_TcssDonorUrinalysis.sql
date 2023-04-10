 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorUrinalysis.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorUrinalysis**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorUrinalysis]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
 drop procedure [dbo].[spi_Audit_TcssDonorUrinalysis]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorUrinalysis'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorUrinalysis'  
 GO
    create procedure "spi_Audit_TcssDonorUrinalysis"  (   @TcssDonorUrinalysisId int  
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
,@TcssUrinalysisLeukocyte varchar(50)  ) 
AS  
 BEGIN
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
(    @TcssDonorUrinalysisId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@SampleDateTime  
,@Color  
,@AppearanceId  
,@Ph  
,@SpecificGravity  
,@TcssListUrinalysisProteinId  
,@TcssListUrinalysisGlucoseId  
,@TcssListUrinalysisBloodId  
,@TcssListUrinalysisRbcId  
,@TcssListUrinalysisWbcId  
,@TcssListUrinalysisEpithId  
,@TcssListUrinalysisCastId  
,@TcssListUrinalysisBacteriaId  
,@TcssListUrinalysisLeukocyteId  
,@TcssUrinalysisProtein  
,@TcssUrinalysisGlucose  
,@TcssUrinalysisBlood  
,@TcssUrinalysisRbc  
,@TcssUrinalysisWbc  
,@TcssUrinalysisEpith  
,@TcssUrinalysisCast  
,@TcssUrinalysisBacteria  
,@TcssUrinalysisLeukocyte   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  