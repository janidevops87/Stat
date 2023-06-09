SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_UnitSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_UnitSummary_A]
GO



CREATE PROCEDURE sps_UnitSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

CREATE TABLE #_Temp_UnspecifiedUnit
(
   SubLocationID [int]null,
   SubLocationName       [varchar](50)null
   
)
   insert #_Temp_UnspecifiedUnit
   (SubLocationID, SubLocationName)
   (Select SubLocationID, SubLocationName FROM _ReferralProdReport..SubLocation)

   insert #_Temp_UnspecifiedUnit
   (SubLocationID, SubLocationName)
   Values(-1, 'Unspecified Unit')

SET CONCAT_NULL_YIELDS_NULL  OFF

IF	@vOrgID = 0

    	SELECT 		Referral_UnitSummaryCount.OrganizationID, 
			OrganizationName, 
			Referral_UnitSummaryCount.SubLocationID As LocationID, 
			SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel AS Unit,
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO,
			Referral_UnitSummaryCount.SubLocationLevel  AS SubLocation

    	FROM 		Referral_UnitSummaryCount
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_UnitSummaryCount.OrganizationID
	LEFT JOIN	#_Temp_UnspecifiedUnit ON #_Temp_UnspecifiedUnit.SublocationID =  Referral_UnitSummaryCount.SubLocationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
   	 WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_UnitSummaryCount.OrganizationID, OrganizationName, Referral_UnitSummaryCount.SubLocationID,  SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel, Referral_UnitSummaryCount.SubLocationLevel  
    	ORDER BY 	OrganizationName, SubLocationName + ' ' + SubLocation
    	-- ccarroll 03/16/2010 Removed table prefix in  ORDER BY for SQL 2008 Upgrade    	-- was" ORDER BY 	OrganizationName, SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel

IF	@vOrgID > 0

    	SELECT 		YearID, Referral_UnitSummaryCount.MonthID AS MonthID, 
			Referral_UnitSummaryCount.SubLocationID As LocationID, 
			SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel AS Unit,
			CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			Referral_UnitSummaryCount.OrganizationID, OrganizationName, Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO,
			Referral_UnitSummaryCount.SubLocationLevel  AS SubLocation

    	FROM 		Referral_UnitSummaryCount
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_UnitSummaryCount.OrganizationID
	LEFT JOIN	#_Temp_UnspecifiedUnit ON #_Temp_UnspecifiedUnit.SublocationID =  Referral_UnitSummaryCount.SubLocationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_UnitSummaryCount.MonthID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_UnitSummaryCount.OrganizationID = @vOrgID

	GROUP BY	YearID, Referral_UnitSummaryCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_UnitSummaryCount.OrganizationID, OrganizationName, Referral_UnitSummaryCount.SubLocationID,  SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel, Referral_UnitSummaryCount.SubLocationLevel  
    	ORDER BY 	YearID, MonthID, OrganizationName, SubLocationName + ' ' + SubLocation    	-- ccarroll 03/16/2010 Removed table prefix in  ORDER BY for SQL 2008 Upgrade    	-- was: ORDER BY 	YearID, Referral_UnitSummaryCount.MonthID, OrganizationName, SubLocationName + ' ' + Referral_UnitSummaryCount.SubLocationLevel


Drop Table #_Temp_UnspecifiedUnit

SET CONCAT_NULL_YIELDS_NULL  ON







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

