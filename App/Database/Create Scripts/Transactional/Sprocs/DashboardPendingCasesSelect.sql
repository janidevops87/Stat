IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingCasesSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingCasesSelect'
		DROP Procedure DashboardPendingCasesSelect
	END
GO
PRINT 'Creating Procedure DashboardPendingCasesSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardPendingCasesSelect.sql
**	Name: DashboardPendingCasesSelect
**	Desc: List pending cases
**	Auth: Serge Hurko
**	Date: 10/09/2018
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/09/2018		Serge Hurko				initial
**	03/19/2019		Mike Berenson			Added ReferralType to output
*******************************************************************************/

CREATE PROCEDURE DashboardPendingCasesSelect
AS
SELECT
	(SELECT ReferralAbbreviation FROM ReferralType WHERE ReferralTypeID = ABS(ref.CurrentReferralTypeID)) AS ReferralType,
	ref.CallID,
	ref.ReferralPendingCaseLastModified LastModified,
	ref.ReferralDonorName PatientName,
	ISNULL(sc.SourceCodeName, '') + ' - ' + ISNULL(org.OrganizationName, '') Organization,
	ISNULL(person.PersonFirst, '') + ' ' + ISNULL(SUBSTRING(PersonLast, 1, 1), '') Coordinator,
	ref.ReferralPendingCaseComment Comment
FROM dbo.Referral ref
	INNER JOIN dbo.[Call] [call] ON [call].CallID = ref.CallID
	INNER JOIN dbo.SourceCode sc ON sc.SourceCodeID = [call].SourceCodeID
	LEFT JOIN dbo.Organization org ON org.OrganizationID = ref.ReferralCallerOrganizationID
	INNER JOIN StatEmployee emp ON emp.StatEmployeeID = ref.ReferralPendingCaseCoordinator
	INNER JOIN Person person ON person.PersonID = emp.PersonID
WHERE ref.ReferralPendingCase = -1
ORDER BY ref.ReferralPendingCaseLastModified;
