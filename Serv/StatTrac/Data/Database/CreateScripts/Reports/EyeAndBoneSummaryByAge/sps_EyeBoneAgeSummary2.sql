SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_EyeBoneAgeSummary2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_EyeBoneAgeSummary2]
End
go



CREATE  PROCEDURE sps_EyeBoneAgeSummary2
	@StartDateTime	SMALLDATETIME = NULL,
	@EndDateTime	SMALLDATETIME = NULL,
	@SourceCodeName VARCHAR(10) = NULL
	
AS
/*
	Procedure:	sps_EyeBoneAgeSummary

	Inputs:		@StartDateTime	SMALLDATETIME (optional)
			@EndDateTime	SMALLDATETIME (optional)
			@SourceCodeName VARCHAR(10)   (optional)

	ISE:		christopher carroll
	Date: 		01/09/2007

	Note:		Modified from sps_EyeBoneAgeSummary. 
*/

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


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
		--OrganizationName VARCHAR(80),
		OrganizationTypeName VARCHAR(50),
		CallDateTime SMALLDATETIME,
		SourceCodeName VARCHAR(10),
		AgeRange INT,
		TotalReferrals INT,
		SumTriageRuleouts INT,

		SumAppropriateEyeOnly INT,
		SumApproachEyeOnly INT,
		SumConsentEyeOnly INT,
		SumRecoveryEyeOnly INT,

		SumAppropriateBone INT,
		SumApproachBone INT,
		SumConsentBone INT,
		SumRecoveryBone INT,

		SumAppropriateEyeBoneOnly INT,
		SumApproachEyeBoneOnly INT,
		SumConsentEyeBoneOnly INT,
		SumRecoveryEyeBoneOnly INT


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
			ReferralTypeID = 4
		THEN 1
		ELSE 0
	END
	AS TriageRuleouts,

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
	AS SumRecoveryBone,

	CASE
		WHEN 
			ReferralBoneAppropriateID = 1		-- ccarroll 01/11/2007 Change to look at Bone Eyes Only
		AND	ReferralEyesTransAppropriateID = 1
		THEN 1
		ELSE 0
	END
	AS SumAppropriateEyeBoneOnly,
	CASE
		WHEN
			ReferralBoneAppropriateID = 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralBoneApproachID = 1
		AND	ReferralEyesTransApproachID = 1

		THEN 1
		ELSE 0
	END
	AS SumApproachEyeBoneOnly,
	CASE
		WHEN 
			ReferralBoneAppropriateID = 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralBoneConsentID = 1
		AND	ReferralEyesTransConsentID = 1
		THEN 1
		ELSE 0
	END
	AS SumConsentEyeBoneOnly,
	CASE
		WHEN 
			ReferralBoneAppropriateID = 1
		AND	ReferralEyesTransAppropriateID = 1		 
		AND	ReferralBoneConversionID = 1
		AND	ReferralEyesTransConversionID = 1
		THEN 1
		ELSE 0
	END
	AS SumRecoveryEyeBoneOnly

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
	sc.SourceCodeName = ISNULL(@SourceCodeName,sc.SourceCodeName)
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
	SUM(SumTriageRuleouts) AS SumTriageRuleouts,
	SUM(SumAppropriateEyeOnly) AS SumAppropriateEyeOnly ,
	SUM(SumApproachEyeOnly) AS SumApproachEyeOnly,
	SUM(SumConsentEyeOnly) AS SumConsentEyeOnly,
	SUM(SumRecoveryEyeOnly) AS SumRecoveryEyeOnly,
	SUM(SumAppropriateBone) AS SumAppropriateBone,
	SUM(SumApproachBone) AS SumApproachBone,
	SUM(SumConsentBone) AS SumConsentBone,
	SUM(SumRecoveryBone) AS SumRecoveryBone, 
	SUM(SumAppropriateEyeBoneOnly) AS SumAppropriateEyeBoneOnly ,
	SUM(SumApproachEyeBoneOnly) AS SumApproachEyeBoneOnly,
	SUM(SumConsentEyeBoneOnly) AS SumConsentEyeBoneOnly,
	SUM(SumRecoveryEyeBoneOnly) AS SumRecoveryEyeBoneOnly

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

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_EyeBoneAgeSummary2 create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - sps_EyeBoneAgeSummary2 created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




