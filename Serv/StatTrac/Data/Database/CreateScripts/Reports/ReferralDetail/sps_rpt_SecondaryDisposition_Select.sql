if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SecondaryDisposition_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition_Select'
		DROP  Procedure  sps_rpt_SecondaryDisposition_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition_Select'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_SecondaryDisposition_Select
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_SecondaryDisposition_Select.sql
**		Name: sps_rpt_SecondaryDisposition_Select
**		Desc: This stored procedure returns a list of (secondary) dispositions for
**			  given CallID and is an option for display in ReferralDetail
**
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID
**
**		Auth: christopher carroll  
**		Date: 06/13/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      6/20/2007		ccarroll				Initial release
**		05/07/2008		ccarroll				Added Triage Appropriate values Per StatTrac view
**		05/08/2008		ccarroll				Added Sub_Precedence for displaying Case Order sequence
**		10/02/2008		ccarroll				Created select sproc for Archive for and Production db
**      10/07/2009      jth                     comment out join to #sps_SecondaryDispositionTriageDisposition
**		09/30/2010		jegerberich				Added ProcessorPrecedence for default sorting  VS 7966, HS 25522
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
		RecoveryName		varchar(50) Null,
		ProcessorPrecedence	Int	Null
	)

-- sp_helptext sps_SecondaryDispositionTriageDisposition 

--IF EXISTS(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME LIKE '%#sps_SecondaryDispositionTriageDisposition%')
--BEGIN
	--DROP TABLE #sps_SecondaryDispositionTriageDisposition
--END

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
EXEC sps_SecondaryDispositionTriageDisposition @CALLID


INSERT @SecondaryDispositionTable
	SELECT 
		DynamicDonorCategory.DynamicDonorCategoryID AS 'CategoryID',
		DynamicDonorCategory.DynamicDonorCategoryName AS 'Category',
		SubType.SubTypeName AS 'Sub_Category',
		CriteriaSubType.SubCriteriaPrecedence AS 'Sub_Precedence',
		Organization.OrganizationName AS 'Processor',
		FSAppropriate.FSAppropriateName AS 'Appropriate',
		FSApproach.FSApproachReportName AS 'Approach',
		FSConsent.FSConsentReportName AS 'Consent',
		FSConversion.FSConversionReportName AS 'Recovery',
		SubCriteria.ProcessorPrecedence AS 'ProcessorPrecedence'
	FROM SecondaryDisposition
	LEFT JOIN SubCriteria ON SubCriteria.SubCriteriaID = SecondaryDisposition.SubCriteriaID
	LEFT JOIN Criteria ON Criteria.CriteriaID = SubCriteria.CriteriaID
	LEFT JOIN Organization ON Organization.OrganizationID = SubCriteria.ProcessorID
	LEFT JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	LEFT JOIN SubType ON SubType.SubTypeID = SubCriteria.SubTypeID 
    LEFT JOIN CriteriaSubType ON CriteriaSubType.CriteriaID = SubCriteria.CriteriaID and SubCriteria.SubTypeID = CriteriaSubType.SubTypeID
	LEFT JOIN FSAppropriate ON FSAppropriate.FSAppropriateID = SecondaryDisposition.SecondaryDispositionAppropriate
	LEFT JOIN FSApproach ON FSApproach.FSApproachID = SecondaryDisposition.SecondaryDispositionApproach
	LEFT JOIN FSConsent ON FSConsent.FSConsentID = SecondaryDisposition.SecondaryDispositionConsent
	LEFT JOIN FSConversion ON FSConversion.FSConversionID = SecondaryDisposition.SecondaryDispositionConversion
	WHERE SecondaryDisposition.CallID = @CallID
	


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
	sp.ConversionName	AS 'RecoveryName',
	NULL AS 'ProcessorPrecedence'
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
	RecoveryName,
	ProcessorPrecedence
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
	RecoveryName,
	ProcessorPrecedence

ORDER BY CategoryID, Sub_Precedence, ProcessorPrecedence

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
