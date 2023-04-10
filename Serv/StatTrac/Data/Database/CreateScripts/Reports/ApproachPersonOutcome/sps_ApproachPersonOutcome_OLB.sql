SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPersonOutcome_OLB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_ApproachPersonOutcome_OLB]
End
go


CREATE    PROCEDURE sps_ApproachPersonOutcome_OLB
	@StartDateTime		SmallDateTime = Null,
	@EndDateTime		SmallDateTime = Null,
	@WebReportGroupID	int = Null,
	@OrganizationID		int = Null

AS


/* 
	Procedure: sps_ApproachPersonOutcome
	ISE: christopher carroll
	Date: 01/16/2007
	Inputs:
		@StartDateTime datetime '01/01/2006 00:00',
		@EndDateTime datetime '12/31/2006 23:59',
		@WebReportGroupID int, (optional) future,
		@OrganizationID	int, (optional) future

	Notes: 	This procedure uses a derived table to calculate totals for consent. The
		derived table is organized to provide statistical information from actual referrals.
		After data is retrieved and put into a grid, summary data is then calculated and returned.
*/

SELECT
		@StartDateTime = ISNULL(
						@StartDateTime, 
						CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
						@EndDateTime, 
						CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
					)

SELECT 
 -- sq.OrganizationName AS 'OrganizationName',
 (sq.PersonFirst + ' ' + sq.PersonLast) AS 'ApproachPerson',
 count(sq.PersonID) AS 'Approaches',
 sum(sq.ConsentYesVerbal) AS 'ConsentYesVerbal',
 sum(sq.ConsentYesNoReg) AS 'ConsentYesNoReg',
 sum(sq.ConsentYesReg) AS 'ConsentYesReg'
FROM

(SELECT DISTINCT
	c.CallNumber,
	--c.CallDateTime,
	c.SourceCodeID,
	--o.OrganizationName,
	abp.PersonID,
	abp.PersonLast,
	abp.PersonFirst,
	--r.ReferralApproachTypeID,
	--c.SourceCode,
	CASE r.referralGeneralConsent WHEN 2 THEN 1 ELSE 0 END AS 'ConsentYesVerbal',
	CASE WHEN r.referralGeneralConsent = 1 AND (ISNULL(rs.RegistryStatus,0) = 5 OR ISNULL(rs.RegistryStatus,0) = 3 OR ISNULL(rs.RegistryStatus,0) = 0)  THEN 1 ELSE 0 END AS 'ConsentYesNoReg',
	CASE WHEN r.referralGeneralConsent = 1 AND (ISNULL(rs.RegistryStatus,0) = 1 OR ISNULL(rs.RegistryStatus,0) = 2 OR ISNULL(rs.RegistryStatus,0) = 4) THEN 1 ELSE 0 END AS 'ConsentYesReg'

FROM Call c
JOIN Referral r ON c.CallID = r.CallID
JOIN Person abp ON r.ReferralApproachedByPersonID = abp.PersonID
--JOIN Organization o ON o.OrganizationID = r.ReferralCallerOrganizationID
--JOIN WebReportGroupSourceCode rgs ON rgs.SourceCodeID = c.SourceCodeID
LEFT JOIN RegistryStatus rs ON rs.CallID = c.CallID

WHERE c.CallDateTime BETWEEN @StartDateTime AND @EndDateTime -- StartDate / EndDate
AND (c.SourceCodeID = 239 OR c.SourceCodeID = 24)

AND (r.ReferralApproachTypeID <> 1 -- Exclude 1. Not Approached
  OR r.ReferralApproachTypeID <> 7)-- Exclude 7. Unknown
--AND rgs.WebReportGroupID = ISNULL(@WebReportGroupID,rgs.WebReportGroupID)
--AND o.OrganizationID = ISNULL(@OrganizationID,o.OrganizationID)

) sq -- temp table name

Group By
--sq.OrganizationName,
sq.PersonLast,
sq.PersonFirst

Order By
--sq.OrganizationName,
sq.PersonLast,
sq.PersonFirst,
count(sq.PersonID)DESC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_ApproachPersonOutcome_OLB create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - sps_ApproachPersonOutcome_OLB created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/




