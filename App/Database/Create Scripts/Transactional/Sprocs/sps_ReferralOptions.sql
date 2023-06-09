SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralOptions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralOptions]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralOptions    Script Date: 2/24/99 1:12:46 AM ******/
/****** Object:  Stored Procedure dbo.sps_ReferralOptions    Script Date: 9/11/97 7:20:13 PM ******/
CREATE PROCEDURE sps_ReferralOptions
	@vReferralID	int		= Null,
	@vBrief		smallint 	= Null
AS
	CREATE TABLE #TempOptions
	(
		Appropriate 	VARCHAR(30)	NULL,
		Approach    	VARCHAR(30) 	NULL,
		Consent     	VARCHAR(30) 	NULL,
		Recovery    	VARCHAR(30) 	NULL
	)
    	INSERT INTO #TempOptions (Appropriate, Approach, Consent, Recovery)
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralOrganAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralOrganApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralOrganConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralOrganConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralBoneAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralBoneApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralBoneConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralBoneConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralTissueAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralTissueApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralTissueConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralTissueConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralSkinAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralSkinApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralSkinConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralSkinConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralValvesAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralValvesApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralValvesConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralValvesConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralEyesTransAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralEyesTransApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralEyesTransConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralEyesTransConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    
    	INSERT INTO #TempOptions
    	SELECT 
		CASE WHEN @vBrief = 0 THEN AppropriateName ELSE AppropriateReportName END,
		CASE WHEN @vBrief = 0 THEN ApproachName ELSE ApproachReportName END,
		CASE WHEN @vBrief = 0 THEN ConsentName ELSE ConsentReportName END,
		CASE WHEN @vBrief = 0 THEN ConversionName ELSE ConversionReportName END
    	FROM Referral
    	LEFT JOIN Appropriate ON ReferralEyesRschAppropriateID = AppropriateID
    	LEFT JOIN Approach ON ReferralEyesRschApproachID = ApproachID
    	LEFT JOIN Consent ON ReferralEyesRschConsentID = ConsentID
    	LEFT JOIN Conversion ON ReferralEyesRschConversionID = ConversionID
    	WHERE ReferralID = @vReferralID
    	SELECT * FROM #TempOptions




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

