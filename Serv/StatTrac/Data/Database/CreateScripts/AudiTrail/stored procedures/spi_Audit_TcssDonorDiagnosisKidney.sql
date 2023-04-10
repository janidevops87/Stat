 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorDiagnosisKidney.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorDiagnosisKidney**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorDiagnosisKidney]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorDiagnosisKidney]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorDiagnosisKidney'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorDiagnosisKidney'  
 go
 
 create procedure "spi_Audit_TcssDonorDiagnosisKidney" 
 (   @TcssDonorDiagnosisKidneyId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListKidneyId int  
,@TcssListKidneyAorticCuffId int  
,@TcssListKidneyFullVenaId int  
,@Length float  
,@Width float  
,@TcssListKidneyAorticPlaqueId int  
,@TcssListKidneyArterialPlaqueId int  
,@TcssListKidneyInfarctedAreaId int  
,@TcssListKidneyCapsularTearId int  
,@TcssListKidneySubcapsularId int  
,@TcssListKidneyHematomaId int  
,@TcssListKidneyFatCleanedId int  
,@TcssListKidneyCystsDiscolorationId int  
,@TcssListKidneyHorseshoeShapeId int  
,@TcssListKidneyRecoveryBiopsyId int  
,@GlomeruliObserved varchar(50) 
,@GlomeruliSclerosed varchar(50) 
,@SclerosedPercent decimal  
,@TcssListKidneyBiopsyId int  
,@Comment varchar(5000) 
,@TcssListKidneyPumpDeviceId int  
,@TcssListKidneyPumpSolutionId int  
,@BiopsyType varchar(20)  )  
AS  
 begin
 insert into DBO.TcssDonorDiagnosisKidney 
 (   "TcssDonorDiagnosisKidneyId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListKidneyId" 
,"TcssListKidneyAorticCuffId" 
,"TcssListKidneyFullVenaId" 
,"Length" 
,"Width" 
,"TcssListKidneyAorticPlaqueId" 
,"TcssListKidneyArterialPlaqueId" 
,"TcssListKidneyInfarctedAreaId" 
,"TcssListKidneyCapsularTearId" 
,"TcssListKidneySubcapsularId" 
,"TcssListKidneyHematomaId" 
,"TcssListKidneyFatCleanedId" 
,"TcssListKidneyCystsDiscolorationId" 
,"TcssListKidneyHorseshoeShapeId" 
,"TcssListKidneyRecoveryBiopsyId" 
,"GlomeruliObserved" 
,"GlomeruliSclerosed" 
,"SclerosedPercent" 
,"TcssListKidneyBiopsyId" 
,"Comment" 
,"TcssListKidneyPumpDeviceId" 
,"TcssListKidneyPumpSolutionId" 
,"BiopsyType"  )  
VALUES   
(    @TcssDonorDiagnosisKidneyId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListKidneyId  
,@TcssListKidneyAorticCuffId  
,@TcssListKidneyFullVenaId  
,@Length  
,@Width  
,@TcssListKidneyAorticPlaqueId  
,@TcssListKidneyArterialPlaqueId  
,@TcssListKidneyInfarctedAreaId  
,@TcssListKidneyCapsularTearId  
,@TcssListKidneySubcapsularId  
,@TcssListKidneyHematomaId  
,@TcssListKidneyFatCleanedId  
,@TcssListKidneyCystsDiscolorationId  
,@TcssListKidneyHorseshoeShapeId  
,@TcssListKidneyRecoveryBiopsyId  
,@GlomeruliObserved  
,@GlomeruliSclerosed  
,@SclerosedPercent  
,@TcssListKidneyBiopsyId  
,@Comment  
,@TcssListKidneyPumpDeviceId  
,@TcssListKidneyPumpSolutionId  
,@BiopsyType   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  