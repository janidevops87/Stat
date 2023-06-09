SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_HospitalReportTimeSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_HospitalReportTimeSummary_A]
GO






CREATE PROCEDURE sps_HospitalReportTimeSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS
/*
CREATE TABLE #_Temp_Referral_ReportTimeSummary
   (
   [TimeRangeID] [int] NULL,
--   [TimeRangeName] [char] (10)  NULL,
   [YearID] [int] NULL,
   [MonthID][int] NULL, 
   [OrganizationID] [int] NULL,
   [OrganizationName] [char] (80),
   [AllTypes] [int] NULL DEFAULT(0),
   [AppropriateOrgan] [int] NULL DEFAULT(0),
   [AppropriateAllTissue] [int] NULL DEFAULT(0),
   [AppropriateEyes] [int] NULL DEFAULT(0),
   [AppropriateRO] [int] NULL DEFAULT(0)
   )
*/

     IF	@vOrgID = 0
--     BEGIN
--       INSERT #_Temp_Referral_ReportTimeSummary
--        (TimeRangeID, OrganizationID, OrganizationName, AllTypes, AppropriateOrgan, AppropriateAllTissue, AppropriateEyes, AppropriateRO)   
    	SELECT 		TimeRangeID,
                        TimeRangeName,
                        TimeRangeStart,
                        TimeRangeEnd,
                        Referral_HospitalReportTimeCount.OrganizationID, 
			OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_HospitalReportTimeCount
        JOIN            HospitalReportTimeRange ON HospitalReportTimeRange.HospitalReportTimeRangeID = Referral_HospitalReportTimeCount.TimeRangeID 
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_HospitalReportTimeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_HospitalReportTimeCount.OrganizationID
        JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime) BETWEEN @vStartDate AND @vEndDate

	GROUP BY	TimeRangeID,  TimeRangeName, TimeRangeStart, TimeRangeEnd, Referral_HospitalReportTimeCount.OrganizationID, OrganizationName
    	ORDER BY 	OrganizationName


/*
     SELECT      TimeRangeID, TimeRangeName, 
                 OrganizationID, OrganizationName, 
                AllTypes, AppropriateOrgan, AppropriateAllTissue, AppropriateEyes, AppropriateRO
     FROM #_Temp_Referral_ReportTimeSummary
     RIGHT JOIN HospitalReportTimeRange ON HospitalReportTimeRange.HospitalReportTimeRangeID = #_Temp_Referral_ReportTimeSummary.TimeRangeID 
     ORDER BY OrganizationName, TimeRangeID

     END
*/
     IF	@vOrgID > 0
--     BEGIN     
--         INSERT #_Temp_Referral_ReportTimeSummary 
--        (TimeRangeID, YearID, MonthID, OrganizationID, OrganizationName, AllTypes, AppropriateOrgan, AppropriateAllTissue, AppropriateEyes, AppropriateRO)   
    	SELECT 		TimeRangeID, TimeRangeName,TimeRangeStart,
                        TimeRangeEnd,
                        YearID,      
                        Referral_HospitalReportTimeCount.MonthID AS MonthID, 
			Referral_HospitalReportTimeCount.OrganizationID, 
                        OrganizationName, 
                        Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_HospitalReportTimeCount
        JOIN            HospitalReportTimeRange ON HospitalReportTimeRange.HospitalReportTimeRangeID = Referral_HospitalReportTimeCount.TimeRangeID 
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_HospitalReportTimeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_HospitalReportTimeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_HospitalReportTimeCount.MonthID


	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime) BETWEEN @vStartDate AND @vEndDate
	AND		Referral_HospitalReportTimeCount.OrganizationID = @vOrgID

	GROUP BY	TimeRangeID ,  TimeRangeName, TimeRangeStart, TimeRangeEnd, YearID, Referral_HospitalReportTimeCount.MonthID, 
			Referral_HospitalReportTimeCount.OrganizationID, OrganizationName
    	ORDER BY 	YearID, Referral_HospitalReportTimeCount.MonthID, OrganizationName
/*
        SELECT        YearID, MonthID
                      TimeRangeID, TimeRangeName, 
                      OrganizationID, OrganizationName, 
                      AllTypes, AppropriateOrgan, AppropriateAllTissue, AppropriateEyes, AppropriateRO
        FROM          #_Temp_Referral_ReportTimeSummary
        right JOIN     HospitalReportTimeRange ON HospitalReportTimeRange.HospitalReportTimeRangeID = #_Temp_Referral_ReportTimeSummary.TimeRangeID
        ORDER BY      OrganizationName, TimeRangeID     

     END      

DROP TABLE #_Temp_Referral_ReportTimeSummary
*/





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

