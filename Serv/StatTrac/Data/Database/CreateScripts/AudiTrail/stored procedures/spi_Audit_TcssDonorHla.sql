 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorHla.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorHla**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorHla]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin
 drop procedure [dbo].[spi_Audit_TcssDonorHla]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorHla'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorHla'  
 go
    create procedure "spi_Audit_TcssDonorHla"  
(   @TcssDonorHlaId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssListAboId int  
,@DateOfBirth smalldatetime  
,@Age int  
,@TcssListAgeUnitId int  
,@TcssListGenderId int  
,@HeightFeet int  
,@HeightInches int  
,@Weight decimal  
,@Bmi decimal  
,@TcssListEthnicityId int  
,@TcssListRaceId int  
,@TcssListCauseOfDeathId int  
,@TcssListMechanismOfDeathId int  
,@TcssListCircumstancesOfDeathId int  
,@TcssListDonorDefinitionId int  
,@TcssListDonorDbdSubDefinitionId int  
,@TcssListDonorDcdSubDefinitionId int  
,@TcssListBreathingoverVentId int  
,@UwScore varchar(50) 
,@TcssListHemodynamicallyStableId int  
,@AdmitDateTime smalldatetime  
,@PronouncedDateTime smalldatetime  
,@CardiacArrestDateTime smalldatetime  
,@CrossClampDateTime smalldatetime  
,@ColdSchemeticTime varchar(50) 
,@TcssListDonorMeetsEcdCriteriaId int  
,@TcssListDonorMeetsDcdCriteriaId int  
,@TcssListCardiacArrestDownTimeId int  
,@EstimattedDownTime int  
,@TcssListCprAdministeredId int  
,@Duration int  
,@DonorHighlights varchar(5000) 
,@AdmissionCourseComments varchar(2000)  ) 
AS  
 begin
  insert into DBO.TcssDonorHla  
 (   "TcssDonorHlaId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssListAboId" 
,"DateOfBirth" 
,"Age" 
,"TcssListAgeUnitId" 
,"TcssListGenderId" 
,"HeightFeet" 
,"HeightInches" 
,"Weight" 
,"Bmi" 
,"TcssListEthnicityId" 
,"TcssListRaceId" 
,"TcssListCauseOfDeathId" 
,"TcssListMechanismOfDeathId" 
,"TcssListCircumstancesOfDeathId" 
,"TcssListDonorDefinitionId" 
,"TcssListDonorDbdSubDefinitionId" 
,"TcssListDonorDcdSubDefinitionId" 
,"TcssListBreathingoverVentId" 
,"UwScore" 
,"TcssListHemodynamicallyStableId" 
,"AdmitDateTime" 
,"PronouncedDateTime" 
,"CardiacArrestDateTime" 
,"CrossClampDateTime" 
,"ColdSchemeticTime" 
,"TcssListDonorMeetsEcdCriteriaId" 
,"TcssListDonorMeetsDcdCriteriaId" 
,"TcssListCardiacArrestDownTimeId" 
,"EstimattedDownTime" 
,"TcssListCprAdministeredId" 
,"Duration" 
,"DonorHighlights" 
,"AdmissionCourseComments"  )  
VALUES   
(    @TcssDonorHlaId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssListAboId  
,@DateOfBirth  
,@Age  
,@TcssListAgeUnitId  
,@TcssListGenderId  
,@HeightFeet  
,@HeightInches  
,@Weight  
,@Bmi  
,@TcssListEthnicityId  
,@TcssListRaceId  
,@TcssListCauseOfDeathId  
,@TcssListMechanismOfDeathId  
,@TcssListCircumstancesOfDeathId  
,@TcssListDonorDefinitionId  
,@TcssListDonorDbdSubDefinitionId  
,@TcssListDonorDcdSubDefinitionId  
,@TcssListBreathingoverVentId  
,@UwScore  
,@TcssListHemodynamicallyStableId  
,@AdmitDateTime  
,@PronouncedDateTime  
,@CardiacArrestDateTime  
,@CrossClampDateTime  
,@ColdSchemeticTime  
,@TcssListDonorMeetsEcdCriteriaId  
,@TcssListDonorMeetsDcdCriteriaId  
,@TcssListCardiacArrestDownTimeId  
,@EstimattedDownTime  
,@TcssListCprAdministeredId  
,@Duration  
,@DonorHighlights  
,@AdmissionCourseComments   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  