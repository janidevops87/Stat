SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageCountSummary_B]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageCountSummary_B]
GO


CREATE PROCEDURE sps_MessageCountSummary_B
	@vOrgID			int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int		= 0

AS


	DECLARE @vMessageSourceCodeName varchar(20)
	SELECT	@vMessageSourceCodeName = SourceCodeName
	FROM	_ReferralProdReport..SourceCode
	WHERE	SourceCodeID = @vSourceCodeID
--SELECT @vMessageSourceCodeName
	/*DECLARE @vMessageSourceCodeID int
	SELECT	@vMessageSourceCodeID = SourceCodeID 
	FROM 	_ReferralProdReport..SourceCode 
	WHERE 	SourceCodeName IN (Select	SourceCodeName 
				   FROM 	_ReferralProdReport..SourceCode  
				   WHERE 	SourceCodeID = @vSourceCodeID ) 
	AND 	SourceCodeType = 2
	*/


    	SELECT 		Referral_MessageCountSummary.OrganizationID,
    			_ReferralProdReport.dbo.Organization.OrganizationName,
    			SUM(TotalMessages) AS 'TotalMessages',
    			SUM(TotalImports) AS 'TotalImports'    			
    	
    	FROM 		Referral_MessageCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_MessageCountSummary.OrganizationID
	--JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID
	JOIN		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_MessageCountSummary.SourceCodeID
	
   	WHERE 		_ReferralProdReport.dbo.SourceCode.SourceCodeName = @vMessageSourceCodeName
	AND		Referral_MessageCountSummary.OrganizationID = @vOrgID	
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
--	AND		
	GROUP BY 	Referral_MessageCountSummary.OrganizationID, _ReferralProdReport.dbo.Organization.OrganizationName

/*
	JOIN		_ReferralProdReport.dbo.WebReportGroup ON _ReferralProdReport.dbo.WebReportGroup.OrgHierarchyParentID = Referral_MessageCountSummary.OrganizationID
 	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = _ReferralProdReport.dbo.WebReportGroup.WebReportGroupID
 	WHERE 		_ReferralProdReport.dbo.WebReportGroup.WebReportGroupID = @vReportGroupID
	--AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = @vSourceCodeID
	AND		Referral_MessageCountSummary.SourceCodeID= @vMessageSourceCodeID
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate


    	FROM 		Referral_MessageCountSummary
	JOIN		_ReferralProdReport.dbo.WebReportGroup ON _ReferralProdReport.dbo.WebReportGroup.OrgHierarchyParentID = Referral_MessageCountSummary.OrganizationID
 	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = _ReferralProdReport.dbo.WebReportGroup.WebReportGroupID

	
   	WHERE 		_ReferralProdReport.dbo.WebReportGroup.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = @vSourceCodeID
	--AND		SourceCodeID= @vSourceCodeID
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
*/	





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

