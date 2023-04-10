IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_OrganizationRequestors')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_OrganizationRequestors';
	DROP PROCEDURE sps_rpt_OrganizationRequestors;
END
GO

PRINT 'Creating Procedure sps_rpt_OrganizationRequestors';
GO

CREATE PROCEDURE sps_rpt_OrganizationRequestors
(
	@ReportGroupID 	int,
	@OrganizationID	int,
	@StartDate		datetime,
	@EndDate		datetime
)
AS

/******************************************************************************
**		File: sps_rpt_OrganizationRequestors.sql
**		Name: sps_rpt_OrganizationRequestors
**		Desc: returns a list of Designated Requestors associated with an organization
**
**
**		Return values:
**
**		Called by:   OrganizationRequestors.rdl
**
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: James Gerberich
**		Date: 12/07/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-----------------------------------
**		12/09/2020		James Gerberich		Initial Version. TFS 70398
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

--DECLARE
--	@ReportGroupID 	int = 37,
--	@OrganizationID	int = 3891,
--	@StartDate		datetime = '10/01/2020 00:00',
--	@EndDate		datetime = '11/30/2020 23:59';
----------------------------------------------------------------

SELECT DISTINCT
	Person.PersonID,
	MIN(CallDateTime)AS FirstCalled,
	MAX(CallDateTime)AS LastCalled,
	COUNT(ReferralCallerPersonID) As NumberOfCalls,
	PersonFirst,
	PersonLast,
	PersonTypeName AS Title,
	org.OrganizationName,
	org.OrganizationAddress1,
	org.OrganizationCity,
	st.StateAbbrv,
	org.OrganizationZipCode,
	'(' + ph.PhoneAreaCode + ') ' + ph.PhonePrefix + '-' + ph.PhoneNumber AS Phone
FROM
	Person
	JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID
	JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Person.OrganizationID
	LEFT JOIN Organization org ON Person.OrganizationID = org.OrganizationID
	LEFT JOIN [State] st ON org.StateID = st.StateID
	LEFT JOIN Phone ph ON org.PhoneID = ph.PhoneID
	LEFT JOIN Referral ON Person.PersonID = Referral.ReferralApproachedByPersonID
	LEFT JOIN [Call] ON Referral.CallID = [Call].CallID
WHERE
	Person.Inactive = 0
AND WebReportGroupID = @ReportGroupID
AND Person.OrganizationID = @OrganizationID
AND	[Call].CallDateTime >= @StartDate
AND	[Call].CallDateTime <= @EndDate
AND PATINDEX('*', RIGHT(PersonLast, 1)) > 0
GROUP BY
	Person.PersonID,
	PersonLast,
	PersonFirst,
	PersonTypeName,
	org.OrganizationName,
	org.OrganizationAddress1,
	org.OrganizationCity,
	st.StateAbbrv,
	org.OrganizationZipCode,
	'(' + ph.PhoneAreaCode + ') ' + ph.PhonePrefix + '-' + ph.PhoneNumber
ORDER BY
 	PersonLast,
	PersonFirst;
