/******************************************************************************
**		File: DisplayRegistryReports.sql
**		Name: Adding back new registry reports
**		Desc: Adding back new registry reports
**		Auth: Pam Scheichenost	
**		Date: 03/23/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      03/23/2021	Pam Scheichenost	initial
*******************************************************************************/

--Actionable Designation Volume by Event (old: 205, new: 300)
UPDATE ReportRule
set ReportId = 300,
	LastStatEmployeeID = 1564,  --me
	LastModified = GetDate()
WHERE ReportRuleID IN (154,176,209);

--Actionable Designation Volume by Status (old: 207, new: 301)
UPDATE ReportRule
set ReportId = 301,
	LastStatEmployeeID = 1564,  --me
	LastModified = GetDate()
WHERE ReportRuleID IN (155,175,210);

--Actionable Designation Volume by zip code (old: 208, new: 302)
UPDATE ReportRule
set ReportId = 302,
	LastStatEmployeeID = 1564,  --me
	LastModified = GetDate()
WHERE ReportRuleID IN (156,174,211);
