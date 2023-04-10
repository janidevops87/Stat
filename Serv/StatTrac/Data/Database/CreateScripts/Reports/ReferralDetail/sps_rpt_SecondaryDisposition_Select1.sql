if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SecondaryDisposition_Select1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition_Select1'
		DROP  Procedure  sps_rpt_SecondaryDisposition_Select1
	END

GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition_Select1'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_SecondaryDisposition_Select1
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_SecondaryDisposition_Select1.sql
**		Name: sps_rpt_SecondaryDisposition_Select1
**		Desc: This stored procedure returns a list of (secondary) dispositions for
**			  given CallID and is an option for display in ReferralDetail
**
**      THIS REPLACES SPS_RPT_SECONDARYDISPOSITION_SELECT BECAUSE IT DIDN'T WORK        
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID
**
**		Auth: jth  
**		Date: 10/9/2009
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE @SecondaryDispositionTable TABLE
	(
		CategoryID		Int Null,
		Category		varchar(150) Null,
		Sub_Category		varchar(150) Null,
		Sub_Precedence		Int Null,
		Processor		varchar(150) Null,
		AppropriateName		varchar(50) Null,
		ApproachName		varchar(50) Null,
		ConsentName		varchar(50) Null,
		RecoveryName		varchar(50) Null
	)

-- sp_helptext sps_SecondaryDispositionTriageDisposition 
--
--

CREATE TABLE #sps_SecondaryDispositionTriageDisposition
	(
	ReferralID  INT,
	CallID  INT,      
	DonorCategoryID  INT, 
	DonorCategoryName  VARCHAR(50),                                
	AppropriateID  INT, 
	ApproachID  INT,  
	ConsentID  INT,   
	ConversionID  INT, 
	AppropriateName  VARCHAR(50),                                    
	ApproachName  VARCHAR(50),                                       
	ConsentName  VARCHAR(50),                                        
	ConversionName  VARCHAR(50)
	)

INSERT #sps_SecondaryDispositionTriageDisposition
EXEC sps_SecondaryDispositionTriageDisposition1 @Callid

INSERT @SecondaryDispositionTable
SELECT                organSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      organSubType.SubTypeName,ProcessorPrecedence,--organSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =organSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =organSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =organSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =organSubCriteria.SubCriteriaID))AS 'RecoveryName'
FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS organSubCriteria
                          ON (Criteria.CriteriaID = organSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (organSubCriteria.CriteriaID = CallCriteria.organCriteriaID))
                       INNER JOIN SubType organSubType
                       ON (organSubType.SubTypeID = organSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = organSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY organSubCriteria.ProcessorPrecedence ASC

INSERT @SecondaryDispositionTable
SELECT                BoneSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      BoneSubType.SubTypeName,ProcessorPrecedence,--BoneSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =BoneSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =BoneSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =BoneSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =BoneSubCriteria.SubCriteriaID))AS 'RecoveryName'
FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS BoneSubCriteria
                          ON (Criteria.CriteriaID = BoneSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (BoneSubCriteria.CriteriaID = CallCriteria.BoneCriteriaID))
                       INNER JOIN SubType BoneSubType
                       ON (BoneSubType.SubTypeID = BoneSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = BoneSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY BoneSubCriteria.ProcessorPrecedence ASC

INSERT @SecondaryDispositionTable
SELECT                skinSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      skinSubType.SubTypeName,ProcessorPrecedence,--skinSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =skinSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =skinSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =skinSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =skinSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS skinSubCriteria
                          ON (Criteria.CriteriaID = skinSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (skinSubCriteria.CriteriaID = CallCriteria.skinCriteriaID))
                       INNER JOIN SubType skinSubType
                       ON (skinSubType.SubTypeID = skinSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = skinSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY skinSubCriteria.ProcessorPrecedence ASC

INSERT @SecondaryDispositionTable
SELECT                tissueSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      tissueSubType.SubTypeName,ProcessorPrecedence,--tissueSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =tissueSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =tissueSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =tissueSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =tissueSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS tissueSubCriteria
                          ON (Criteria.CriteriaID = tissueSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (tissueSubCriteria.CriteriaID = CallCriteria.tissueCriteriaID))
                       INNER JOIN SubType tissueSubType
                       ON (tissueSubType.SubTypeID = tissueSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = tissueSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY tissueSubCriteria.ProcessorPrecedence ASC

iNSERT @SecondaryDispositionTable
SELECT                valvesSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      valvesSubType.SubTypeName,ProcessorPrecedence,--valvesSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS valvesSubCriteria
                          ON (Criteria.CriteriaID = valvesSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (valvesSubCriteria.CriteriaID = CallCriteria.valvesCriteriaID))
                       INNER JOIN SubType valvesSubType
                       ON (valvesSubType.SubTypeID = valvesSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = valvesSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY valvesSubCriteria.ProcessorPrecedence ASC
             
             iNSERT @SecondaryDispositionTable
SELECT                valvesSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      valvesSubType.SubTypeName,ProcessorPrecedence,--valvesSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =valvesSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS valvesSubCriteria
                          ON (Criteria.CriteriaID = valvesSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (valvesSubCriteria.CriteriaID = CallCriteria.valvesCriteriaID))
                       INNER JOIN SubType valvesSubType
                       ON (valvesSubType.SubTypeID = valvesSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = valvesSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY valvesSubCriteria.ProcessorPrecedence ASC
 
 iNSERT @SecondaryDispositionTable
SELECT                eyesSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      eyesSubType.SubTypeName,ProcessorPrecedence,--eyesSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =eyesSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =eyesSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =eyesSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =eyesSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS eyesSubCriteria
                          ON (Criteria.CriteriaID = eyesSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (eyesSubCriteria.CriteriaID = CallCriteria.eyesCriteriaID))
                       INNER JOIN SubType eyesSubType
                       ON (eyesSubType.SubTypeID = eyesSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = eyesSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY eyesSubCriteria.ProcessorPrecedence ASC
             
             iNSERT @SecondaryDispositionTable
SELECT                otherSubCriteria.DonorCategoryID,
                      DynamicDonorCategory.DynamicDonorCategoryName,
                      otherSubType.SubTypeName,ProcessorPrecedence,--otherSubCriteria.SubCriteriaID,
                      Organization.OrganizationName,(SELECT      FSAppropriate.FSAppropriateName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSAppropriate ON SecondaryDisposition.SecondaryDispositionAppropriate = FSAppropriate.FSAppropriateID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =otherSubCriteria.SubCriteriaID))AS 'Appropriate',
(SELECT      FSApproach.FSApproachName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSApproach ON SecondaryDisposition.SecondaryDispositionApproach = FSApproach.FSApproachID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =otherSubCriteria.SubCriteriaID))AS 'Approach',
(SELECT      FSConsent.FSConsentName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConsent ON SecondaryDisposition.SecondaryDispositionConsent = FSConsent.FSConsentID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =otherSubCriteria.SubCriteriaID))AS 'Consent',
(SELECT     FSConversion.FSConversionName
FROM         SecondaryDisposition LEFT OUTER JOIN
                      FSConversion ON SecondaryDisposition.SecondaryDispositionConversion = FSConversion.FSConversionID
WHERE     (SecondaryDisposition.CallID = @Callid and subcriteriaid =otherSubCriteria.SubCriteriaID))AS 'RecoveryName'

 
                 FROM ((((Criteria Criteria
                          INNER JOIN SubCriteria AS otherSubCriteria
                          ON (Criteria.CriteriaID = otherSubCriteria.CriteriaID))
                         INNER JOIN DynamicDonorCategory DynamicDonorCategory
                         ON (DynamicDonorCategory.DynamicDonorCategoryID =
                                Criteria.DynamicDonorCategoryID))
                        INNER JOIN CallCriteria CallCriteria
                        ON (otherSubCriteria.CriteriaID = CallCriteria.otherCriteriaID))
                       INNER JOIN SubType otherSubType
                       ON (otherSubType.SubTypeID = otherSubCriteria.SubtypeID))
                      INNER JOIN Organization Organization
                      ON (Organization.OrganizationID = otherSubCriteria.ProcessorID)

                WHERE (CallCriteria.CallID = @Callid)
             ORDER BY otherSubCriteria.ProcessorPrecedence ASC

--INSERT @SecondaryDispositionTable
--	SELECT 
--		DynamicDonorCategory.DynamicDonorCategoryID AS 'CategoryID',
--		DynamicDonorCategory.DynamicDonorCategoryName AS 'Category',
--		SubType.SubTypeName AS 'Sub_Category',
--		CriteriaSubType.SubCriteriaPrecedence AS 'Sub_Precedence',
--		Organization.OrganizationName AS 'Processor',
--		FSAppropriate.FSAppropriateName AS 'Appropriate',
--		FSApproach.FSApproachReportName AS 'Approach',
--		FSConsent.FSConsentReportName AS 'Consent',
--		FSConversion.FSConversionReportName AS 'Recovery'
--	FROM SecondaryDisposition
--	LEFT JOIN SubCriteria ON SubCriteria.SubCriteriaID = SecondaryDisposition.SubCriteriaID
--	LEFT JOIN Criteria ON Criteria.CriteriaID = SubCriteria.CriteriaID
--	LEFT JOIN Organization ON Organization.OrganizationID = SubCriteria.ProcessorID
--	LEFT JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
--	LEFT JOIN SubType ON SubType.SubTypeID = SubCriteria.SubTypeID 
--    LEFT JOIN CriteriaSubType ON CriteriaSubType.CriteriaID = SubCriteria.CriteriaID and SubCriteria.SubTypeID = CriteriaSubType.SubTypeID
--	LEFT JOIN FSAppropriate ON FSAppropriate.FSAppropriateID = SecondaryDisposition.SecondaryDispositionAppropriate
--	LEFT JOIN FSApproach ON FSApproach.FSApproachID = SecondaryDisposition.SecondaryDispositionApproach
--	LEFT JOIN FSConsent ON FSConsent.FSConsentID = SecondaryDisposition.SecondaryDispositionConsent
--	LEFT JOIN FSConversion ON FSConversion.FSConversionID = SecondaryDisposition.SecondaryDispositionConversion
--	WHERE SecondaryDisposition.CallID = @Callid
	


INSERT @SecondaryDispositionTable
SELECT
	sp.DonorCategoryID	AS 'CategoryID',
	sp.DonorCategoryName 	AS 'Category',
	'' 			AS 'Sub_Category',
	-1			AS 'Sub_Precedence',
	''			AS 'Processor',
	sp.AppropriateName 	AS 'AppropriateName',
	sp.ApproachName		AS 'ApproachName',
	sp.ConsentName		AS 'ConsentName',
	sp.ConversionName	AS 'RecoveryName'

FROM #sps_SecondaryDispositionTriageDisposition sp
--JOIN @SecondaryDispositionTable sdt ON sdt.Category = sp.DonorCategoryName

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

ORDER BY CategoryID,Sub_Category, Sub_Precedence

drop table #sps_SecondaryDispositionTriageDisposition


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
 