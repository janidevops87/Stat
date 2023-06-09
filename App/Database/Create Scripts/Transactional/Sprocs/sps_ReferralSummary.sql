SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralSummary]
GO


CREATE PROCEDURE sps_ReferralSummary
			@StartDateTime as datetime,
			@EndDateTime as datetime,
			@ReportGroupID as int


 AS

SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, DATEADD(hour, 0 , CallDateTime) AS CallDateTime, CONVERT(char(8), 
DATEADD(hour, 0 , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, 0 , CallDateTime), 8) AS CallTime, 
' Field 6', ' Field 7', ' Field 8', ' Field 9',' Field 10', Referral.ReferralTypeID, ReferralTypeName, ReferralDonorLastName, ReferralDonorFirstName, 
OrganizationName, CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, ' Field 18', SubLocationName, 
ReferralCallerSubLocationLevel, ' Field 21', ' Field 22', ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender,
 ' Field 27', ' Field 28', ' Field 29', ' Field 30', convert(char(8),ReferralDonorDeathDate,1),ReferralDonorDeathTime, ' Field 33', RaceName, 
CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS 
ApproachPersonLast, ' Field 39', ' Field 40', ' Field 41',' Field 42',' Field 43',' Field 44',' Field 45',' Field 46', AppropOrgan.AppropriateReportName 
AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, 
RecoveryOrgan.ConversionReportName AS RecoveryOrgan, AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName 
AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, AppropTissue.AppropriateReportName 
AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, 
RecoveryTissue.ConversionReportName AS RecoveryTissue,AppropSkin.AppropriateReportName AS AppropriateSkin, 
ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.
ConversionReportName AS RecoverySkin, AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName 
AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, AppropEyes.AppropriateReportName 
AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName 
AS RecoveryEyes, ' Field 71',' Field 72',' Field 73',' Field 74', ' Field 75', ' Field 76', ' Field 77', ' Field 78', Referral.ReferralApproachTypeId, CASE ReferralGeneralConsent 
WHEN 1 THEN 'Yes - Written' WHEN 2 THEN 'Yes - Verbal' WHEN 3 THEN 'No' ELSE 'No Outcome'    END as OutCome FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
 LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
 LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN Person ApproachPerson 
ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD
 LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
 LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN SubLocation 
ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID
 LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID LEFT JOIN ApproachType 
ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID
 LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID LEFT JOIN Appropriate AppropTissue 
ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID LEFT JOIN Appropriate AppropEyes
 ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID LEFT JOIN Approach ApproaTissue 
ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID LEFT JOIN Approach ApproaEyes 
ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID
 LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID LEFT JOIN Consent ConsentTissue 
ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID
 LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID LEFT JOIN Consent ConsentEyes 
ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID
 LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID LEFT JOIN Conversion RecoveryTissue 
ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID LEFT JOIN Conversion RecoveryEyes 
ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID 
LEFT JOIN RegistryStatus 
ON RegistryStatus.CallID = Referral.CallID 
WHERE CallDateTime BETWEEN @StartDateTime AND @EndDateTime
AND WebReportGroupOrg.WebReportGroupID = @ReportGroupID
AND CALL.SourceCodeID IN (22,325 ) ORDER BY Referral.ReferralTypeID, OrganizationName, CallDateTime
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

