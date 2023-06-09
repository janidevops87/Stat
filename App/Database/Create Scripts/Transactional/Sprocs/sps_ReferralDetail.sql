SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDetail]
GO








/****** Object:  Stored Procedure dbo.sps_ReferralDetail    Script Date: 2/24/99 1:12:47 AM ******/
/****** Object:  Stored Procedure dbo.sps_ReferralDetail    Script Date: 9/11/97 7:20:13 PM ******/
CREATE PROCEDURE sps_ReferralDetail
	@vCallID	int		= null,
	@vReferralID	int		= null,
	@vTZ		varchar(2) 	= null
AS


DECLARE
	@vHour		smallint,
	@vCallDateTime	smallDateTime

	IF RIGHT(@vTZ, 1) = 'S' -- get at calldatetime if the Time Zone is standard else just get a time zone difference without date
	BEGIN
		SELECT @vCallDateTime = CallDateTime FROM Call WHERE CallID = @vCallID
	END

	
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vCallDateTime

	/*	
	Call Section		
	*/
	SELECT
	Call.CallID,
	ReferralID, 
	CallNumber, 
	DATEADD(hour, @vHour, CallDateTime) AS CallDateTime,
	CONVERT(char(8), DATEADD(hour, @vHour, CallDateTime), 1) AS CallDate,
	CONVERT(char(5), DATEADD(hour, @vHour, CallDateTime), 8) AS CallTime,
	PersonFirst AS StatEmployeeFirstName, 
	PersonLast AS StatEmployeeLastName, 
	ReferralTypeName,
	'Complete'  AS Status,
	Call.SourceCodeID,
	SourceCodeName,
	Referral.ReferralTypeID
	INTO #TempCall
	FROM Call
	JOIN Referral ON Referral.CallID = Call.CallID
	JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
	JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	JOIN Person ON Person.PersonID = StatEmployee.PersonID
	WHERE Call.CallID = @vCallID
	/*	
	Caller 1 Section		
	*/
	SELECT
	ReferralID, 
	PersonFirst AS CallerFirst, 
	PersonLast AS CallerLast, 
	PersonTypeName
	INTO #TempCaller1
	FROM Referral
	LEFT JOIN Person ON Person.PersonID = Referral.ReferralCallerPersonID
	LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
	WHERE ReferralID = @vReferralID
	/*	
	Caller 2 Section		
	*/
	SELECT
	ReferralID, 
	ReferralCallerOrganizationID,
	OrganizationName, 
	SubLocationName, 
	SubLocationLevelName,
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS CallerPhone,
	ReferralCallerExtension
	INTO #TempCaller2
	FROM Referral
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID
	LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID
	LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID
	WHERE ReferralID = @vReferralID
	/*	
	Patient Section		
	*/
	SELECT
	ReferralID, 
	ReferralDonorFirstName,
	ReferralDonorLastName,
	CASE 	WHEN ReferralDonorSSN IS NULL 
		THEN ReferralDonorRecNumber
		ELSE ReferralDonorRecNumber + ' - ' + ReferralDonorSSN 
		END As ReferralDonorRecNumber,
	ReferralDonorAge,
	ReferralDonorAgeUnit,
	ReferralDonorGender,
	ReferralDonorWeight,
	ReferralDonorOnVentilator,
	CONVERT(char(8), ReferralDonorAdmitDate, 1) AS AdmitDate,
	ReferralDonorAdmitTime,
	CONVERT(char(8), ReferralDonorDeathDate, 1) AS DeathDate, 
	ReferralDonorDeathTime,
	ReferralNotesCase,
	RaceName, 
	CauseOfDeathName
	INTO #TempPatient
	FROM Referral
	LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID
	LEFT JOIN Race ON RaceID = ReferralDonorRaceID
	WHERE ReferralID = @vReferralID
	/*	
	Additional 1 Section		
	*/
	SELECT
	ReferralID, 
	ApproachTypeName, 
	PersonFirst AS ApproachByFirst, 
	PersonLast AS ApproachByLast,
	Referral.ReferralApproachNOK, 
	Referral.ReferralApproachRelation, 
	Referral.ReferralNOKPhone, 
	Referral.ReferralNOKAddress,
	Referral.ReferralCoronerName, 
	Referral.ReferralCoronerOrganization, 
	Referral.ReferralCoronerPhone, 
	Referral.ReferralCoronerNote,
	Referral.ReferralGeneralConsent,
	Referral.ReferralApproachTime,
	Referral.ReferralConsentTime
	INTO #TempAdditional1
	FROM Referral
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID
	LEFT JOIN Person ON Person.PersonID = Referral.ReferralApproachedByPersonID
	WHERE ReferralID = @vReferralID
	/*	
	Additional 2 Section		
	*/
	SELECT
	ReferralID,
	AttendingPerson.PersonFirst AS AttendingFirstName,
	AttendingPerson.PersonLast AS AttendingLastName,
	PronouncingPerson.PersonFirst AS PronouncingFirstName,
	PronouncingPerson.PersonLast AS PronouncingLastName
	INTO #TempAdditional2
	FROM Referral
	LEFT JOIN Person AS AttendingPerson ON AttendingPerson.PersonID = Referral.ReferralAttendingMD
	LEFT JOIN Person AS PronouncingPerson ON PronouncingPerson.PersonID = Referral.ReferralPronouncingMD
	WHERE ReferralID = @vReferralID
	/*	
	Organ Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS OrganAppropriate,
    	ApproachReportName AS OrganApproach,
    	ConsentReportName AS OrganConsent,
    	ConversionReportName As OrganConversion
    	INTO #TempOrgan
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralOrganAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralOrganApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralOrganConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralOrganConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Bone Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS BoneAppropriate,
    	ApproachReportName AS BoneApproach,
    	ConsentReportName AS BoneConsent,
    	ConversionReportName As BoneConversion
    	INTO #TempBone
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralBoneAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralBoneApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralBoneConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralBoneConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Tissue Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS TissueAppropriate,
    	ApproachReportName AS TissueApproach,
    	ConsentReportName AS TissueConsent,
    	ConversionReportName As TissueConversion
    	INTO #TempTissue
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralTissueAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralTissueApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralTissueConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralTissueConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Skin Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS SkinAppropriate,
    	ApproachReportName AS SkinApproach,
    	ConsentReportName AS SkinConsent,
    	ConversionReportName As SkinConversion
    	INTO #TempSkin
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralSkinAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralSkinApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralSkinConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralSkinConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Valves Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS ValvesAppropriate,
    	ApproachReportName AS ValvesApproach,
    	ConsentReportName AS ValvesConsent,
    	ConversionReportName As ValvesConversion
    	INTO #TempValves
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralValvesAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralValvesApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralValvesConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralValvesConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Eyes Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS EyesAppropriate,
    	ApproachReportName AS EyesApproach,
    	ConsentReportName AS EyesConsent,
    	ConversionReportName As EyesConversion
    	INTO #TempEyes
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralEyesTransAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralEyesTransApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralEyesTransConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralEyesTransConversionID
    	WHERE ReferralID = @vReferralID
	/*	
	Research Section		
	*/
    	SELECT ReferralID,
    	AppropriateReportName AS ResearchAppropriate,
    	ApproachReportName AS ResearchApproach,
    	ConsentReportName AS ResearchConsent,
    	ConversionReportName As ResearchConversion
    	INTO #TempResearch
    	FROM Referral
    	LEFT JOIN Appropriate ON AppropriateID = ReferralEyesRschAppropriateID
    	LEFT JOIN Approach ON ApproachID = ReferralEyesRschApproachID
    	LEFT JOIN Consent ON ConsentID = ReferralEyesRschConsentID
    	LEFT JOIN Conversion ON ConversionID = ReferralEyesRschConversionID
    	WHERE ReferralID = @vReferralID
	/*************************************************
	Final Section - Returns all referral detail fields		
	**************************************************/
	SELECT
	#TempCall.ReferralID, 
	CallID, 
	CallNumber, 
	CallDateTime, 
	CallDate, 
	CallTime,
	StatEmployeeFirstName, 
	StatEmployeeLastName, 
	Status, 
	SourceCodeID,
	SourceCodeName,
	ReferralTypeID,
	ReferralTypeName,
	ReferralDonorLastName, 
	ReferralDonorFirstName, 
	OrganizationName,	
	CallerFirst, 
	CallerLast, 
	PersonTypeName, 
	SubLocationName, 
	SubLocationLevelName, 
	CallerPhone, 
	ReferralCallerExtension,
	ReferralDonorRecNumber,
	ReferralDonorAge, 
	ReferralDonorAgeUnit, 
	ReferralDonorGender, 
	ReferralDonorWeight,
	ReferralDonorOnVentilator, 
	AdmitDate,
	ReferralDonorAdmitTime, 
	DeathDate, 
	ReferralDonorDeathTime,
	ReferralNotesCase, 
	RaceName, 
	CauseOfDeathName,
	ApproachTypeName, 
	ApproachByFirst, 
	ApproachByLast,
	ReferralApproachNOK, 
	ReferralApproachRelation, 
	ReferralNOKPhone, 
	ReferralNOKAddress,
	ReferralCoronerName, 
	ReferralCoronerOrganization, 
	ReferralCoronerPhone, 
	ReferralCoronerNote,
	AttendingFirstName, 
	AttendingLastName,
	PronouncingFirstName, 
	PronouncingLastName,
	OrganAppropriate, OrganApproach, OrganConsent, OrganConversion, 
	BoneAppropriate, BoneApproach, BoneConsent, BoneConversion, 
	TissueAppropriate, TissueApproach, TissueConsent, TissueConversion, 
	SkinAppropriate, SkinApproach, SkinConsent, SkinConversion, 
	ValvesAppropriate, ValvesApproach, ValvesConsent, ValvesConversion, 
	EyesAppropriate, EyesApproach, EyesConsent, EyesConversion,
	ResearchAppropriate, ResearchApproach, ResearchConsent, ResearchConversion,
	ReferralCallerOrganizationID, ReferralGeneralConsent,
	ReferralApproachTime,
	ReferralConsentTime
	FROM #TempCall
	LEFT JOIN #TempCaller1 ON #TempCaller1.ReferralID = #TempCall.ReferralID
	LEFT JOIN #TempCaller2 ON #TempCaller2.ReferralID = #TempCall.ReferralID
	LEFT JOIN #TempPatient ON #TempPatient.ReferralID = #TempCall.ReferralID
	LEFT JOIN #TempAdditional1 ON #TempAdditional1.ReferralID = #TempCall.ReferralID
	LEFT JOIN #TempAdditional2 ON #TempAdditional2.ReferralID = #TempCall.ReferralID
        LEFT JOIN #TempOrgan ON #TempOrgan.ReferralID = #TempCall.ReferralID 
        LEFT JOIN #TempBone ON #TempBone.ReferralID = #TempCall.ReferralID 
        LEFT JOIN #TempTissue ON #TempTissue.ReferralID = #TempCall.ReferralID
        LEFT JOIN #TempSkin ON #TempSkin.ReferralID = #TempCall.ReferralID 
        LEFT JOIN #TempValves ON #TempValves.ReferralID = #TempCall.ReferralID 
        LEFT JOIN #TempEyes ON #TempEyes.ReferralID = #TempCall.ReferralID
        LEFT JOIN #TempResearch ON #TempResearch.ReferralID = #TempCall.ReferralID









GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

