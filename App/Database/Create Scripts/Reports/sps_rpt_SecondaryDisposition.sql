IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_SecondaryDisposition]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition';
		DROP PROCEDURE sps_rpt_SecondaryDisposition;
	END
GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_SecondaryDisposition]
(
	@CallID	int	= NULL 
)
AS
/******************************************************************************
**	File: sps_rpt_SecondaryDisposition.sql
**	Name: sps_rpt_SecondaryDisposition
**	Desc: This stored procedure returns a list of (secondary) dispositions for
**			given CallID AND	is an option for display in ReferralDetail
**
**	THIS REPLACES SPS_RPT_SECONDARYDISPOSITION_SELECT BECAUSE IT DIDN'T WORK
**	Return values:
**
**	Called by: ReferralDetail_Secondary.rdl
**
**	Parameters:
**	Input		Output
**	---------	-----------
**	@CallID
**
**	Auth: jth
**	Date: 10/9/2009
**
*******************************************************************************
** Change History
*******************************************************************************
**	Date:		Author:		Description:
**	--------	--------	-------------------------------------------
**
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

DECLARE @SecondaryDispositionTable TABLE
(
	CategoryID		int NULL,
	Category		varchar(150) NULL,
	Sub_Category	varchar(150) NULL,
	Sub_Precedence	int NULL,
	Processor		varchar(150) NULL,
	AppropriateName	varchar(50) NULL,
	ApproachName	varchar(50) NULL,
	ConsentName		varchar(50) NULL,
	RecoveryName	varchar(50) NULL
);
 
CREATE TABLE #sps_SecondaryDispositionTriageDisposition
(
	ReferralID			int,
	CallID				int,
	DonorCategoryID		int,
	DonorCategoryName	varchar(50),
	AppropriateID		int,
	ApproachID			int,
	ConsentID			int,
	ConversionID		int,
	AppropriateName		varchar(50),
	ApproachName		varchar(50),
	ConsentName			varchar(50),
	ConversionName		varchar(50)
);

INSERT #sps_SecondaryDispositionTriageDisposition
EXEC sps_SecondaryDispositionTriageDisposition1 @CallID;

INSERT @SecondaryDispositionTable
SELECT
	OrganSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	OrganSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OrganSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM 
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE 
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OrganSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OrganSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OrganSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria OrganSubCriteria ON Criteria.CriteriaID = OrganSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON OrganSubCriteria.CriteriaID = CallCriteria.OrganCriteriaID
	INNER JOIN SubType OrganSubType ON OrganSubType.SubTypeID = OrganSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = OrganSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY OrganSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	BoneSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	BoneSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = BoneSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = BoneSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = BoneSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = BoneSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria BoneSubCriteria ON Criteria.CriteriaID = BoneSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON BoneSubCriteria.CriteriaID = CallCriteria.BoneCriteriaID
	INNER JOIN SubType BoneSubType ON BoneSubType.SubTypeID = BoneSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = BoneSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY BoneSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	SkinSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	SkinSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = SkinSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = SkinSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = SkinSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = SkinSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria AS SkinSubCriteria ON Criteria.CriteriaID = SkinSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON SkinSubCriteria.CriteriaID = CallCriteria.skinCriteriaID
	INNER JOIN SubType SkinSubType ON SkinSubType.SubTypeID = SkinSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = SkinSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY SkinSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	TissueSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	TissueSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = TissueSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = TissueSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = TissueSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
		LEFT OUTER JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = TissueSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria TissueSubCriteria ON Criteria.CriteriaID = TissueSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON (TissueSubCriteria.CriteriaID = CallCriteria.tissueCriteriaID)
	INNER JOIN SubType TissueSubType ON TissueSubType.SubTypeID = TissueSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = TissueSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY TissueSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	ValvesSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	ValvesSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria  
	INNER JOIN SubCriteria ValvesSubCriteria ON Criteria.CriteriaID = ValvesSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON ValvesSubCriteria.CriteriaID = CallCriteria.valvesCriteriaID
	INNER JOIN SubType ValvesSubType ON ValvesSubType.SubTypeID = ValvesSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = ValvesSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY ValvesSubCriteria.ProcessorPrecedence ASC;
 
INSERT @SecondaryDispositionTable
SELECT
	ValvesSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	ValvesSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT
			FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = ValvesSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria ValvesSubCriteria ON Criteria.CriteriaID = ValvesSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON ValvesSubCriteria.CriteriaID = CallCriteria.valvesCriteriaID
	INNER JOIN SubType ValvesSubType ON ValvesSubType.SubTypeID = ValvesSubCriteria.SubtypeID
	INNER JOIN Organization ON Organization.OrganizationID = ValvesSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY ValvesSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	EyesSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	EyesSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = EyesSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = EyesSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = EyesSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = EyesSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria EyesSubCriteria ON Criteria.CriteriaID = EyesSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria CallCriteria ON EyesSubCriteria.CriteriaID = CallCriteria.eyesCriteriaID
	INNER JOIN SubType EyesSubType ON EyesSubType.SubTypeID = EyesSubCriteria.SubtypeID
	INNER JOIN Organization Organization ON Organization.OrganizationID = EyesSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY EyesSubCriteria.ProcessorPrecedence ASC;
 
INSERT @SecondaryDispositionTable
SELECT
	OtherSubCriteria.DonorCategoryID,
	DynamicDonorCategory.DynamicDonorCategoryName,
	OtherSubType.SubTypeName,
	ProcessorPrecedence,
	Organization.OrganizationName,
	(
		SELECT
			FSAppropriate.FSAppropriateName
		FROM
			SecondaryDisposition
			LEFT JOIN FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OtherSubCriteria.SubCriteriaID
	) AS 'Appropriate',
	(
		SELECT FSApproach.FSApproachName
		FROM
			SecondaryDisposition
			LEFT JOIN FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OtherSubCriteria.SubCriteriaID
	) AS 'Approach',
	(
		SELECT FSConsent.FSConsentName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OtherSubCriteria.SubCriteriaID
	) AS 'Consent',
	(
		SELECT FSConversion.FSConversionName
		FROM
			SecondaryDisposition
			LEFT JOIN FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
		WHERE
			SecondaryDisposition.CallID = @CallID
		AND	SubCriteriaID = OtherSubCriteria.SubCriteriaID
	) AS 'RecoveryName'
FROM
	Criteria
	INNER JOIN SubCriteria OtherSubCriteria ON Criteria.CriteriaID = OtherSubCriteria.CriteriaID
	INNER JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	INNER JOIN CallCriteria ON OtherSubCriteria.CriteriaID = CallCriteria.otherCriteriaID
	INNER JOIN SubType OtherSubType ON OtherSubType.SubTypeID = OtherSubCriteria.SubtypeID
	INNER JOIN Organization Organization ON Organization.OrganizationID = OtherSubCriteria.ProcessorID
WHERE CallCriteria.CallID = @CallID
ORDER BY OtherSubCriteria.ProcessorPrecedence ASC;

INSERT @SecondaryDispositionTable
SELECT
	sp.DonorCategoryID AS 'CategoryID',
	sp.DonorCategoryName AS 'Category',
	'' AS 'Sub_Category',
	-1 AS 'Sub_Precedence',
	'' AS 'Processor',
	sp.AppropriateName AS 'AppropriateName',
	sp.ApproachName AS 'ApproachName',
	sp.ConsentName AS 'ConsentName',
	sp.ConversionName AS 'RecoveryName'
FROM #sps_SecondaryDispositionTriageDisposition sp;

SELECT
	CategoryID,
	Category,
	Sub_Category,
	Processor,
	AppropriateName,
	ApproachName,
	ConsentName,
	RecoveryName,Sub_Precedence
FROM @SecondaryDispositionTable
GROUP BY
	CategoryID,
	Category,
	Sub_Category,
	Sub_Precedence,
	Processor,
	AppropriateName,
	ApproachName,
	ConsentName,
	RecoveryName,Sub_Precedence
ORDER BY
	CategoryID,Sub_Category,
	Sub_Precedence;

DROP TABLE #sps_SecondaryDispositionTriageDisposition;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
