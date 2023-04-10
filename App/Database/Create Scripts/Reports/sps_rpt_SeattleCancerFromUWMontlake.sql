IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_SeattleCancerFromUWMontlake')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_SeattleCancerFromUWMontlake';
		DROP PROCEDURE  sps_rpt_SeattleCancerFromUWMontlake;
	END

GO

PRINT 'Creating Procedure sps_rpt_SeattleCancerFromUWMontlake';

GO

CREATE PROCEDURE sps_rpt_SeattleCancerFromUWMontlake
(
	@StartDate	datetime,
	@EndDate	datetime
)
AS
/******************************************************************************
**		File: sps_rpt_SeattleCancerFromUWMontlake.sql
**		Name: sps_rpt_SeattleCancerFromUWMontlake
**		Desc: This is an internal query needed to determine when a referral for 
**			Seattle Cancer Center is mistakenly taken under UW Medical Center-Montlake.
**
**		Called by:   Seattle Cancer From UW Med Ctr Montlake Report
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
--	@StartDate	datetime = DATEADD(MONTH, -1, GETDATE()),
--	@EndDate	datetime = GETDATE();
----------------------------------------------------------------

SELECT
	c.CallID AS ReferralNumber,
	c.CallDateTime AS ReferralDate,
	sc.SourceCodeName AS SourceCode,
	org.OrganizationName AS ReferralFacility,
	phn.PhoneAreaCode + '-' + phn.PhonePrefix + '-' + phn.PhoneNumber AS CallerPhone
FROM
	[Call] c
	INNER JOIN Referral r ON c.CallID = r.CallID
	INNER JOIN SourceCode sc ON c.SourceCodeId = sc.SourceCodeId AND sc.SourceCodeName = 'WANW'
	INNER JOIN Organization org ON r.ReferralCallerOrganizationID = org.OrganizationID AND org.OrganizationName = 'UW Medical Center - Montlake'
	LEFT JOIN Phone phn ON r.ReferralCallerPhoneID = phn.PhoneID
WHERE
	c.CallDateTime >= @StartDate
AND	c.CallDateTime <= @EndDate
AND	phn.PhoneAreaCode = '206'
AND	(
		phn.PhonePrefix = '597'
	OR	phn.PhonePrefix = '598'
	)
AND	(
		phn.PhoneNumber = '2351'
	OR	phn.PhoneNumber = '3072'
	OR	phn.PhoneNumber = '3341'
	OR	phn.PhoneNumber = '3696'
	OR	phn.PhoneNumber = '3834'
	OR	phn.PhoneNumber = '3943'
	OR	phn.PhoneNumber = '4150'
	OR	phn.PhoneNumber = '8575'
	OR	phn.PhoneNumber = '8576'
	OR	phn.PhoneNumber = '8577'
	OR	phn.PhoneNumber = '8697'
	OR	phn.PhoneNumber = '8902'
	OR	phn.PhoneNumber = '9802'
	);