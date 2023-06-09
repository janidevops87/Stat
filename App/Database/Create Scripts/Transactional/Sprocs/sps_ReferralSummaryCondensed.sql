SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralSummaryCondensed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralSummaryCondensed]
GO


CREATE PROCEDURE sps_ReferralSummaryCondensed


	@vTZ			varchar(2) 	= null, 
	
	@vStartDate		smalldatetime	= null, 
	@vEndDate		smalldatetime	= null, 

	@vReportGroupID		int		= 0, 

	@vOrgID			int		= 0, 

	@vReferralTypeID	int 		= 0,
	@vOrderBy		varchar(30) 	= null,
	@vUserOrgID		int		= 0


AS

Declare 
	@ReturnValue		int,
	@ExecQuery		varchar(5000),
	@TZD 			int --Time Zone Difference
	
	
	Exec spf_TZDif @vTZ, @TZD OUTPUT, @vStartDate

--Create temp table
Create Table #Temp_Condensed
	(
	-- ReferralID [int] NULL , 
             --CallID [int] NULL, 
             --CallNumber [char] (10) NULL,
             CallDateTime [smalldatetime] NULL , 
	OrganizationName [varchar] (80) NULL ,
            CallerFirst [varchar] (50) NULL , 
            CallerLast [varchar] (50) NULL, 
            ReferralDonorLastName [varchar] (50) NULL, 
            ReferralDonorFirstName [varchar] (50) NULL, 
            SubLocationName  [varchar] (50) NULL ,
            SubLocationLevelName  [varchar] (5) NULL ,
            ReferralDonorGender[char] (1) NULL , 
            Age [varchar] (11), 
            SourceCodeID [int] NULL, 
            SourceCodeName [varchar] (50) NULL, 
            ReferralTypeID [int] NULL, 
            ReferralTypeName [varchar] (50) NULL, 
            OrganAppropriate [varchar] (50) NULL , 
            OrganApproach [varchar] (50) NULL , 
            OrganConsent [varchar] (50) NULL , 
            OrganConversion [varchar] (50) NULL ,
	 BoneAppropriate [varchar] (50) NULL , 
            BoneApproach [varchar] (50) NULL , 
            BoneConsent [varchar] (50) NULL , 
            BoneConversion [varchar] (50) NULL , 
            TissueAppropriate [varchar] (50) NULL , 
            TissueApproach [varchar] (50) NULL , 
            TissueConsent [varchar] (50) NULL , 
            TissueConversion [varchar] (50) NULL ,
            SkinAppropriate [varchar] (50) NULL , 
            SkinApproach [varchar] (50) NULL ,  
            SkinConsent [varchar] (50) NULL ,  
            SkinConversion [varchar] (50) NULL ,
            ValvesAppropriate [varchar] (50) NULL , 
            ValvesApproach [varchar] (50) NULL , 
            ValvesConsent [varchar] (50) NULL , 
            ValvesConversion [varchar] (50) NULL ,
	EyesAppropriate [varchar] (50) NULL , 
            EyesApproach [varchar] (50) NULL , 
            EyesConsent [varchar] (50) NULL , 
            EyesConversion [varchar] (50) NULL, 
	 ResearchAppropriate [varchar] (50) NULL , 
            ResearchApproach [varchar] (50) NULL , 
            ResearchConsent [varchar] (50) NULL , 
            ResearchConversion [varchar] (50) NULL


	)

-- Check to see if userorganization id has access to webreportgroup
If @vUserOrgID <> 194
	EXEC  @ReturnValue  = sps_ReportGroupAuthorization @vReportGroupID, @vUserOrgID
If @vUserOrgID = 194
	Set @ReturnValue = 1


If @ReturnValue = 0 
BEGIN
		Return @ReturnValue
END

ELSE

BEGIN
	If @vReportGroupID > 0 AND @vOrgID = 0
	BEGIN
		
		Insert  #Temp_Condensed
		(	
	    	CallDateTime, 
            		Organization.OrganizationName,
		CallerFirst, 
            		CallerLast, 
            		ReferralDonorLastName, 
           		ReferralDonorFirstName, 
            		SubLocationName,
            		SubLocationLevelName,
            		ReferralDonorGender, 
    		Age, 
            		Call.SourceCodeID, 
            		SourceCode.SourceCodeName, 
            		Referral.ReferralTypeID, 
            		ReferralTypeName, 
            		OrganAppropriate, 
            		OrganApproach, 
            		OrganConsent, 
            		OrganConversion,
    		BoneAppropriate, 
            		BoneApproach, 
            		BoneConsent, 
            		BoneConversion, 
            		TissueAppropriate, 
            		TissueApproach, 
            		TissueConsent, 
            		TissueConversion,
            		SkinAppropriate, 
            		SkinApproach,  
            		SkinConsent,  
            		SkinConversion,
            		ValvesAppropriate, 
            		ValvesApproach, 
            		ValvesConsent, 
            		ValvesConversion,
    		EyesAppropriate, 
            		EyesApproach, 
            		EyesConsent, 
            		EyesConversion,
    		ResearchAppropriate, 
            		ResearchApproach, 
            		ResearchConsent, 
       		ResearchConversion
		)
		
		SELECT 
		DISTINCT    

	    		CallDateTime, 
            			Organization.OrganizationName,
			C.PersonFirst AS CallerFirst, 
            			C.PersonLast AS CallerLast, 
            			ReferralDonorLastName, 
            			ReferralDonorFirstName, 
            			SubLocationName,
            			SubLocationLevelName,
            			ReferralDonorGender, 
    			ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS Age, 
            			Call.SourceCodeID, 
            			SourceCode.SourceCodeName, 
            			Referral.ReferralTypeID, 
            			ReferralTypeName, 
           			AprOrg.AppropriateReportName AS OrganAppropriate, 
            			ApaOrg.ApproachReportName AS OrganApproach, 
            			ConsOrg.ConsentReportName AS OrganConsent, 
            			ConvOrg.ConversionReportName As OrganConversion,

    			AprBone.AppropriateReportName AS BoneAppropriate, 
            			ApaBone.ApproachReportName AS BoneApproach, 
            			ConsBone.ConsentReportName AS BoneConsent, 
            			ConvBone.ConversionReportName As BoneConversion, 

            			AprTis.AppropriateReportName AS TissueAppropriate, 
            			ApaTis.ApproachReportName AS TissueApproach, 
            			ConsTis.ConsentReportName AS TissueConsent, 
            			ConvTis.ConversionReportName As TissueConversion,

            			AprSkin.AppropriateReportName AS SkinAppropriate, 
            			ApaSkin.ApproachReportName AS SkinApproach,  
            			ConsSkin.ConsentReportName AS SkinConsent,  
            			ConvSkin.ConversionReportName As SkinConversion,

            			AprValve.AppropriateReportName AS ValvesAppropriate, 
            			ApaValve.ApproachReportName AS ValvesApproach, 
            			ConsValve.ConsentReportName AS ValvesConsent, 
            			ConvValve.ConversionReportName As ValvesConversion,

    			AprEyes.AppropriateReportName AS EyesAppropriate, 
            			ApaEyes.ApproachReportName AS EyesApproach, 
            			ConsEyes.ConsentReportName AS EyesConsent, 
            			ConvEyes.ConversionReportName As EyesConversion,
    			AprRes.AppropriateReportName AS ResearchAppropriate, 
            			ApaRes.ApproachReportName AS ResearchApproach, 
            			ConsRes.ConsentReportName AS ResearchConsent, 
            			ConvRes.ConversionReportName As ResearchConversion

				--	ReferralID, 
		            		--	Call.CallID, 
        	    			--	CallNumber,
				--	ReferralDonorRecNumber, 
				--            Person.PersonFirst, 
				--            Person.PersonLast, 
				--            '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS CallerPhone,
				--            ReferralCallerExtension,
				--             ReferralDonorAge, 
				--             ReferralDonorAgeUnit, 
				--             ReferralDonorGender, 
				--             ReferralDonorWeight, 
				--             ReferralDonorOnVentilator, 
				--             CONVERT(char(8), ReferralDonorAdmitDate, 1) AS AdmitDate, 
				--             ReferralDonorAdmitTime, 
				--             CONVERT(char(8), ReferralDonorDeathDate, 1) AS DeathDate, 
				--             ReferralDonorDeathTime, 
				--             ReferralNotesCase, 
				--             RaceName, 
				--             CauseOfDeathName,
				--    	    ReferralGeneralConsent, 
				--    	    ReferralApproachTime, 
				--	    ReferralConsentTime 

		FROM     Call 
		JOIN        Referral ON Referral.CallID = Call.CallID 
		JOIN        ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
		JOIN        StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
		JOIN        Person ON Person.PersonID = StatEmployee.PersonID 
		JOIN        Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		JOIN        SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		JOIN        Person C    ON Referral.ReferralCallerPersonID = C.PersonID
		JOIN        PersonType  ON C.PersonTypeID = PersonType.PersonTypeID
		JOIN        WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
		LEFT JOIN   SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID
		LEFT JOIN   SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID
		--JOIN        PHONE ON   Referral.ReferralCallerPhoneID = Phone.PhoneID
		--LEFT JOIN   CauseOfDeath ON Referral.ReferralDonorCauseOfDeathID = CauseOfDeath.CauseOfDeathID
		--LEFT JOIN   Race ON Referral.ReferralDonorRaceID = Race.RaceID 
		LEFT JOIN   Appropriate AprOrg ON Referral.ReferralOrganAppropriateID = AprOrg.AppropriateID
		LEFT JOIN   Approach ApaOrg  ON Referral.ReferralOrganApproachID = ApaOrg.ApproachID
		LEFT JOIN   Consent ConsOrg ON Referral.ReferralOrganConsentID = ConsOrg.ConsentID
		LEFT JOIN   Conversion ConvOrg ON Referral.ReferralOrganConversionID = ConvOrg.ConversionID

		LEFT JOIN   Appropriate AprBone ON Referral.ReferralBoneAppropriateID = AprBone.AppropriateID
		LEFT JOIN   Approach ApaBone ON Referral.ReferralBoneApproachID = ApaBone.ApproachID 
		LEFT JOIN   Consent ConsBone ON Referral.ReferralBoneConsentID = ConsBone.ConsentID
		LEFT JOIN   Conversion ConvBone ON Referral.ReferralBoneConversionID = ConvBone.ConversionID   
	
		LEFT JOIN   Appropriate AprTis ON Referral.ReferralTissueAppropriateID = AprTis.AppropriateID 
		LEFT JOIN   Approach ApaTis ON Referral.ReferralTissueApproachID = ApaTis.ApproachID 
		LEFT JOIN   Consent ConsTis ON Referral.ReferralTissueConsentID = ConsTis.ConsentID 
		LEFT JOIN   Conversion ConvTis ON Referral.ReferralTissueConversionID = ConvTis.ConversionID   

		LEFT JOIN  Appropriate AprSkin ON Referral.ReferralSkinAppropriateID = AprSkin.AppropriateID
		LEFT JOIN  Approach ApaSkin ON Referral.ReferralSkinApproachID = ApaSkin.ApproachID 
		LEFT JOIN  Consent ConsSkin ON Referral.ReferralSkinConsentID = ConsSkin.ConsentID 
		LEFT JOIN  Conversion ConvSkin ON Referral.ReferralSkinConversionID = ConvSkin.ConversionID 
	
		LEFT JOIN  Appropriate AprValve ON  Referral.ReferralValvesAppropriateID = AprValve.AppropriateID 
		LEFT JOIN  Approach ApaValve ON  Referral.ReferralValvesApproachID = ApaValve.ApproachID 
		LEFT JOIN  Consent ConsValve ON  Referral.ReferralValvesConsentID = ConsValve.ConsentID
		LEFT JOIN  Conversion ConvValve ON Referral.ReferralValvesConversionID = ConvValve.ConversionID
       
		LEFT JOIN Appropriate AprEyes ON Referral.ReferralEyesTransAppropriateID =  AprEyes.AppropriateID
		LEFT JOIN Approach ApaEyes ON Referral.ReferralEyesTransApproachID =  ApaEyes.ApproachID
		LEFT JOIN Consent ConsEyes ON Referral.ReferralEyesTransConsentID  = ConsEyes.ConsentID
		LEFT JOIN Conversion ConvEyes ON Referral.ReferralEyesTransConversionID  = ConvEyes.ConversionID

		LEFT JOIN Appropriate AprRes ON Referral.ReferralEyesRschAppropriateID = AprRes.AppropriateID 
		LEFT JOIN Approach ApaRes ON Referral.ReferralEyesRschApproachID  =  ApaRes.ApproachID
		LEFT JOIN Consent ConsRes  ON Referral.ReferralEyesRschConsentID  = ConsRes.ConsentID 
		LEFT JOIN Conversion ConvRes ON Referral.ReferralEyesRschConversionID  = ConvRes.ConversionID

		WHERE	DATEADD(hour, @TZD, CallDateTime) 
				BETWEEN @vStartDate 
				AND	@VEndDate
		AND 		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 		Referral.ReferralTypeID	
				BETWEEN @vReferralTypeID 
				AND (CASE WHEN @vReferralTypeID = 0 
						THEN   4 
					       WHEN @vReferralTypeID > 0 
						THEN  @vReferralTypeID
					END) 
	END
	
	IF @vOrgID > 0 AND @vReportGroupID > 0
	BEGIN
		Insert #Temp_Condensed
		(	
	    	CallDateTime, 
            		Organization.OrganizationName,
		CallerFirst, 
            		CallerLast, 
            		ReferralDonorLastName, 
           		ReferralDonorFirstName, 
            		SubLocationName,
            		SubLocationLevelName,
            		ReferralDonorGender, 
    		Age, 
            		Call.SourceCodeID, 
            		SourceCode.SourceCodeName, 
            		Referral.ReferralTypeID, 
            		ReferralTypeName, 
            		OrganAppropriate, 
            		OrganApproach, 
            		OrganConsent, 
            		OrganConversion,
    		BoneAppropriate, 
            		BoneApproach, 
            		BoneConsent, 
            		BoneConversion, 
            		TissueAppropriate, 
            		TissueApproach, 
            		TissueConsent, 
            		TissueConversion,
            		SkinAppropriate, 
            		SkinApproach,  
            		SkinConsent,  
            		SkinConversion,
            		ValvesAppropriate, 
            		ValvesApproach, 
            		ValvesConsent, 
            		ValvesConversion,
    		EyesAppropriate, 
            		EyesApproach, 
            		EyesConsent, 
            		EyesConversion,

    		ResearchAppropriate, 
            		ResearchApproach, 
            		ResearchConsent, 
       		ResearchConversion
		)
		
		SELECT 
		DISTINCT    

	    		CallDateTime, 
            			Organization.OrganizationName,
			C.PersonFirst AS CallerFirst, 
            			C.PersonLast AS CallerLast, 
            			ReferralDonorLastName, 
            			ReferralDonorFirstName, 
            			SubLocationName,
            			SubLocationLevelName,
            			ReferralDonorGender, 
    			ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS Age, 
            			Call.SourceCodeID, 
            			SourceCode.SourceCodeName, 
            			Referral.ReferralTypeID, 
            			ReferralTypeName, 
           			AprOrg.AppropriateReportName AS OrganAppropriate, 
            			ApaOrg.ApproachReportName AS OrganApproach, 
            			ConsOrg.ConsentReportName AS OrganConsent, 
            			ConvOrg.ConversionReportName As OrganConversion,

    			AprBone.AppropriateReportName AS BoneAppropriate, 
            			ApaBone.ApproachReportName AS BoneApproach, 
            			ConsBone.ConsentReportName AS BoneConsent, 
            			ConvBone.ConversionReportName As BoneConversion, 

            			AprTis.AppropriateReportName AS TissueAppropriate, 
            			ApaTis.ApproachReportName AS TissueApproach, 
            			ConsTis.ConsentReportName AS TissueConsent, 
            			ConvTis.ConversionReportName As TissueConversion,

            			AprSkin.AppropriateReportName AS SkinAppropriate, 
            			ApaSkin.ApproachReportName AS SkinApproach,  
            			ConsSkin.ConsentReportName AS SkinConsent,  
            			ConvSkin.ConversionReportName As SkinConversion,

            			AprValve.AppropriateReportName AS ValvesAppropriate, 
            			ApaValve.ApproachReportName AS ValvesApproach, 
            			ConsValve.ConsentReportName AS ValvesConsent, 
            			ConvValve.ConversionReportName As ValvesConversion,

    			AprEyes.AppropriateReportName AS EyesAppropriate, 
            			ApaEyes.ApproachReportName AS EyesApproach, 
            			ConsEyes.ConsentReportName AS EyesConsent, 
            			ConvEyes.ConversionReportName As EyesConversion,

    			AprRes.AppropriateReportName AS ResearchAppropriate, 
            			ApaRes.ApproachReportName AS ResearchApproach, 
            			ConsRes.ConsentReportName AS ResearchConsent, 
            			ConvRes.ConversionReportName As ResearchConversion 
				--	ReferralID, 
	            			--	Call.CallID, 
        	    			-- 	CallNumber,
				-- 	ReferralDonorRecNumber, 
				--            Person.PersonFirst, 
				--            Person.PersonLast, 
				--            '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS CallerPhone,
				--            ReferralCallerExtension,
				--             ReferralDonorAge, 
				--             ReferralDonorAgeUnit, 
				--             ReferralDonorGender, 
				--             ReferralDonorWeight, 
				--             ReferralDonorOnVentilator, 
				--             CONVERT(char(8), ReferralDonorAdmitDate, 1) AS AdmitDate, 
				--             ReferralDonorAdmitTime, 
				--             CONVERT(char(8), ReferralDonorDeathDate, 1) AS DeathDate, 
				--             ReferralDonorDeathTime, 
				--             ReferralNotesCase, 
				--             RaceName, 
				--             CauseOfDeathName,
				--    	    ReferralGeneralConsent, 
				--    	    ReferralApproachTime, 
				--	    ReferralConsentTime 

		FROM        	Call 
		JOIN        Referral ON Referral.CallID = Call.CallID 
		JOIN        ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
		JOIN        StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
		JOIN        Person ON Person.PersonID = StatEmployee.PersonID 
		JOIN        Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
		JOIN        SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
		JOIN        Person C    ON Referral.ReferralCallerPersonID = C.PersonID
		JOIN        PersonType  ON C.PersonTypeID = PersonType.PersonTypeID
		JOIN        WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
		LEFT JOIN   SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID
		LEFT JOIN   SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID
		--JOIN        PHONE ON   Referral.ReferralCallerPhoneID = Phone.PhoneID
		--LEFT JOIN   CauseOfDeath ON Referral.ReferralDonorCauseOfDeathID = CauseOfDeath.CauseOfDeathID
		--LEFT JOIN   Race ON Referral.ReferralDonorRaceID = Race.RaceID 

		LEFT JOIN   Appropriate AprOrg ON Referral.ReferralOrganAppropriateID = AprOrg.AppropriateID
		LEFT JOIN   Approach ApaOrg  ON Referral.ReferralOrganApproachID = ApaOrg.ApproachID
		LEFT JOIN   Consent ConsOrg ON Referral.ReferralOrganConsentID = ConsOrg.ConsentID
		LEFT JOIN   Conversion ConvOrg ON Referral.ReferralOrganConversionID = ConvOrg.ConversionID

		LEFT JOIN   Appropriate AprBone ON Referral.ReferralBoneAppropriateID = AprBone.AppropriateID
		LEFT JOIN   Approach ApaBone ON Referral.ReferralBoneApproachID = ApaBone.ApproachID 
		LEFT JOIN   Consent ConsBone ON Referral.ReferralBoneConsentID = ConsBone.ConsentID
		LEFT JOIN   Conversion ConvBone ON Referral.ReferralBoneConversionID = ConvBone.ConversionID   
	
		LEFT JOIN   Appropriate AprTis ON Referral.ReferralTissueAppropriateID = AprTis.AppropriateID 
		LEFT JOIN   Approach ApaTis ON Referral.ReferralTissueApproachID = ApaTis.ApproachID 
		LEFT JOIN   Consent ConsTis ON Referral.ReferralTissueConsentID = ConsTis.ConsentID 
		LEFT JOIN   Conversion ConvTis ON Referral.ReferralTissueConversionID = ConvTis.ConversionID   

		LEFT JOIN  Appropriate AprSkin ON Referral.ReferralSkinAppropriateID = AprSkin.AppropriateID
		LEFT JOIN  Approach ApaSkin ON Referral.ReferralSkinApproachID = ApaSkin.ApproachID 
		LEFT JOIN  Consent ConsSkin ON Referral.ReferralSkinConsentID = ConsSkin.ConsentID 
		LEFT JOIN  Conversion ConvSkin ON Referral.ReferralSkinConversionID = ConvSkin.ConversionID 
	
		LEFT JOIN  Appropriate AprValve ON  Referral.ReferralValvesAppropriateID = AprValve.AppropriateID 
		LEFT JOIN  Approach ApaValve ON  Referral.ReferralValvesApproachID = ApaValve.ApproachID 
		LEFT JOIN  Consent ConsValve ON  Referral.ReferralValvesConsentID = ConsValve.ConsentID
		LEFT JOIN  Conversion ConvValve ON Referral.ReferralValvesConversionID = ConvValve.ConversionID
       
		LEFT JOIN Appropriate AprEyes ON Referral.ReferralEyesTransAppropriateID =  AprEyes.AppropriateID
		LEFT JOIN Approach ApaEyes ON Referral.ReferralEyesTransApproachID =  ApaEyes.ApproachID
		LEFT JOIN Consent ConsEyes ON Referral.ReferralEyesTransConsentID  = ConsEyes.ConsentID
		LEFT JOIN Conversion ConvEyes ON Referral.ReferralEyesTransConversionID  = ConvEyes.ConversionID

		LEFT JOIN Appropriate AprRes ON Referral.ReferralEyesRschAppropriateID = AprRes.AppropriateID 
		LEFT JOIN Approach ApaRes ON Referral.ReferralEyesRschApproachID  =  ApaRes.ApproachID
		LEFT JOIN Consent ConsRes  ON Referral.ReferralEyesRschConsentID  = ConsRes.ConsentID 
		LEFT JOIN Conversion ConvRes ON Referral.ReferralEyesRschConversionID  = ConvRes.ConversionID

		WHERE	DATEADD(hour, @TZD, CallDateTime) 
				BETWEEN @vStartDate 
				AND	@VEndDate
		AND 		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 		Referral.ReferralCallerOrganizationID = @vOrgID		
		AND 		Referral.ReferralTypeID	
				BETWEEN @vReferralTypeID 
				AND (CASE WHEN @vReferralTypeID = 0 
						THEN   4 
					      WHEN @vReferralTypeID > 0 
						THEN  @vReferralTypeID
				        END) 
	END
	


	If @vOrderBy is not null
	BEGIN
		SET @ExecQuery = "SELECT * FROM #Temp_Condensed ORDER BY "  + @vOrderBy
		EXEC(@ExecQuery)
	END
	If @vOrderby is null 
	BEGIN
		SELECT 	*
		 FROM 		#Temp_Condensed 
		ORDER By	ReferralTypeID, 
				OrganizationName, 
				CallDateTime		
	END

	DROP TABLE #Temp_Condensed
		


End




















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

