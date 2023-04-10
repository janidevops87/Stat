if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_EyeBoneAgeSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_EyeBoneAgeSummary]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sps_EyeBoneAgeSummary
	@StartDateTime	SMALLDATETIME = NULL,
	@EndDateTime	SMALLDATETIME = NULL,
	@SourceCodeName VARCHAR(10)
	
AS
SELECT
		@StartDateTime = ISNULL(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)



DECLARE @CountTable TABLE
	(
		---OrganizationName VARCHAR(80),
		OrganizationTypeName VARCHAR(50),
		CallDateTime SMALLDATETIME,
		SourceCodeName VARCHAR(10),
		AgeRange INT,
		TotalReferrals INT,
		SumAppropriateEyeOnly INT,
		SumApproachEyeOnly INT,
		SumConsentEyeOnly INT,
		SumRecoveryEyeOnly INT,
		SumAppropriateBone INT,
		SumApproachBone INT,
		SumConsentBone INT,
		SumRecoveryBone INT
	)

INSERT @CountTable
SELECT 
	--o.OrganizationName, 
	ot.OrganizationTypeName, 
	CallDateTime,
	SourceCodeName,
	dbo.fn_AgeRange(ReferralDonorAge, ReferralDonorAgeUnit) AS AgeRange,
	1 AS TotalReferrals,
	CASE
		WHEN 
			ReferralOrganAppropriateID <> 1  
		AND	ReferralBoneAppropriateID <> 1
		AND	ReferralTissueAppropriateID <> 1
		AND	ReferralSkinAppropriateID <> 1
		AND	ReferralValvesAppropriateID <> 1
		AND	ReferralEyesTransAppropriateID = 1
		THEN 1
		ELSE 0
	END
	AS SumAppropriateEyeOnly,
	CASE
		WHEN
			ReferralOrganAppropriateID <> 1  
		AND	ReferralBoneAppropriateID <> 1
		AND	ReferralTissueAppropriateID <> 1
		AND	ReferralSkinAppropriateID <> 1
		AND	ReferralValvesAppropriateID <> 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralOrganApproachID <> 1  
		AND	ReferralBoneApproachID <> 1
		AND	ReferralTissueApproachID <> 1
		AND	ReferralSkinApproachID <> 1
		AND	ReferralValvesApproachID <> 1
		AND	ReferralEyesTransApproachID = 1

		THEN 1
		ELSE 0
	END
	AS SumApproachEyeOnly,
	CASE
		WHEN 
			ReferralOrganAppropriateID <> 1  
		AND	ReferralBoneAppropriateID <> 1
		AND	ReferralTissueAppropriateID <> 1
		AND	ReferralSkinAppropriateID <> 1
		AND	ReferralValvesAppropriateID <> 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralOrganConsentID <> 1  
		AND	ReferralBoneConsentID <> 1
		AND	ReferralTissueConsentID <> 1
		AND	ReferralSkinConsentID <> 1
		AND	ReferralValvesConsentID <> 1
		AND	ReferralEyesTransConsentID = 1
		THEN 1
		ELSE 0
	END
	AS SumConsentEyeOnly,
	CASE
		WHEN 
			ReferralOrganAppropriateID <> 1  
		AND	ReferralBoneAppropriateID <> 1
		AND	ReferralTissueAppropriateID <> 1
		AND	ReferralSkinAppropriateID <> 1
		AND	ReferralValvesAppropriateID <> 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralOrganConversionID <> 1  
		AND	ReferralBoneConversionID <> 1
		AND	ReferralTissueConversionID <> 1
		AND	ReferralSkinConversionID <> 1
		AND	ReferralValvesConversionID <> 1
		AND	ReferralEyesTransConversionID = 1
		THEN 1
		ELSE 0
	END
	AS SumRecoveryEyeOnly,
	CASE
		WHEN 
			ReferralBoneAppropriateID = 1
		THEN 1
		ELSE 0
	END
	AS SumAppropriateBone,
	CASE
		WHEN 
			ReferralBoneApproachID = 1
		THEN 1
		ELSE 0
	END
	AS SumApproachBone,
	CASE
		WHEN 
			ReferralBoneConsentID = 1
		THEN 1
		ELSE 0
	END
	AS SumConsentBone,
	CASE
		WHEN 
			ReferralBoneConversionID = 1
		THEN 1
		ELSE 0
	END
	AS SumRecoveryBone

FROM	
	Call c
JOIN	
	Referral r ON r.CallID = c.CallID
JOIN	
	Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
LEFT JOIN
	OrganizationType ot ON ot.OrganizationTypeID = o.OrganizationTypeID
JOIN 	
	SourceCode sc ON sc.SourceCodeID = c.SourceCodeID
WHERE
	sc.SourceCodeName = @SourceCodeName
AND 
	CallDateTime BETWEEN @StartDateTime AND	@EndDateTime



SELECT 		
	--OrganizationName,
	OrganizationTypeName ,
	-- CallDateTime ,
	DatePart(mm, CallDateTime ) AS Month,
	DatePart(yyyy, CallDateTime ) AS YEAR,
	CONVERT(VARCHAR(2), DatePart(mm, CallDateTime )) + '\' + CONVERT(VARCHAR(4),DatePart(yyyy, CallDateTime )) AS MonthYear,	
	SourceCodeName,
	AgeRangeName ,
	AgeRange,
	SUM(TotalReferrals) AS TotalReferrals,
	SUM(SumAppropriateEyeOnly) AS SumAppropriateEyeOnly ,
	SUM(SumApproachEyeOnly) AS SumApproachEyeOnly,
	SUM(SumConsentEyeOnly) AS SumConsentEyeOnly,
	SUM(SumRecoveryEyeOnly) AS SumRecoveryEyeOnly,
	SUM(SumAppropriateBone) AS SumAppropriateBone,
	SUM(SumApproachBone) AS SumApproachBone,
	SUM(SumConsentBone) AS SumConsentBone,
	SUM(SumRecoveryBone) AS SumRecoveryBone 

FROM 
	@CountTable ct

LEFT JOIN 
	_ReferralProd_DataWarehouse..AgeRange ar ON ar.AgeRangeID = ct.AgeRange

GROUP BY 
	--OrganizationName,
	OrganizationTypeName ,
	DatePart(mm, CallDateTime ),
	DatePart(yyyy, CallDateTime ),
	CONVERT(VARCHAR(2), DatePart(mm, CallDateTime )) + '\' + CONVERT(VARCHAR(4),DatePart(yyyy, CallDateTime )),
	SourceCodeName,
	AgeRangeName,
	AgeRange

ORDER BY 
	OrganizationTypeName,
	DatePart(mm, CallDateTime ),
	DatePart(yyyy, CallDateTime ),
	--OrganizationName,
	AgeRange	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 