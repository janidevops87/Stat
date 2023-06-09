SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineRefSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineRefSave]
GO




CREATE PROCEDURE sps_OnlineRefSave 
	@vCallID as int,
	@vFirstName as varchar(100) ='Bill',
	@vLastName as varchar(100)='Buddy',
	@vDOB as datetime  = Null,
	@vAge as int = 55,
	@vSex as varchar(4) = 'M',
	@vRace as int = 2,
	@vFacility as int =3,
	@vUnit as int = null , 
	@vFloor as varchar(100)= null ,
	@vDateDeath as datetime  =Null,
	@vCardDeath as varchar(20)  = null,
	@vPhone as int = null,
	@vExt as varchar(50) = null,
	@vPersonID as varchar(20) = null



AS
INSERT INTO Referral (CallID, ReferralCallerPhoneID, ReferralCallerExtension, ReferralCallerOrganizationID, ReferralCallerSubLocationID,
 ReferralCallerSubLocationLevel, ReferralCallerLevelID, ReferralCallerPersonID, ReferralDonorFirstName, ReferralDonorLastName, 
ReferralDonorName, ReferralDonorRecNumber, ReferralDonorSSN, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, 
ReferralDonorGender, ReferralDonorWeight, ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorDeathDate,
 ReferralDonorDeathTime, ReferralDonorCauseOfDeathID, ReferralDonorOnVentilator, ReferralExtubated, ReferralDOB, 
ReferralDOA, ReferralNotesCase, ReferralTypeID, ReferralApproachTypeID, ReferralApproachedByPersonID,
 ReferralGeneralConsent, ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, ReferralNOKAddress, 
ReferralAttendingMD, ReferralPronouncingMD, ReferralCoronersCase, ReferralCoronerName, ReferralCoronerPhone, 
ReferralCoronerOrganization, ReferralCoronerNote, ReferralOrganAppropriateID, 
ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID,
 ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, 
ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, 
ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralValvesAppropriateID, 
ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, ReferralEyesTransAppropriateID, 
ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, 
ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, DonorRegistryType, DonorRegId,
 DonorDMVId, DonorDMVTable, DonorIntentDone, DonorFaxSent, DonorDSNID, ReferralDonorHeartBeat) VALUES (@vCallID,@vPhone,@vExt,@vFacility ,@vUnit,@vFloor,-1,@vPersonID,@vFirstName,@vLastName,@vFirstName+' '+@vLastName,NULL,NULL,@vAge,'Years',@vRace,@vSex,NULL,NULL,NULL,@vDateDeath,@vCardDeath,12,'Never',NULL,@vDOB,0,NULL,4,1,0,-
1,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,5,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,0,0,0,NULL,0,0,0,0)



--UPDATE Referral SET CallID = 4414116,ReferralCallerPhoneID = 67950,ReferralCallerExtension = NULL,ReferralCallerOrganizationID = 5075,ReferralCallerSubLocationID = 50,ReferralCallerSubLocationLevel = '1',ReferralCallerLevelID = 1,ReferralCallerPersonID = 821690,ReferralDonorFirstName = 'Joe',ReferralDonorLastName = 'Tester',ReferralDonorName = 'Joe Tester',ReferralDonorRecNumber = NULL,ReferralDonorSSN = NULL,ReferralDonorAge = '22',ReferralDonorAgeUnit = 'Years',ReferralDonorRaceID = 3,ReferralDonorGender = 'M',ReferralDonorWeight = NULL,ReferralDonorAdmitDate = NULL,ReferralDonorAdmitTime = NULL,ReferralDonorDeathDate = '11/03/06',ReferralDonorDeathTime = '33:33',ReferralDonorCauseOfDeathID = 12,ReferralDonorOnVentilator = 'Never',ReferralExtubated = NULL,ReferralDOB = '12/21/1981',ReferralDOA = 0,ReferralNotesCase = NULL,ReferralTypeID = 4,ReferralApproachTypeID = 1,ReferralApproachedByPersonID = 0,ReferralGeneralConsent = -1,ReferralApproachNOK = NULL,ReferralApproachRelation = NULL,ReferralNOKPhone = NU
--LL,ReferralNOKAddress = NULL,ReferralAttendingMD = 0,ReferralPronouncingMD = 0,ReferralCoronersCase = 0,ReferralCoronerName = NULL,ReferralCoronerPhone = NULL,ReferralCoronerOrganization = NULL,ReferralCoronerNote = NULL,ReferralOrganAppropriateID = 5,ReferralOrganApproachID = -1,ReferralOrganConsentID = -1,ReferralOrganConversionID = -1,ReferralBoneAppropriateID = 2,ReferralBoneApproachID = -1,ReferralBoneConsentID = -1,ReferralBoneConversionID = -1,ReferralTissueAppropriateID = 5,ReferralTissueApproachID = -1,ReferralTissueConsentID = -1,ReferralTissueConversionID = -1,ReferralSkinAppropriateID = 2,ReferralSkinApproachID = -1,ReferralSkinConsentID = -1,ReferralSkinConversionID = -1,ReferralValvesAppropriateID = 2,ReferralValvesApproachID = -1,ReferralValvesConsentID = -1,ReferralValvesConversionID = -1,ReferralEyesTransAppropriateID = 2,ReferralEyesTransApproachID = -1,ReferralEyesTransConsentID = -1,ReferralEyesTransConversionID = -1,ReferralEyesRschAppropriateID = 2,ReferralEyesRschApproachID = -1,Referr
--alEyesRschConsentID = -1,ReferralEyesRschConversionID = -1,DonorRegistryType = 0,DonorRegId = 0,DonorDMVId = 0,DonorDMVTable = NULL,DonorIntentDone = 0,DonorFaxSent = 0,DonorDSNID = 0,ReferralDonorHeartBeat = 0 WHERE CallID = 4414116
--set @vDOB = current_timestamp
--set @vDateDeath = current_timestamp
--set @vCardDeath = current_timestamp
--INSERT INTO Referral (CallID, ReferralCallerPhoneID, ReferralCallerExtension, ReferralCallerOrganizationID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel, ReferralCallerLevelID, ReferralCallerPersonID, ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorName, ReferralDonorRecNumber, ReferralDonorSSN, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, ReferralDonorGender, ReferralDonorWeight, ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralDonorCauseOfDeathID, ReferralDonorOnVentilator, ReferralExtubated, ReferralDOB, ReferralDOA, ReferralNotesCase, ReferralTypeID, ReferralApproachTypeID, ReferralApproachedByPersonID, ReferralGeneralConsent, ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, ReferralNOKAddress, ReferralAttendingMD, ReferralPronouncingMD, ReferralCoronersCase, ReferralCoronerName, ReferralCoronerPhone, ReferralCoronerOrganization, ReferralCoronerNote, ReferralOrganAppropriateID, 
--ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, DonorRegistryType, DonorRegId, DonorDMVId, DonorDMVTable, DonorIntentDone, DonorFaxSent, DonorDSNID, ReferralDonorHeartBeat) VALUES (@vCallID,Null,Null,@vFacility ,@vUnit,@vFloor,-1,745570,@vFirstName,@vLastName,@vFirstName+@vLastName,NULL,NULL,@vAge,'Years',@vRace,@vSex,NULL,NULL,NULL,@vDateDeath,@vCardDeath,11,'Never',NULL,@vDOB,0,NULL,4,1,0,-
--1,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,5,-1,-1,-1,2,-1,-1,-1,5,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,2,-1,-1,-1,-1,-1,-1,-1,0,0,0,NULL,0,0,0,0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

