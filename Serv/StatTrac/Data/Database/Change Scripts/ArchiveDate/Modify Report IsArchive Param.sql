 UPDATE Reportdatetimeconfiguration
SET IsArchived = 1
WHERE ReportID IN(
	select 
		reportID 
	from 
		report 
	where  
	ReportDisplayName in (
	'Referral Detail', 
	'Total Call Time', 
	'Processor Number', 
	'Approach Outcome', 
	'Referral Outcome', 
	'Referral Activity', 
	'Triage Outcome Summary', 
	'Message Detail', 
	'Import Offer Detail', 
	'Outcome by Category', 
	'Message Activity', 
	'Import Offer Activity'
	)
)