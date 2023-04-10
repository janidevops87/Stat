 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorMedSoc.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorMedSoc**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorMedSoc]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorMedSoc]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorMedSoc'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorMedSoc'  
 GO
    create procedure "spi_Audit_TcssDonorMedSoc"  
	(   @TcssDonorMedSocId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListHistoryOfDiabetesId int  
,@TcssListHistoryOfCancerId int  
,@TcssListHypertensionHistoryId int  
,@TcssListCompliantWithTreatmentId int  
,@TcssListHistoryOfCoronaryArteryDiseaseId int  
,@TcssListHistoryOfGastrointestinalDiseaseId int  
,@TcssListChestTraumaId int  
,@TcssListCigaretteUseId int  
,@TcssListCigaretteUseContinuedId int  
,@TcssListOtherDrugUseId int  
,@TcssListHeavyAlcoholUseId int  
,@TcssListDonorMeetCdcGuidelinesId int  
,@Comments varchar(5000)  )  
AS  
 BEGIN
 insert into DBO.TcssDonorMedSoc  
 (   "TcssDonorMedSocId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListHistoryOfDiabetesId" 
,"TcssListHistoryOfCancerId" 
,"TcssListHypertensionHistoryId" 
,"TcssListCompliantWithTreatmentId" 
,"TcssListHistoryOfCoronaryArteryDiseaseId" 
,"TcssListHistoryOfGastrointestinalDiseaseId" 
,"TcssListChestTraumaId" 
,"TcssListCigaretteUseId" 
,"TcssListCigaretteUseContinuedId" 
,"TcssListOtherDrugUseId" 
,"TcssListHeavyAlcoholUseId" 
,"TcssListDonorMeetCdcGuidelinesId" 
,"Comments"  )  
VALUES   
(    @TcssDonorMedSocId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListHistoryOfDiabetesId  
,@TcssListHistoryOfCancerId  
,@TcssListHypertensionHistoryId  
,@TcssListCompliantWithTreatmentId  
,@TcssListHistoryOfCoronaryArteryDiseaseId  
,@TcssListHistoryOfGastrointestinalDiseaseId  
,@TcssListChestTraumaId  
,@TcssListCigaretteUseId  
,@TcssListCigaretteUseContinuedId  
,@TcssListOtherDrugUseId  
,@TcssListHeavyAlcoholUseId  
,@TcssListDonorMeetCdcGuidelinesId  
,@Comments   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  