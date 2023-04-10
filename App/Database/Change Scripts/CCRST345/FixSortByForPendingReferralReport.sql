/******************************************************************************
**		File: FixSortByForPendingReferralReport.sql
**		Name: FixSortByForPendingReferralReport
**		Desc: Fix sort by option for pending referral report to what the report is expecting
**
**		Auth: Pam Scheichenost
**		Date: 08/09/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/09/2021	Pam Scheichenost	initial
*******************************************************************************/

IF EXISTS (SELECT 1 FROM dbo.ReportSortTypeConfiguration WHERE ReportId = 319 AND ReportSortTypeID = 56)
BEGIN
	UPDATE dbo.ReportSortTypeConfiguration
	SET ReportSortTypeID = 28
	WHERE ReportId = 319
	AND ReportSortTypeID = 56;
END
GO