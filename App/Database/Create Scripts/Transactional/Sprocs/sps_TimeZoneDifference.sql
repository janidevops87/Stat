SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_TimeZoneDifference]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_TimeZoneDifference]
GO


/*

declare @test int
select @test = call sps_TimeZoneDifference() 
select @test
SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, 
DATEADD(hour, @test , CallDateTime) AS CallDateTime
-- CONVERT(char(8), DATEADD(hour, , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, , CallDateTime), 8) AS CallTime, StatPerson.PersonFirst AS StatPersonFirstName, StatPerson.PersonLast AS StatPersonLastName, ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit, Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, ReferralDonorLastName, ReferralDonorFirstName, OrganizationName, CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, CallPersonType.PersonTypeName AS CallerPersonTitle, SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber , ReferralCallerExtension, Case when ReferralDonorSSN is not null THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN ELSE ReferralDonorRecNumber END AS ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ReferralDonorWeight, ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1), ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1), ReferralDonorDeathTime, ReferralNotesCase, RaceName, CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, ReferralNOKAddress, ReferralCoronerName, ReferralCoronerOrganization, ReferralCoronerPhone, ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, '','','','', ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime, ReferralSecondaryHistory, ReferralExtubated 
FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID WHERE Call.CALLID = 1126613 

-- drop procedure sps_TimeZoneDifference
*/


Create Procedure sps_TimeZoneDifference
     --@pvCallDateTime int = null
     --@TimeZone     varchare(2) = null
AS

Select 1 result

/*

    Select Case TimeZone
    
        Case "AT"
            AdjustTimeZone = DateAdd("h", 3, pvDateTime)
        Case "AS"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 2, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 3, pvDateTime)
			End If    
    
        Case "ET"
            AdjustTimeZone = DateAdd("h", 2, pvDateTime)
        Case "ES"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 1, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 2, pvDateTime)
			End If
            
        Case "CT"
            AdjustTimeZone = DateAdd("h", 1, pvDateTime)
        Case "CS"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 0, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 1, pvDateTime)
			End If
			    
        Case "MT"
            AdjustTimeZone = DateAdd("h", 0, pvDateTime)
            
        Case "MS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -1, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 0, pvDateTime)
			End If

        Case "PT"
            AdjustTimeZone = DateAdd("h", -1, pvDateTime)
        Case "PS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -2, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -1, pvDateTime)
			End If

        Case "KT"
            AdjustTimeZone = DateAdd("h", -2, pvDateTime)
        Case "KS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -3, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -2, pvDateTime)
			End If
        Case "HT"
            AdjustTimeZone = DateAdd("h", -3, pvDateTime)
        Case "HS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -4, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -3, pvDateTime)
			End If
       
        Case "ST"
            AdjustTimeZone = DateAdd("h", -4, pvDateTime)
        Case "SS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -5, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -4, pvDateTime)
			End If
*/


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

