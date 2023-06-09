SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallCountMessageSummary1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallCountMessageSummary1]
GO


CREATE PROCEDURE sps_CallCountMessageSummary1
	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID	int 	= NULL,
	@vOrgID			int		= NULL,
	@vSourceCodeName 	Varchar(50)= null

AS

	
/******************************************************************************
**		File: 
**		Name: sps_CallCountMessageSummary1
**		Desc: sql for billable account report...the triage part
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth		
**		Date: 03/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT	@vSourceCodeName = SourceCodeName
	FROM	_ReferralProdReport..SourceCode
	WHERE	SourceCodeID = @vSourceCodeID

CREATE TABLE #_Temp_sps_CallCountMessageSummary1
(
	[UnknownOTE] [int]  DEFAULT (0),
	[UnknownTissue] [int]  DEFAULT (0),
	[UnknownTE] [int]  DEFAULT (0),
	[UnknownEye] [int]  DEFAULT (0),
	[UnknownTotalRO] [int]  DEFAULT (0),
	[UnknownAgeRO] [int]  DEFAULT (0),
	[UnknownMedRO] [int]  DEFAULT (0),
	[UnknownOther] [int]  DEFAULT (0),
	[UnknownOtherEye] [int]  DEFAULT (0),
	[UnknownTotals] [int]  DEFAULT (0),	


	[ConsentedOTE] [int]  DEFAULT (0),
	[ConsentedTissue] [int]  DEFAULT (0),
	[ConsentedTE] [int]  DEFAULT (0),
	[ConsentedEye] [int]  DEFAULT (0),
	[ConsentedTotalRO] [int]  DEFAULT (0),
	[ConsentedAgeRO] [int]  DEFAULT (0),
	[ConsentedMedRO] [int]  DEFAULT (0),
	[ConsentedOther] [int]  DEFAULT (0), 
	[ConsentedOtherEye] [int]  DEFAULT (0), 
	[ConsentedTotals] [int]  DEFAULT (0),


	[DeniedOTE] [int]  DEFAULT (0),
	[DeniedTissue] [int]  DEFAULT (0),
	[DeniedTE] [int]  DEFAULT (0),
	[DeniedEye] [int]  DEFAULT (0),
	[DeniedTotalRO] [int]  DEFAULT (0),
	[DeniedAgeRO] [int]  DEFAULT (0),
	[DeniedMedRO] [int]  DEFAULT (0),
	[DeniedOther] [int]  DEFAULT (0),
	[DeniedOtherEye] [int]  DEFAULT (0),
	[DeniedTotals] [int]  DEFAULT (0),



	[NotApprchOTE] [int]  DEFAULT (0),
	[NotApprchTissue] [int]  DEFAULT (0),
	[NotApprchTE] [int]  DEFAULT (0),
	[NotApprchEye] [int]  DEFAULT (0),
	[NotApprchTotalRO] [int]  DEFAULT (0),
	[NotApprchAgeRO] [int]  DEFAULT (0),
	[NotApprchMedRO] [int]  DEFAULT (0),
	[NotApprchOther] [int]  DEFAULT (0),
	[NotApprchOtherEye] [int]  DEFAULT (0),
	[NotApprchTotals] [int]  DEFAULT (0),

	[TotalOTE] [int]  DEFAULT (0),
	[TotalTissue] [int]  DEFAULT (0),
	[TotalTE] [int]  DEFAULT (0),
	[TotalEYE] [int]  DEFAULT (0),
	[TotalRO] [int]  DEFAULT (0),
	[TotalAgeRO] [int]  DEFAULT (0),
	[TotalMedRO] [int]  DEFAULT (0),	
	[TotalOther] [int]  DEFAULT (0),	
	[TotalOtherEye] [int]  DEFAULT (0),	
	[TotalReferrals] [int]  DEFAULT (0),

	[TotOTE] [int] DEFAULT (0),
	[TotTissue] [int] DEFAULT (0),
	[TotTE] [int] DEFAULT (0),
	[TotEye] [int] DEFAULT (0),
	[TotAgeRO] [int] DEFAULT (0),
	[TotMedRO] [int] DEFAULT (0),
	[TotOther] [int] DEFAULT (0),
	[TotOtherEye] [int] DEFAULT (0),
	[TotRO] [int] DEFAULT (0),
	[SourceName] varchar(20),
	
	[TotalMessages] [int]  DEFAULT (0),
	[TotalImports] [int]  DEFAULT (0),
	[TotalImportsMessages] [int]  DEFAULT (0)
) 

CREATE TABLE #_TEMP_MessagesAndImports
(
	[TotalMessages] [int]  DEFAULT (0),
	[TotalImports] [int]  DEFAULT (0),
	[TotalImportsMessages] [int]  DEFAULT (0),
	[SourceName] varchar(20)
)
--IF isnull(@vSourceCodeName,'') = ''
--Begin
    	INSERT #_Temp_sps_CallCountMessageSummary1
	(
	UnknownOTE   ,
	UnknownTissue   ,
	UnknownTE   ,
	UnknownEye   ,
	UnknownTotalRO   ,
	UnknownAgeRO   ,
	UnknownMedRO   ,
	UnknownOther   ,
	UnknownOtherEye   ,
	UnknownTotals   ,	
	

	ConsentedOTE   ,
	ConsentedTissue   ,
	ConsentedTE   ,
	ConsentedEye   ,
	ConsentedTotalRO   ,
	ConsentedAgeRO   ,
	ConsentedMedRO   ,
	ConsentedOther   , 
	ConsentedOtherEye   , 
	ConsentedTotals   ,
	

	DeniedOTE   ,
	DeniedTissue   ,
	DeniedTE   ,
	DeniedEye   ,
	DeniedTotalRO   ,
	DeniedAgeRO   ,
	DeniedMedRO   ,
	DeniedOther   ,
	DeniedOtherEye   ,
	DeniedTotals   ,
	

	NotApprchOTE   ,
	NotApprchTissue   ,
	NotApprchTE   ,
	NotApprchEye   ,
	NotApprchTotalRO   ,
	NotApprchAgeRO   ,
	NotApprchMedRO   ,
	NotApprchOther   ,
	NotApprchOtherEye   ,
	NotApprchTotals   ,
	
	TotalReferrals ,

	TotOTE,
	TotTissue,
	TotTE,
	TotEye,
	TotAgeRO,
	TotMedRO,
	TotOther,
	TotOtherEye,
	TotRO,
	SourceName

	   
	)

    	SELECT 		
			ISNULL(SUM(UnknownOTE), 0) AS 'Unknown OTE', 
			ISNULL(SUM(UnknownTissue), 0) AS 'Unknown Tissue', 
			ISNULL(SUM(UnknownTE), 0) AS 'Unknown T/E', 
			ISNULL(SUM(UnknownEye), 0) AS 'Unknown Eye', 

			ISNULL(SUM(UnknownAgeRO + UnknownMedRO), 0) AS 'Unknown Total RO', 
			ISNULL(SUM(UnknownAgeRO), 0) AS 'Unknown Age RO', 
			ISNULL(SUM(UnknownMedRO), 0) AS 'Unknown Med RO', 
			ISNULL(SUM(UnknownOther), 0) AS 'Unknown Other', 
			ISNULL(SUM(UnknownOtherEye), 0) AS 'Unknown Other Eye', 

			ISNULL(SUM(UnknownOTE +  UnknownTE +  UnknownEye +  UnknownAgeRO +  UnknownMedRO ), 0) AS 'Unknown Totals', 
			ISNULL(SUM(ConsentedOTE), 0) AS 'Consented OTE', 
			ISNULL(SUM(ConsentedTissue), 0) AS 'Consented Tissue', 
			ISNULL(SUM(ConsentedTE), 0) AS 'Consented T/E', 
			ISNULL(SUM(ConsentedEye), 0) AS 'Consented Eye', 
			ISNULL(SUM(ConsentedAgeRO + ConsentedMedRO), 0) AS 'Consented Total RO', 
			ISNULL(SUM(ConsentedAgeRO), 0) AS 'Consented Age RO', 
			ISNULL(SUM(ConsentedMedRO), 0) AS 'Consented Med RO', 
			ISNULL(SUM(ConsentedOther), 0) AS 'Consented Other', 
			ISNULL(SUM(ConsentedOtherEye), 0) AS 'Consented Other Eye', 

			ISNULL(SUM(ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO ), 0) AS 'Consented Totals', 
			ISNULL(SUM(DeniedOTE), 0) AS 'Denied OTE', 
			ISNULL(SUM(DeniedTissue), 0) AS 'Denied Tissue', 
			ISNULL(SUM(DeniedTE), 0) AS 'Denied T/E', 
			ISNULL(SUM(DeniedEye), 0) AS 'Denied Eye', 
			ISNULL(SUM(DeniedAgeRO + DeniedMedRO), 0) AS 'Denied Total RO', 
			ISNULL(SUM(DeniedAgeRO), 0) AS 'Denied Age RO', 
			ISNULL(SUM(DeniedMedRO), 0) AS 'Denied Med RO', 
			ISNULL(SUM(DeniedOther), 0) AS 'Denied Other', 
			ISNULL(SUM(DeniedOtherEye), 0) AS 'Denied Other Eye', 

			ISNULL(SUM(DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO ), 0) AS 'Denied Totals', 
			ISNULL(SUM(NotApprchOTE), 0) AS 'Not Approached OTE', 
			ISNULL(SUM(NotApprchTissue), 0) AS 'Not Approached Tissue', 
			ISNULL(SUM(NotApprchTE), 0) AS 'Not Approached T/E', 
			ISNULL(SUM(NotApprchEye), 0) AS 'Not Approached Eye', 
			ISNULL(SUM(NotApprchAgeRO + NotApprchMedRO), 0) AS 'Not Approached Total RO', 
			ISNULL(SUM(NotApprchAgeRO), 0) AS 'Not Approached Age RO', 
			ISNULL(SUM(NotApprchMedRO), 0) AS 'Not Approached Med RO', 
			ISNULL(SUM(NotApprchOther), 0) AS 'Not Approached Other', 
			ISNULL(SUM(NotApprchOtherEye), 0) AS 'Not Approached Other Eye', 

			ISNULL(SUM(NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ), 0) AS 'Not Approached Totals', 
			
			ISNULL(SUM(TotOTE +
			TotTissue +
			TotTE +
			TotEye +
			TotAgeRO +
			TotMedRO +
			TotOther +
			TotOtherEye ), 0)       AS 'Total Referrals Totals',
	--new total fields here jth 1/08
			ISNULL(sum(TotOTE), 0) as 'Tot OTE',
			ISNULL(sum(TotTissue), 0) as 'Tot Tissue',
			ISNULL(sum(TotTE), 0) as 'Tot TE',
			ISNULL(sum(TotEye), 0) as 'Tot Eye',
			ISNULL(sum(TotAgeRO), 0) as 'Tot Age RO',
			ISNULL(sum(TotMedRO), 0) as 'Tot Med RO',
			ISNULL(sum(TotOther), 0) as 'Tot Other',
			ISNULL(sum(TotOtherEye), 0) as 'Tot Other Eye',
			ISNULL(sum(TotRO), 0) as 'Tot RO',
			ISNULL(sc.SourceCodeName, '')

    FROM 		Referral_CallCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = Referral_CallCountSummary.SourceCodeID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
   	AND		_ReferralProdReport.dbo.Organization.OrganizationID = isnull(@vOrgID,_ReferralProdReport.dbo.Organization.OrganizationID)	
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/' + CAST(Referral_CallCountSummary.DayID AS varchar(2)) + '/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/' + CAST(Referral_CallCountSummary.DayID AS varchar(2)) + '/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_CallCountSummary.SourceCodeID IN (SELECT DISTINCT * 
	   		FROM _ReferralProdReport.dbo.fn_SourceCodeList(@vReportGroupID, @vSourceCodeName))
	GROUP BY 
		sc.SourceCodeName
--- Insert into message temp table

	--INSERT	       #_TEMP_MessagesAndImports
	INSERT #_Temp_sps_CallCountMessageSummary1 ( TotalMessages, TotalImports, TotalImportsMessages, SourceName)
	SELECT	        
			ISNULL(SUM(TotalMessages), 0) AS 'TotalMessages',
			ISNULL(SUM(TotalImports), 0) AS 'TotalImports',
			ISNULL(SUM(TotalMessages + TotalImports), 0) AS 'MessagesAndImports' ,
			ISNULL(sc.SourceCodeName, '')
			
    	FROM 		Referral_MessageCountSummary
	JOIN		_ReferralProdReport.dbo.WebReportGroup ON _ReferralProdReport.dbo.WebReportGroup.OrgHierarchyParentID = Referral_MessageCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = Referral_MessageCountSummary.SourceCodeID
	
   	WHERE 	_ReferralProdReport.dbo.WebReportGroup.WebReportGroupID = @vReportGroupID
   	/*
	AND		Referral_MessageCountSummary.SourceCodeID IN 
				(SELECT DISTINCT * 
	   			FROM _ReferralProdReport.dbo.fn_SourceCodeList(@vReportGroupID, @vSourceCodeName))
	*/
	AND		sc.SourceCodeName = ISNULL(@vSourceCodeName, sc.SourceCodeName)
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/' + CAST(Referral_MessageCountSummary.DayID AS varchar(2)) + '/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/' + CAST(Referral_MessageCountSummary.DayID AS varchar(2)) + '/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	GROUP BY 
		sc.SourceCodeName


IF EXISTS (SELECT * FROM #_Temp_sps_CallCountMessageSummary1)
BEGIN
SELECT 
			SUM(ISNULL(UnknownOTE, 0)) AS 'Unknown OTE', 
			SUM(ISNULL(UnknownTissue, 0)) AS 'Unknown Tissue', 
			SUM(ISNULL(UnknownTE, 0)) AS 'Unknown T/E', 
			SUM(ISNULL(UnknownEye, 0)) AS 'Unknown Eye', 
			SUM(ISNULL(UnknownTotalRO, 0)) AS'Unknown Total RO', 
			SUM(ISNULL(UnknownAgeRO, 0)) AS 'Unknown Age RO', 
			SUM(ISNULL(UnknownMedRO, 0)) AS 'Unknown Med RO', 
			SUM(ISNULL(UnknownOther, 0)) AS 'Unknown Other', 
			SUM(ISNULL(UnknownOtherEye, 0)) AS 'Unknown Other/Eye', 
			SUM(ISNULL(UnknownTotals, 0)) AS 'Unknown Totals', 
			SUM(ISNULL(ConsentedOTE, 0)) AS 'Consented OTE', 
			SUM(ISNULL(ConsentedTissue, 0)) AS 'Consented Tissue', 
			SUM(ISNULL(ConsentedTE, 0)) AS 'Consented T/E', 
			SUM(ISNULL(ConsentedEye, 0)) AS 'Consented Eye', 
			SUM(ISNULL(ConsentedTotalRO, 0)) AS 'Consented Total RO', 
			SUM(ISNULL(ConsentedAgeRO, 0)) AS 'Consented Age RO', 
			SUM(ISNULL(ConsentedMedRO, 0)) AS 'Consented Med RO', 
			SUM(ISNULL(ConsentedOther, 0)) AS 'Consented Other', 
			SUM(ISNULL(ConsentedOtherEye, 0)) AS 'Consented Other/Eye', 
			SUM(ISNULL(ConsentedTotals, 0)) AS 'Consented Totals', 
			SUM(ISNULL(DeniedOTE, 0)) AS 'Denied OTE', 
			SUM(ISNULL(DeniedTissue, 0)) AS 'Denied Tissue', 
			SUM(ISNULL(DeniedTE, 0)) AS 'Denied T/E', 
			SUM(ISNULL(DeniedEye, 0)) AS 'Denied Eye', 
			SUM(ISNULL(DeniedTotalRO, 0)) AS 'Denied Total RO', 
			SUM(ISNULL(DeniedAgeRO, 0)) AS 'Denied Age RO', 
			SUM(ISNULL(DeniedMedRO, 0)) AS 'Denied Med RO', 
			SUM(ISNULL(DeniedOther, 0)) AS 'Denied Other', 
			SUM(ISNULL(DeniedOtherEye, 0)) AS 'Denied Other/Eye',
			SUM(ISNULL(DeniedTotals, 0)) AS 'Denied Totals', 
			SUM(ISNULL(NotApprchOTE, 0)) AS 'Not Approached OTE', 
			SUM(ISNULL(NotApprchTissue, 0)) AS 'Not Approached Tissue', 
			SUM(ISNULL(NotApprchTE, 0)) AS 'Not Approached T/E', 
			SUM(ISNULL(NotApprchEye, 0)) AS 'Not Approached Eye', 
			SUM(ISNULL(NotApprchTotalRO, 0)) AS 'Not Approached Total RO', 
			SUM(ISNULL(NotApprchAgeRO, 0)) AS 'Not Approached Age RO', 
			SUM(ISNULL(NotApprchMedRO, 0)) AS 'Not Approached Med RO', 
			SUM(ISNULL(NotApprchOther, 0)) AS 'Not Approached Other', 
			SUM(ISNULL(NotApprchOtherEye, 0)) AS 'Not Approached Other/Eye', 
			SUM(ISNULL(NotApprchTotals, 0)) AS 'Not Approached Totals', 
			SUM(ISNULL(TotOTE, 0)) AS 'Total Referrals OTE',
			SUM(ISNULL(TotTissue, 0)) as 'Total Referrals Tissue',
			SUM(ISNULL(TotTE, 0)) as 'Total Referrals T/E',			
			SUM(ISNULL(TotEye, 0)) as 'Total Referrals Eye',
			SUM(ISNULL(TotRO, 0)) as 'Total Referrals Total RO',
			SUM(ISNULL(TotAgeRO, 0)) as 'Total Referrals Age RO',
			SUM(ISNULL(TotMedRO, 0)) as 'Total Referrals Med RO',
			SUM(ISNULL(TotOther, 0)) as 'Total Referrals Other',
			SUM(ISNULL(TotOtherEye, 0)) as 'Total Other/Eye',
			SUM(ISNULL(TotalReferrals, 0)) AS 'Total Referrals Totals', 

			SUM(ISNULL(CC.TotalMessages,0)) AS 'Messages',
			SUM(ISNULL(CC.TotalImports,0)) AS	'Imports',
			SUM(ISNULL(CC.TotalImportsMessages,0)) AS 'Messages and Imports',		
			CC.SourceName	

	FROM #_Temp_sps_CallCountMessageSummary1 CC
	GROUP BY CC.SourceName
END
ELSE 
BEGIN
SELECT 
			0 AS 'Unknown OTE', 
			0 AS 'Unknown Tissue', 
			0 AS 'Unknown T/E', 
			0 AS 'Unknown Eye', 
			0 AS'Unknown Total RO', 
			0 AS 'Unknown Age RO', 
			0 AS 'Unknown Med RO', 
			0 AS 'Unknown Other', 
			0 AS 'Unknown Other/Eye', 
			0 AS 'Unknown Totals', 
			0 AS 'Consented OTE', 
			0 AS 'Consented Tissue', 
			0 AS 'Consented T/E', 
			0 AS 'Consented Eye', 
			0 AS 'Consented Total RO', 
			0 AS 'Consented Age RO', 
			0 AS 'Consented Med RO', 
			0 AS 'Consented Other', 
			0 AS 'Consented Other/Eye', 
			0 AS 'Consented Totals', 
			0 AS 'Denied OTE', 
			0 AS 'Denied Tissue', 
			0 AS 'Denied T/E', 
			0 AS 'Denied Eye', 
			0 AS 'Denied Total RO', 
			0 AS 'Denied Age RO', 
			0 AS 'Denied Med RO', 
			0 AS 'Denied Other', 
			0 AS 'Denied Other/Eye',
			0 AS 'Denied Totals', 
			0 AS 'Not Approached OTE', 
			0 AS 'Not Approached Tissue', 
			0 AS 'Not Approached T/E', 
			0 AS 'Not Approached Eye', 
			0 AS 'Not Approached Total RO', 
			0 AS 'Not Approached Age RO', 
			0 AS 'Not Approached Med RO', 
			0 AS 'Not Approached Other', 
			0 AS 'Not Approached Other/Eye', 
			0 AS 'Not Approached Totals', 
			0 AS 'Total Referrals OTE',
			0 as 'Total Referrals Tissue',
			0 as 'Total Referrals T/E',			
			0 as 'Total Referrals Eye',
			0 as 'Total Referrals Total RO',
			0 as 'Total Referrals Age RO',
			0 as 'Total Referrals Med RO',
			0 as 'Total Referrals Other',
			0 as 'Total Other/Eye',
			0 AS 'Total Referrals Totals', 

			0 AS 'Messages',
			0 AS	'Imports',
			0 AS 'Messages and Imports',		
			''	
END
DROP TABLE #_Temp_sps_CallCountMessageSummary1
DROP TABLE #_TEMP_MessagesAndImports


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--exec sps_CallCountMessageSummary1 246,'01/01/2007','01/31/2007',0,'test'