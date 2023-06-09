SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSReferralSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSReferralSummary_A]
GO


CREATE PROCEDURE sps_FSReferralSummary_A @vReportGroupID int      = 0,
                                         @vStartDate     datetime = null,
                                         @vEndDate       datetime = null,
                                         @vOrgID         int      = 0       AS

IF @vOrgID = 0
  BEGIN
    SELECT rtc.OrganizationID, rtc.SourceCodeID, o.OrganizationName, 
           Sum(rtc.FST) AS FST,
           Sum(rtc.fsSecondary) AS fsSecondary,
           Sum(rtc.fsApproach) AS fsApproach, 
           Sum(rtc.fsBillMedSoc) AS fsBillMedSoc
    FROM FSReferral_TypeCount rtc
    INNER JOIN Organization o ON o.OrganizationID = rtc.OrganizationID
    INNER JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
    WHERE WebReportGroupID = @vReportGroupID    
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) >= @vStartDate
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) <= @vEndDate
    GROUP BY rtc.OrganizationID, rtc.SourceCodeID, o.OrganizationName
    ORDER BY o.OrganizationName
  END

IF @vOrgID > 0
  BEGIN
    SELECT rtc.YearID, rtc.MonthID, UPPER(CONVERT(VARCHAR(3),DATENAME(m,DATEADD(month, rtc.MonthID-1, 0)))) + ' ' + CONVERT(VARCHAR(10),rtc.YearID) MonthYear, rtc.OrganizationID, rtc.SourceCodeID, o.OrganizationName, 
           Sum(rtc.FST) AS FST,
           Sum(rtc.fsSecondary) AS fsSecondary,
           Sum(rtc.fsApproach) AS fsApproach, 
           Sum(rtc.fsBillMedSoc) AS fsBillMedSoc
    FROM FSReferral_TypeCount rtc
    INNER JOIN Organization o ON o.OrganizationID = rtc.OrganizationID
    INNER JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
    WHERE WebReportGroupID = @vReportGroupID    
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) >= @vStartDate
    AND   CAST(  CAST(rtc.MonthID AS varchar(2)) + '/1/' + CAST(rtc.YearID AS varchar(4))  AS smalldatetime) <= @vEndDate
    AND   rtc.OrganizationID = @vOrgID
    GROUP BY rtc.YearID, rtc.MonthID, rtc.OrganizationID, rtc.SourceCodeID, o.OrganizationName
    ORDER BY o.OrganizationName
  END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

