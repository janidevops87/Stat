SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_ReportsIncluded_ByClient]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_ReportsIncluded_ByClient]
GO


CREATE PROCEDURE CONTRACTS_ReportsIncluded_ByClient @OrganizationID INT AS
SELECT DISTINCT r.ReportID, 
                (SELECT o.OrganizationName
                 FROM Organization o,
                      State s
                 WHERE o.StateID        = s.StateID
                 AND   o.OrganizationID = @OrganizationID) AS OrganizationName,
                ltrim(rtrim(r.ReportDisplayName)) AS ReportDisplayName, 
                CASE r.ReportTypeID
                  WHEN 1 THEN 'Referrals'
                  WHEN 2 THEN 'Messages'
                  WHEN 3 THEN 'Imports'
                  WHEN 4 THEN 'Referral Statistics'
                  WHEN 5 THEN 'General'
                  WHEN 6 THEN 'Custom'
                  WHEN 7 THEN 'Schedules'
                  ELSE 'Unknown'
                END AS ReportType,
                CASE
                  WHEN (r.ReportTypeID = 5 AND (r.ReportLocalOnly = -1                          OR @OrganizationID = 194)) THEN 'YES'
                  WHEN (r.ReportTypeID = 6 AND (rc.ReportCustomOrganizationID = @OrganizationID OR @OrganizationID = 194)) THEN 'YES'
                  WHEN (r.ReportTypeID = 7 AND (r.ReportID IN (84,78,81)                        OR @OrganizationID = 194)) THEN 'YES'
                  WHEN r.ReportTypeID in (1,2,3,4)                                                                         THEN 'YES'
                  ELSE 'NO'
                END as Included,
                  r.*
FROM Report r
LEFT OUTER JOIN ReportCustom rc ON r.ReportID = rc.ReportCustomReportID
ORDER BY ReportType, ReportDisplayName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

