 /****************************************************************************** 
**  File:  
**  Name: spu_Audit_TcssDonorHla.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  jim hawkins   Update Audit records for DBO.TcssDonorHla**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_TcssDonorHla]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin drop procedure [dbo].[spu_Audit_TcssDonorHla]
 PRINT 'Drop Sproc: spu_Audit_TcssDonorHla'  
 END   
 go
 PRINT 'Create Sproc: spu_Audit_TcssDonorHla'  
 go
   create procedure "spu_Audit_TcssDonorHla"  
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
,@AdmissionCourseComments varchar(2000) 
,@PKC1 int 
,@Bitmap binary(5)  )  
AS  
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --LastUpdateStatEmployeeId  
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --LastUpdateDate  
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --TcssDonorId  
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --TcssListAboId  
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --DateOfBirth  
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --Age  
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --TcssListAgeUnitId  
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --TcssListGenderId  
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --HeightFeet  
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --HeightInches  
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --Weight  
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --Bmi  
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --TcssListEthnicityId  
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --TcssListRaceId  
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --TcssListCauseOfDeathId  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --TcssListMechanismOfDeathId  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --TcssListCircumstancesOfDeathId  
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --TcssListDonorDefinitionId  
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --TcssListDonorDbdSubDefinitionId  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --TcssListDonorDcdSubDefinitionId  
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --TcssListBreathingoverVentId  
AND SUBSTRING(@Bitmap, 3, 1) & 64 <> 64 --UwScore  
AND SUBSTRING(@Bitmap, 3, 1) & 128 <> 128 --TcssListHemodynamicallyStableId  
AND SUBSTRING(@Bitmap, 4, 1) & 1 <> 1 --AdmitDateTime  
AND SUBSTRING(@Bitmap, 4, 1) & 2 <> 2 --PronouncedDateTime  
AND SUBSTRING(@Bitmap, 4, 1) & 4 <> 4 --CardiacArrestDateTime  
AND SUBSTRING(@Bitmap, 4, 1) & 8 <> 8 --CrossClampDateTime  
AND SUBSTRING(@Bitmap, 4, 1) & 16 <> 16 --ColdSchemeticTime  
AND SUBSTRING(@Bitmap, 4, 1) & 32 <> 32 --TcssListDonorMeetsEcdCriteriaId  
AND SUBSTRING(@Bitmap, 4, 1) & 64 <> 64 --TcssListDonorMeetsDcdCriteriaId  
AND SUBSTRING(@Bitmap, 4, 1) & 128 <> 128 --TcssListCardiacArrestDownTimeId  
AND SUBSTRING(@Bitmap, 5, 1) & 1 <> 1 --EstimattedDownTime  
AND SUBSTRING(@Bitmap, 5, 1) & 2 <> 2 --TcssListCprAdministeredId  
AND SUBSTRING(@Bitmap, 5, 1) & 4 <> 4 --Duration  
AND SUBSTRING(@Bitmap, 5, 1) & 8 <> 8 --DonorHighlights  
AND SUBSTRING(@Bitmap, 5, 1) & 16 <> 16 --AdmissionCourseComments   
)   
 begin 
 DECLARE @CheckForBlank VARCHAR(250); 
 SELECT @CheckForBlank = ISNULL(CAST(@LastUpdateStatEmployeeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@LastUpdateDate AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssDonorId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListAboId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DateOfBirth AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Age AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListAgeUnitId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListGenderId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HeightFeet AS VARCHAR(1)), '') 
+ ISNULL(CAST(@HeightInches AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Weight AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Bmi AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListEthnicityId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListRaceId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCauseOfDeathId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListMechanismOfDeathId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCircumstancesOfDeathId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorDefinitionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorDbdSubDefinitionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorDcdSubDefinitionId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListBreathingOverVentId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@UwScore AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListHemodynamicallyStableId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AdmitDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@PronouncedDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@CardiacArrestDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@CrossClampDateTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@ColdSchemeticTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorMeetsEcdCriteriaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListDonorMeetsDcdCriteriaId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCardiacArrestDownTimeId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@EstimattedDownTime AS VARCHAR(1)), '') 
+ ISNULL(CAST(@TcssListCprAdministeredId AS VARCHAR(1)), '') 
+ ISNULL(CAST(@Duration AS VARCHAR(1)), '') 
+ ISNULL(CAST(@DonorHighlights AS VARCHAR(1)), '') 
+ ISNULL(CAST(@AdmissionCourseComments AS VARCHAR(1)), '')--If the only chnage to the record is date time --it is a review not update. IF @CheckForBlank IS NULL BEGIN SET @AuditLogTypeID = 2 END
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
( 
 @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@LastUpdateStatEmployeeId, 0) = 0 THEN -2 ELSE @LastUpdateStatEmployeeId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastUpdateDate, '') = '' THEN '1900-01-01'  ELSE @LastUpdateDate END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@TcssDonorId, 0) = 0 THEN -2 ELSE @TcssDonorId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@TcssListAboId, 0) = 0 THEN -2 ELSE @TcssListAboId END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@DateOfBirth, '') = '' THEN '1900-01-01'  ELSE @DateOfBirth END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@Age, 0) = 0 THEN -2 ELSE @Age END, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@TcssListAgeUnitId, 0) = 0 THEN -2 ELSE @TcssListAgeUnitId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@TcssListGenderId, 0) = 0 THEN -2 ELSE @TcssListGenderId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@HeightFeet, 0) = 0 THEN -2 ELSE @HeightFeet END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@HeightInches, 0) = 0 THEN -2 ELSE @HeightInches END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@Weight, 0) = 0 THEN -2 ELSE @Weight END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@Bmi, 0) = 0 THEN -2 ELSE @Bmi END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@TcssListEthnicityId, 0) = 0 THEN -2 ELSE @TcssListEthnicityId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@TcssListRaceId, 0) = 0 THEN -2 ELSE @TcssListRaceId END, 
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@TcssListCauseOfDeathId, 0) = 0 THEN -2 ELSE @TcssListCauseOfDeathId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@TcssListMechanismOfDeathId, 0) = 0 THEN -2 ELSE @TcssListMechanismOfDeathId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@TcssListCircumstancesOfDeathId, 0) = 0 THEN -2 ELSE @TcssListCircumstancesOfDeathId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@TcssListDonorDefinitionId, 0) = 0 THEN -2 ELSE @TcssListDonorDefinitionId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@TcssListDonorDbdSubDefinitionId, 0) = 0 THEN -2 ELSE @TcssListDonorDbdSubDefinitionId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@TcssListDonorDcdSubDefinitionId, 0) = 0 THEN -2 ELSE @TcssListDonorDcdSubDefinitionId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@TcssListBreathingOverVentId, 0) = 0 THEN -2 ELSE @TcssListBreathingOverVentId END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@UwScore, '') = '' THEN 'ILB'  ELSE @UwScore END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 128 = 128 AND ISNULL(@TcssListHemodynamicallyStableId, 0) = 0 THEN -2 ELSE @TcssListHemodynamicallyStableId END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 1 = 1 AND ISNULL(@AdmitDateTime, '') = '' THEN '1900-01-01'  ELSE @AdmitDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 2 = 2 AND ISNULL(@PronouncedDateTime, '') = '' THEN '1900-01-01'  ELSE @PronouncedDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 4 = 4 AND ISNULL(@CardiacArrestDateTime, '') = '' THEN '1900-01-01'  ELSE @CardiacArrestDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 8 = 8 AND ISNULL(@CrossClampDateTime, '') = '' THEN '1900-01-01'  ELSE @CrossClampDateTime END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 16 = 16 AND ISNULL(@ColdSchemeticTime, '') = '' THEN 'ILB'  ELSE @ColdSchemeticTime END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 32 = 32 AND ISNULL(@TcssListDonorMeetsEcdCriteriaId, 0) = 0 THEN -2 ELSE @TcssListDonorMeetsEcdCriteriaId END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 64 = 64 AND ISNULL(@TcssListDonorMeetsDcdCriteriaId, 0) = 0 THEN -2 ELSE @TcssListDonorMeetsDcdCriteriaId END, 
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 128 = 128 AND ISNULL(@TcssListCardiacArrestDownTimeId, 0) = 0 THEN -2 ELSE @TcssListCardiacArrestDownTimeId END, 
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 1 = 1 AND ISNULL(@EstimattedDownTime, 0) = 0 THEN -2 ELSE @EstimattedDownTime END, 
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 2 = 2 AND ISNULL(@TcssListCprAdministeredId, 0) = 0 THEN -2 ELSE @TcssListCprAdministeredId END, 
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 4 = 4 AND ISNULL(@Duration, 0) = 0 THEN -2 ELSE @Duration END, 
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 8 = 8 AND ISNULL(@DonorHighlights, '') = '' THEN 'ILB'  ELSE @DonorHighlights END, 
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 16 = 16 AND ISNULL(@AdmissionCourseComments, '') = '' THEN 'ILB'  ELSE @AdmissionCourseComments END
)  
END    
GO  

SET QUOTED_IDENTIFIER OFF   
GO  

SET ANSI_NULLS ON   
GO  