if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralSummary]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sps_ReferralSummary
			@CallID as varchar(50)=NULL,
			@ReferralType  as int=NULL,
			@LastName as varchar(100)=NULL,
			@FirstName as varchar(100)=NULL,
			@MedicalRecord as varchar(100)=NULL,
			@CauseOfDeathID as int=NULL,
			@CardiacStartDateTime as DateTime=NULL,
			@CardiacEndDateTime as DateTime=NULL,
			@DateType as varchar(50)=NULL,
			@ReportGroupID as int=NULL,
			@OrganizationID as int=NULL,
			@SourcecodeID as int=NULL,
			@CoordinatorID as int=NULL,
			@LowerAge as int=NULL,
			@UpperAge as int=NULL,
			@Gender as varchar(10)=NULL


 AS
/* 

            Procedure: sps_ReferralSummary

            ISE: Thien Ta

            Date: 03/16/2007

            Inputs:

                        @StartDateTime datetime '01/01/2006 00:00',

                        @EndDateTime datetime '01/31/2006 23:59',

                        @ReportGroupID int 

                       

 

            Notes:   This procedure is for Referral Summary Report . It uses a variable table to get source code list

*/
/**********************************************************************************************************************************
	Variable Table for Source Code List
  *********************************************************************************************************************************/
declare
	@ID  varchar(50),
	@lsCode  varchar(2000),
	@listcount int
	/*@StartDateTime as datetime,
	@EndDateTime as datetime,
	@ReportGroupID as int,
	@FirstName as varchar(100),
	@LastName as varchar(100),
	@MedicalRecord as varchar(100),
	@ReferralType as varchar(50),
	@CauseOfDeathID as int,
	@CallID as varchar(50),
	@DateType as varchar(50),
	@CardiacStartDateTime as DateTime,
	@CardiacEndDateTime as DateTime,
	@OrganizationID as int,
	@SourcecodeName as varchar(20),
	@CoordinatorID as varchar(10),
	@LowerAge as int,
	@UpperAge as int,
	@Gender as varchar(10)
*/


	set @ReportGroupID= 55
	set @FirstName = NULL
	set @FirstName = REPLACE(@FirstName,'*','%');
	set @LastName  = NULL
	set @LastName  = REPLACE(@LastName,'*','%');
	set @MedicalRecord = NULL
	set @MedicalRecord = REPLACE(@MedicalRecord,'*','%');
	set @ReferralType  =  2
	set @CauseOfDeathID = 6
	set @CallID = NULL
	set @CardiacStartDateTime = '02/02/07'
	set @CardiacEndDateTime  = '05/01/07'
	set @OrganizationID = NULL
	set @CoordinatorID = NULL
	set @LowerAge = 2
	set @UpperAge = 90
	Set @Gender = NULL



set @lsCode =  '' 
set @listcount = 1
--Variable Table
declare @tablename table
	(
		id int identity(1,1),
		sourcecodeid int
	)

insert @tablename (sourcecodeid)
SELECT DISTINCT SourceCodeID 
FROM WebReportGroupSourceCode 
WHERE WebReportGroupID = @ReportGroupID
--select * from @tablename
 
 
  
	


SELECT DISTINCT 
Referral.ReferralID, 
Call.CallID, 
CallNumber, 
DATEADD(hour, 0 , CallDateTime) AS CallDateTime, CONVERT(char(8), 
DATEADD(hour, 0 , CallDateTime), 1) AS CallDate, 
CONVERT(char(5), DATEADD(hour, 0 , CallDateTime), 8) AS CallTime, 
 Referral.ReferralTypeID, 
ReferralTypeName, 
ReferralDonorLastName, 
ReferralDonorFirstName, 
OrganizationName, 
CallerPerson.PersonFirst AS CallPersonFirst, 
CallerPerson.PersonLast AS CallerPersonLast, 
SubLocationName, 
ReferralCallerSubLocationLevel, 
ReferralDonorRecNumber, 
ReferralDonorAge, 
ReferralDonorAgeUnit, 
ReferralDonorGender,
convert(char(8),ReferralDonorDeathDate,1),
ReferralDonorDeathTime, ReferralDonorDeathDate, 
RaceName, 
CauseOfDeathName,
approachtype.ApproachTypeName, 
ApproachPerson.PersonFirst AS ApproachPersonFirst, 
ApproachPerson.PersonLast AS ApproachPersonLast, 
AppropOrgan.AppropriateReportName AS AppropriateOrgan,
AppropEyesTrans.AppropriateReportName as AppropriateEyesTrans,
ApproaOrgan.ApproachReportName AS ApproachOrgan,
ApproaEyesTrans.ApproachReportName as ApproachEyesTrans, 
ConsentOrgan.ConsentReportName AS ConsentOrgan, 
ConsentEyesTrans.ConsentReportName as ConsentEyesTrans,
RecoveryOrgan.ConversionReportName AS RecoveryOrgan, 
RecoveryEyesTrans.ConversionReportName as RecoveryEyesTrans, 
AppropBone.AppropriateReportName AS AppropriateBone, 
ApproaBone.ApproachReportName AS ApproachBone,
ConsentBone.ConsentReportName AS ConsentBone, 
RecoveryBone.ConversionReportName AS RecoveryBone, 
AppropTissue.AppropriateReportName AS AppropriateTissue, 
ApproaTissue.ApproachReportName AS ApproachTissue, 
ConsentTissue.ConsentReportName AS ConsentTissue, 
RecoveryTissue.ConversionReportName AS RecoveryTissue,
AppropSkin.AppropriateReportName AS AppropriateSkin, 
ApproaSkin.ApproachReportName AS ApproachSkin, 
ConsentSkin.ConsentReportName AS ConsentSkin, 
RecoverySkin.ConversionReportName AS RecoverySkin,
 AppropValve.AppropriateReportName AS AppropriateValves,
 ApproaValve.ApproachReportName AS ApproachValves, 
ConsentValve.ConsentReportName AS ConsentValve, 
RecoveryValve.ConversionReportName AS RecoveryValve, 
AppropEyes.AppropriateReportName AS AppropriateEyes,
 ApproaEyes.ApproachReportName AS ApproachEyes, 
ConsentEyes.ConsentReportName AS ConsentEyes, 
RecoveryEyes.ConversionReportName AS RecoveryEyes, 
Referral.ReferralApproachTypeId, 
CASE ReferralGeneralConsent 
WHEN 1 THEN 'Yes - Written' WHEN 2 THEN 'Yes - Verbal' WHEN 3 THEN 'No' ELSE 'No Outcome' END as OutCome, 
ReferralGeneralConsent ,
CASE SecondaryApproachOutCome
WHEN 1 THEN 'Yes - Written' WHEN 2 THEN 'Yes - Verbal' WHEN 3 THEN 'No' ELSE 'No Outcome' END as SecondaryApproachOutCome,
SecondaryApproach.Secondaryapproachedby,
Perap.PersonFirst,
Perap.PersonLast, 
appty.approachtypename as ApproachTypeNameFS,
RegistryStatusType.RegistryType , 
1 as one  
FROM Call 
LEFT JOIN Referral ON Referral.CallID = Call.CallID 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD
LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD 
LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID
LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID
LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID
LEFT JOIN  Appropriate AppropEyesTrans ON AppropEyesTrans.AppropriateID = Referral.ReferralEyesTransAppropriateID
 LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
LEFT JOIN Approach ApproaEyesTrans ON ApproaEyesTrans.ApproachID = Referral.ReferralEyesTransApproachID
LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID
LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID
LEFT JOIN  Consent ConsentEyesTrans ON ConsentEyesTrans.ConsentID = Referral.ReferralEyesTransConsentID
LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID
LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID
LEFT JOIN Conversion RecoveryEyesTrans ON RecoveryEyesTrans.ConversionID = Referral.ReferralEyesTransConversionID
LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID 
LEFT JOIN secondaryapproach ON secondaryapproach.CallID = Call.CallID
LEFT JOIN person perap ON perap.PersonID = SecondaryApproach.Secondaryapproachedby
LEFT JOIN ApproachType appty ON appty.ApproachTypeID = SecondaryApproach.Secondaryapproachtype
LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID

WHERE WebReportGroupOrg.WebReportGroupID = @ReportGroupID
and CALL.SourceCodeID IN (--22,325
select sourcecodeid from @tablename
) 
And ReferralDonorFirstName like 		ISNULL(@firstName,ReferralDonorFirstName)
and ReferralDonorLastName  like 		ISNULL(@LastName,ReferralDonorLastName)
--and ReferralDonorRecNumber like 		ISNULL(@MedicalRecord,ReferralDonorRecNumber)
and referral.referralTypeID 	=		ISNULL(@ReferralType ,referral.ReferralTypeID)
and CauseOfDeathID = 				ISNULL(@CauseOfDeathID,CauseOfDeathID)
and referral.CallID = 				ISNULL(@CallID,referral.CallID)
--and referral.ReferralDonorDeathDate >= 		ISNULL(@CardiacStartDateTime,Referral.ReferralDonorDeathDate)
--and referral.ReferralDonorDeathDate <= 		ISNULL(@CardiacEndDateTime,Referral.ReferralDonorDeathDate)
and Organization.OrganizationID = 	 	ISNULL(@OrganizationID,Organization.OrganizationID)
and Call.StatEmployeeID=			ISNULL(@CoordinatorID,Call.StatEmployeeID)
and Referral.ReferralDonorAge >= 		ISNULL(@LowerAge,Referral.ReferralDonorAge)
and Referral.ReferralDonorAge <=		ISNULL(@UpperAge,Referral.ReferralDonorAge)
and ReferralDonorGender=			ISNULL(@Gender,ReferralDonorGender)
ORDER BY 
Referral.ReferralTypeID, 
CallDateTime,
Call.CallID
GO


/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'sps_ReferralSummary create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - sps_ReferralSummary created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

