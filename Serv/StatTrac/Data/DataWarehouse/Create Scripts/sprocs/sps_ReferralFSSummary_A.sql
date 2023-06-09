SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralFSSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralFSSummary_A]
GO




CREATE PROCEDURE sps_ReferralFSSummary_A @vReportGroupID int      = 0,
                                         @vStartDate     datetime = null,
                                         @vEndDate       datetime = null,
                                         @vOrgID         int      = 0       AS

IF @vOrgID = 0
  BEGIN
    SELECT rtc.OrganizationID, o.OrganizationName, 
           Sum(rtc.FST) AS FST,
           Sum(rtc.fsSecondary) AS fsSecondary,
           Sum(rtc.fsApproach) AS fsApproach, 
           Sum(rtc.fsBillMedSoc) AS fsBillMedSoc
    FROM Referral_FSTypeCount rtc
    JOIN _ReferralProdReport.dbo.Organization o ON o.OrganizationID = rtc.OrganizationID
    JOIN _ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
    JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rtc.SourceCodeID
    JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode wrgsc ON wrgsc.SourceCodeID = sc.SourceCodeID
    WHERE wrgo.WebReportGroupID = @vReportGroupID
    AND wrgsc.WebReportGroupID = @vReportGroupID
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) >= @vStartDate
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) <= @vEndDate
    GROUP BY rtc.OrganizationID, o.OrganizationName
    ORDER BY o.OrganizationName
  END

IF @vOrgID > 0
  BEGIN
    SELECT rtc.YearID, rtc.MonthID, UPPER(CONVERT(VARCHAR(3),DATENAME(m,DATEADD(month, rtc.MonthID-1, 0)))) + ' ' + CONVERT(VARCHAR(10),rtc.YearID) MonthYear, rtc.OrganizationID, o.OrganizationName, 
           Sum(rtc.FST) AS FST,
           Sum(rtc.fsSecondary) AS fsSecondary,
           Sum(rtc.fsApproach) AS fsApproach, 
           Sum(rtc.fsBillMedSoc) AS fsBillMedSoc
    FROM Referral_FSTypeCount rtc
    JOIN _ReferralProdReport.dbo.Organization o ON o.OrganizationID = rtc.OrganizationID
    JOIN _ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
    JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rtc.SourceCodeID
    JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode wrgsc ON wrgsc.SourceCodeID = sc.SourceCodeID
    WHERE wrgo.WebReportGroupID = @vReportGroupID    
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) >= @vStartDate
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) <= @vEndDate
    AND   rtc.OrganizationID = @vOrgID
    AND wrgsc.WebReportGroupID = @vReportGroupID
    GROUP BY rtc.YearID, rtc.MonthID, rtc.OrganizationID, o.OrganizationName
    ORDER BY o.OrganizationName
  END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

