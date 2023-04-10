IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ApproachOutcomeDetail')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ApproachOutcomeDetail'
		DROP  Procedure  sps_rpt_ApproachOutcome
	END
GO

PRINT 'Creating Procedure sps_rpt_ApproachOutcomeDetail'
GO

CREATE Procedure [dbo].[sps_rpt_ApproachOutcomeDetail]
(
	@StartDate		datetime = NULL,
	@EndDate		datetime = NULL,
	@SourceCodeID	int = 14 --CO Referrals
)
AS

/******************************************************************************
**		File: sps_rpt_ApproachOutcome.sql
**		Name: sps_rpt_ApproachOutcome
**		Desc: Used to generate CSV file; Requested by Donor Alliance (CO)
**
**		Auth: James Gerberich
**		Date: 03/21/2018
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:		Author:				Description:
**	--------	--------			-------------------------------------------
**	03/21/2018	James Gerberich		Initial release VS 54569
*******************************************************************************/

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--DECLARE
--	@StartDate		datetime = NULL,
--	@EndDate		datetime = NULL,
--	@SourceCodeID	int = 14 --CO Referrals
 
----------------------------------------------------------------

IF @StartDate IS NULL
BEGIN SET @StartDate = DATEADD(day, -365, GETDATE()) END;
IF @EndDate IS NULL
BEGIN SET @EndDate = GETDATE() END;

----------------------------------------------------------------

SELECT DISTINCT
	c.CallID AS ReferralNumber,
	refFac.OrganizationName AS ReferralFacility,
	aType.ApproachTypeName AS ApproachType,
	IsNULL(p.PersonFirst + ' ', '') + IsNULL(p.PersonLast, '') AS ApproacherName,
	CASE ref.ReferralGeneralConsent
		WHEN 1 THEN 'Yes - Written'
		WHEN 2 THEN 'Yes - Verbal'
		WHEN 3 THEN 'No'
		ELSE 'No Outcome'
	END AS ApproachOutcome
FROM
	dbo.[Call] c
	INNER JOIN dbo.Referral ref ON c.CallID = ref.CallID		
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
	INNER JOIN dbo.SourceCodeOrganization sco
			LEFT JOIN dbo.Organization refFac ON sco.OrganizationID = refFac.OrganizationID
		ON ref.ReferralCallerOrganizationID = sco.OrganizationID
	LEFT JOIN dbo.ApproachType aType ON ref.ReferralApproachTypeID = aType.ApproachTypeID
	LEFT JOIN dbo.Person p ON ref.ReferralApproachedByPersonID = p.PersonID
WHERE
	c.CallDateTime >= @StartDate
AND	c.CallDateTime <= @EndDate
AND	c.SourceCodeID = @SourceCodeID;