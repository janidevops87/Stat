


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallCountMessageSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallCountMessageSummary]
GO





CREATE PROCEDURE sps_CallCountMessageSummary
	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int 		= 0

AS
/******************************************************************************
**		File: 
**		Name: sps_CallCountMessageSummary
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
**		Dataset of triage billable calls
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: Bret
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      1/2008		jth					added total totals to select from addition to table
*******************************************************************************/
SET NOCOUNT ON
CREATE TABLE #_Temp_sps_CallCountMessageSummary 
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
		
	[TotalMessages] [int]  DEFAULT (0),
	[TotalImports] [int]  DEFAULT (0),
	[TotalImportsMessages] [int]  DEFAULT (0)
) 

CREATE TABLE #_TEMP_MessagesAndImports
(
	[TotalMessages] [int]  DEFAULT (0),
	[TotalImports] [int]  DEFAULT (0),
	[TotalImportsMessages] [int]  DEFAULT (0)

)



    	INSERT #_Temp_sps_CallCountMessageSummary
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
	

	TotalOTE   ,
	TotalTissue   ,
	TotalTE   ,
	TotalEYE   ,
	TotalRO   ,

	TotalAgeRO   ,
	TotalMedRO   ,	
	TotalOther   ,	
	TotalOtherEye   ,	
	TotalReferrals   ,
	
	TotOTE,
	TotTissue,
	TotTE,
	TotEye,
	TotAgeRO,
	TotMedRO,
	TotOther,
	TotOtherEye,
	TotRO
	)

    	SELECT 		--Referral_CallCountSummary.OrganizationID, 
    			--OrganizationName, 
			SUM(UnknownOTE) AS 'Unknown OTE', 
			SUM(UnknownTissue) AS 'Unknown Tissue', 
			SUM(UnknownTE) AS 'Unknown T/E', 
			SUM(UnknownEye) AS 'Unknown Eye', 

			SUM(UnknownAgeRO + UnknownMedRO) AS 'Unknown Total RO', 
			SUM(UnknownAgeRO) AS 'Unknown Age RO', 
			SUM(UnknownMedRO) AS 'Unknown Med RO', 
			SUM(UnknownOther) AS 'Unknown Other', 
			SUM(UnknownOtherEye) AS 'Unknown Other Eye', 

			SUM(UnknownOTE +  UnknownTE +  UnknownEye +  UnknownAgeRO +  UnknownMedRO ) AS 'Unknown Totals', 
			SUM(ConsentedOTE) AS 'Consented OTE', 
			SUM(ConsentedTissue) AS 'Consented Tissue', 
			SUM(ConsentedTE) AS 'Consented T/E', 
			SUM(ConsentedEye) AS 'Consented Eye', 
			SUM(ConsentedAgeRO + ConsentedMedRO) AS 'Consented Total RO', 
			SUM(ConsentedAgeRO) AS 'Consented Age RO', 
			SUM(ConsentedMedRO) AS 'Consented Med RO', 
			SUM(ConsentedOther) AS 'Consented Other', 
			SUM(ConsentedOtherEye) AS 'Consented Other Eye', 

			SUM(ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO ) AS 'Consented Totals', 
			SUM(DeniedOTE) AS 'Denied OTE', 
			SUM(DeniedTissue) AS 'Denied Tissue', 
			SUM(DeniedTE) AS 'Denied T/E', 
			SUM(DeniedEye) AS 'Denied Eye', 
			SUM(DeniedAgeRO + DeniedMedRO) AS 'Denied Total RO', 
			SUM(DeniedAgeRO) AS 'Denied Age RO', 
			SUM(DeniedMedRO) AS 'Denied Med RO', 
			SUM(DeniedOther) AS 'Denied Other', 
			SUM(DeniedOtherEye) AS 'Denied Other Eye', 

			SUM(DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO ) AS 'Denied Totals', 
			SUM(NotApprchOTE) AS 'Not Approached OTE', 
			SUM(NotApprchTissue) AS 'Not Approached Tissue', 
			SUM(NotApprchTE) AS 'Not Approached T/E', 
			SUM(NotApprchEye) AS 'Not Approached Eye', 
			SUM(NotApprchAgeRO + NotApprchMedRO) AS 'Not Approached Total RO', 
			SUM(NotApprchAgeRO) AS 'Not Approached Age RO', 
			SUM(NotApprchMedRO) AS 'Not Approached Med RO', 
			SUM(NotApprchOther) AS 'Not Approached Other', 
			SUM(NotApprchOtherEye) AS 'Not Approached Other Eye', 

			SUM(NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Not Approached Totals', 
			
			SUM(UnknownOTE + ConsentedOTE + DeniedOTE + NotApprchOTE) AS 'Total Referrals OTE', 
			SUM(UnknownTissue + ConsentedTissue + DeniedTissue + NotApprchTissue ) AS 'Total Referrals Tissue', 
			SUM(UnknownTE + ConsentedTE + DeniedTE + NotApprchTE) AS 'Total Referrals T/E',  
			SUM(UnknownEye + ConsentedEye + DeniedEye + NotApprchEye) AS 'Total Referrals Eye',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO + UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Total RO',  
			SUM(UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Age RO',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO) AS 'Total Referrals Med RO', 

			SUM(UnknownOther + ConsentedOther + DeniedOther + NotApprchOther) AS 'Total Referrals Other', 
			SUM(UnknownOtherEye + ConsentedOtherEye + DeniedOtherEye + NotApprchOtherEye) AS 'Total Other Eye' ,				

			SUM(
				UnknownOTE + ConsentedOTE + DeniedOTE + NotApprchOTE +
				UnknownTissue + ConsentedTissue + DeniedTissue + NotApprchTissue +
				UnknownTE + ConsentedTE + DeniedTE + NotApprchTE +
				UnknownEye + ConsentedEye + DeniedEye + NotApprchEye +				
				UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO + 
				UnknownAgeRO + ConsentedAgeRO + DeniedAgeRO + NotApprchAgeRO 
				) AS 'Total Referrals Totals', 
	/*
			SUM(UnknownOTE + UnknownTE + UnknownEye + UnknownAgeRO + UnknownMedRO +  
				ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO  + 
				DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO + 
				NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Total Referrals Totals' 
*/
	--new total fields here jth 1/08
		TotOTE as 'Tot OTE',
		TotTissue as 'Tot Tissue',
		TotTE as 'Tot TE',
		TotEye as 'Tot Eye',
		TotAgeRO as 'Tot Age RO',
		TotMedRO as 'Tot Med RO',
		TotOther as 'Tot Other',
		TotOtherEye as 'Tot Other Eye',
		TotRO as 'Tot RO'

    	FROM 		Referral_CallCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND 		SourceCodeID = @vSourceCodeID

	INSERT	       #_TEMP_MessagesAndImports
	SELECT	        SUM(TotalMessages) AS 'TotalMessages',
			SUM(TotalImports) AS 'TotalImports',
			(SUM(TotalMessages) + SUM(TotalImports)) AS 'MessagesAndImports' 

    	FROM 		Referral_MessageCountSummary
	JOIN		_ReferralProdReport.dbo.WebReportGroup ON _ReferralProdReport.dbo.WebReportGroup.OrgHierarchyParentID = Referral_MessageCountSummary.OrganizationID
 	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = _ReferralProdReport.dbo.WebReportGroup.WebReportGroupID

	
   	WHERE 		_ReferralProdReport.dbo.WebReportGroup.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = @vSourceCodeID
	--AND		SourceCodeID= @vSourceCodeID
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	

	UPDATE		#_Temp_sps_CallCountMessageSummary
	SET		#_Temp_sps_CallCountMessageSummary.TotalMessages = #_TEMP_MessagesAndImports.TotalMessages,
			#_Temp_sps_CallCountMessageSummary.TotalImports = #_TEMP_MessagesAndImports.TotalImports ,
			#_Temp_sps_CallCountMessageSummary.TotalImportsMessages = #_TEMP_MessagesAndImports.TotalImportsMessages 
	FROM		#_TEMP_MessagesAndImports	

SELECT 
			ISNULL(UnknownOTE,0) AS 'Unknown OTE', 
			ISNULL(UnknownTissue,0) AS 'Unknown Tissue', 
			ISNULL(UnknownTE,0) AS 'Unknown T/E', 
			ISNULL(UnknownEye,0) AS 'Unknown Eye', 
			ISNULL(UnknownTotalRO,0) AS'Unknown Total RO', 
			ISNULL(UnknownAgeRO,0) AS 'Unknown Age RO', 
			ISNULL(UnknownMedRO,0) AS 'Unknown Med RO', 
			ISNULL(UnknownOther,0) AS 'Unknown Other', 
			ISNULL(UnknownOtherEye,0) AS 'Unknown Other/Eye', 
			ISNULL(UnknownTotals,0) AS 'Unknown Totals', 
			ISNULL(ConsentedOTE,0) AS 'Consented OTE', 
			ISNULL(ConsentedTissue,0) AS 'Consented Tissue', 
			ISNULL(ConsentedTE,0) AS 'Consented T/E', 
			ISNULL(ConsentedEye,0) AS 'Consented Eye', 
			ISNULL(ConsentedTotalRO,0) AS 'Consented Total RO', 
			ISNULL(ConsentedAgeRO,0) AS 'Consented Age RO', 
			ISNULL(ConsentedMedRO,0) AS 'Consented Med RO', 
			ISNULL(ConsentedOther,0) AS 'Consented Other', 
			ISNULL(ConsentedOtherEye,0) AS 'Consented Other/Eye', 
			ISNULL(ConsentedTotals,0) AS 'Consented Totals', 
			ISNULL(DeniedOTE,0) AS 'Denied OTE', 
			ISNULL(DeniedTissue,0) AS 'Denied Tissue', 
			ISNULL(DeniedTE,0) AS 'Denied T/E', 
			ISNULL(DeniedEye,0) AS 'Denied Eye', 
			ISNULL(DeniedTotalRO,0) AS 'Denied Total RO', 
			ISNULL(DeniedAgeRO,0) AS 'Denied Age RO', 
			ISNULL(DeniedMedRO,0) AS 'Denied Med RO', 
			ISNULL(DeniedOther,0) AS 'Denied Other', 
			ISNULL(DeniedOtherEye,0) AS 'Denied Other/Eye',
			ISNULL(DeniedTotals,0) AS 'Denied Totals', 
			ISNULL(NotApprchOTE,0) AS 'Not Approached OTE', 
			ISNULL(NotApprchTissue,0) AS 'Not Approached Tissue', 
			ISNULL(NotApprchTE,0) AS 'Not Approached T/E', 
			ISNULL(NotApprchEye,0) AS 'Not Approached Eye', 
			ISNULL(NotApprchTotalRO,0) AS 'Not Approached Total RO', 
			ISNULL(NotApprchAgeRO,0) AS 'Not Approached Age RO', 
			ISNULL(NotApprchMedRO,0) AS 'Not Approached Med RO', 
			ISNULL(NotApprchOther,0) AS 'Not Approached Other', 
			ISNULL(NotApprchOtherEye,0) AS 'Not Approached Other/Eye', 
			ISNULL(NotApprchTotals,0) AS 'Not Approached Totals', 
			ISNULL(TotalOTE ,0) AS 'Total Referrals OTE', 
			ISNULL(TotalTissue ,0) AS 'Total Referrals Tissue', 
			ISNULL(TotalTE ,0) AS 'Total Referrals T/E',  
			ISNULL(TotalEye,0) AS 'Total Referrals Eye',  
			ISNULL(TotalRO,0) AS 'Total Referrals Total RO',  
			ISNULL(TotalAgeRO,0) AS 'Total Referrals Age RO',  
			ISNULL(TotalMedRO,0) AS 'Total Referrals Med RO', 
			ISNULL(TotalOther,0) AS 'Total Referrals Other', 
			ISNULL(TotalOtherEye,0) AS 'Total Other/Eye', 
			ISNULL(TotalReferrals,0) AS 'Total Referrals Totals', 
			ISNULL(TotalMessages,0) AS 'Messages',
			ISNULL(TotalImports,0) AS	'Imports',
			ISNULL(TotalImportsMessages,0) AS 'Messages and Imports',
			ISNULL(TotOTE,0) as 'Total OTE',
			ISNULL(TotTissue,0) as 'Total Tissue',
			ISNULL(TotTE,0) as 'Total TE',
			ISNULL(TotEye,0) as 'Total Eye',
			ISNULL(TotAgeRO,0) as 'Total Age RO',
			ISNULL(TotMedRO,0) as 'Total Med RO',
			ISNULL(TotOther,0) as 'Total Other',
			ISNULL(TotOtherEye,0) as 'Total Other Eye',
			ISNULL(TotRO,0) as 'Total RO'

FROM 			#_Temp_sps_CallCountMessageSummary


DROP TABLE #_Temp_sps_CallCountMessageSummary
DROP TABLE #_TEMP_MessagesAndImports












GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

