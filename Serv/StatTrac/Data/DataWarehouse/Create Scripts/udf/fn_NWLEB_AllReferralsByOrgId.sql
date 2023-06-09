SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_NWLEB_AllReferralsByOrgId]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_NWLEB_AllReferralsByOrgId]
GO

CREATE FUNCTION [dbo].[fn_NWLEB_AllReferralsByOrgId] (@vReportGroupID int, @vStartDate datetime, @vEndDate datetime, @vOrgID int)  
RETURNS Integer
AS

BEGIN 

-- Function takes an OrganizationId and start and end dates and gives a total
-- (Based on functionality found in sps_Appropriate_Total and sps_ROTotal)

DECLARE @vAppropriateTotal int,
	@vROTotal int

		-- From sps_Appropriate_Total
SET @vAppropriateTotal = (SELECT Sum(Referral_TypeCount.AnyAppropriate)AS AnyAppropriate
		FROM Referral_TypeCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
		    	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
			JOIN [Month] ON [Month].MonthID = Referral_TypeCount.MonthID

		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
			AND Referral_TypeCount.OrganizationID = @vOrgID)

		-- from sps_ROTotal
SET @vROTotal = (SELECT Sum(Referral_AppropriateReasonCount.AppropriateRO)AS ROType
		FROM Referral_AppropriateReasonCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
			JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
			JOIN Month ON Month.MonthID = Referral_AppropriateReasonCount.MonthID

		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
			AND Referral_AppropriateReasonCount.OrganizationID = @vOrgID)




	Return @vAppropriateTotal + @vROTotal
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

