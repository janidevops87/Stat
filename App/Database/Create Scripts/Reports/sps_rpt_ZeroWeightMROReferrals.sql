IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ZeroWeightMROReferrals')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ZeroWeightMROReferrals';
		DROP PROCEDURE  sps_rpt_ZeroWeightMROReferrals;
	END

GO

PRINT 'Creating Procedure sps_rpt_ZeroWeightMROReferrals';

GO

CREATE PROCEDURE sps_rpt_ZeroWeightMROReferrals
(
	@StartDate	datetime,
	@EndDate	datetime
)
AS
/******************************************************************************
**		File: sps_rpt_ZeroWeightMROReferrals.sql
**		Name: sps_rpt_ZeroWeightMROReferrals
**		Desc: Referrals MRO for Organs with patient weight of 0 kg
**
**		Called by:   Zero Weight MRO Report
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		02/25/2022	James Gerberich		Initial design
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

--DECLARE
--	@StartDate	datetime = DATEADD(HOUR, -24, GETDATE()),
--	@EndDate	datetime = GETDATE();
----------------------------------------------------------------

SELECT
	c.CallID AS ReferralNumber,
	c.CallDateTime AS ReferralDate,
	sc.SourceCodeName AS SourceCode,
	org.OrganizationName AS ReferralFacility,
	empl.StatEmployeeFirstName + ' ' +  empl.StatEmployeeLastName AS TakenBy,
	r.ReferralDonorWeight AS PatientWeight,
	aprt.AppropriateReportCode AS OrgansAppropriate
FROM
	[Call] c
	INNER JOIN Referral r ON c.CallID = r.CallID
	INNER JOIN Organization org ON r.ReferralCallerOrganizationID = org.OrganizationID
	LEFT JOIN SourceCode sc ON c.SourceCodeId = sc.SourceCodeId
	LEFT JOIN StatEmployee empl ON c.StatEmployeeID = empl.StatEmployeeID
	LEFT JOIN Appropriate aprt ON r.ReferralOrganAppropriateID = aprt.AppropriateID
WHERE
	c.CallDateTime >= @StartDate
AND	c.CallDateTime <= @EndDate
AND	CAST(NULLIF(REPLACE(r.ReferralDonorWeight, ',', ''), '.') AS decimal(10,1)) = 0
AND	r.ReferralOrganAppropriateID = 4 --MRO
AND	(
		sc.SourceCodeName = 'AR'
	OR	sc.SourceCodeName = 'BCTS'
	OR	sc.SourceCodeName = 'CO'
	OR	sc.SourceCodeName = 'CASD'
	OR	sc.SourceCodeName = 'FLTL'
	OR	sc.SourceCodeName = 'HIOP'
	OR	sc.SourceCodeName = 'NCDS'
	OR	sc.SourceCodeName = 'NMDS'
	OR	sc.SourceCodeName = 'PAGL'
	OR	sc.SourceCodeName = 'SDS'
	OR	sc.SourceCodeName = 'TNDS'
	OR	sc.SourceCodeName = 'TOSA'
	OR	sc.SourceCodeName = 'WANW'
	OR	sc.SourceCodeName = 'WIDN'
	OR	sc.SourceCodeName = 'WIOP'
	);