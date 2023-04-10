--- select * from ReportSortType
--- select 'if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = ''' + ReportSortTypeName + ''' AND ReportSortTypeDisplayName = ''' + ReportSortTypeDisplayName + ''' ) BEGIN INSERT  reportsorttype VALUES (''' + ReportSortTypeName + ''', ''' + ReportSortTypeDisplayName + ''' ) END', * from reportsorttype

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'CallID' AND ReportSortTypeDisplayName = 'Referral #' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('CallID', 'Referral #' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'SourceCodeName' AND ReportSortTypeDisplayName = 'Source Code' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('SourceCodeName', 'Source Code' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'IncomingCall' AND ReportSortTypeDisplayName = 'Triage Incoming Call' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('IncomingCall', 'Triage Incoming Call' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'D
iff_IncomingToSecondary' AND ReportSortTypeDisplayName = 'Time Triage To Secondary' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('Diff_IncomingToSecondary', 'Time Triage To Secondary' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'D
iff_SecondaryPendingToScreening' AND ReportSortTypeDisplayName = 'Time Secondary To Screening' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('Diff_SecondaryPendingToScreening', 'Time Secondary To Screening' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'D
iff_IncomingToPaperwork' AND ReportSortTypeDisplayName = 'Total Time Elapsed' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('Diff_IncomingToPaperwork', 'Total Time Elapsed' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ReferralApproachedByPersonLastName' AND ReportSortTypeDisplayName = 'Last Name (of employee)' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ReferralApproachedByPersonLastName', 'Last Name (of employee)' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ReferralApproachedByPersonFirstName' AND ReportSortTypeDisplayName = 'First Name (of employee)' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ReferralApproachedByPersonFirstName', 'First Name (of employee)' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'PreliminaryRefType' AND ReportSortTypeDisplayName = 'Referral Type' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('PreliminaryRefType', 'Referral Type' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'CallDateTime' AND ReportSortTypeDisplayName = 'Base on D/T' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('CallDateTime', 'Base on D/T' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ReferralDonorLastName' AND ReportSortTypeDisplayName = 'Patient Last Name' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ReferralDonorLastName', 'Patient Last Name' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ReferralFacility' AND ReportSortTypeDisplayName = 'Referral Facility' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ReferralFacility', 'Referral Facility' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'InitialApproachType' AND ReportSortTypeDisplayName = 'Initial Approach Type' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('InitialApproachType', 'Initial Approach Type' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'FinalApproachType' AND ReportSortTypeDisplayName = 'Final Approach Type' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('FinalApproachType', 'Final Approach Type' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ChangeDT' AND ReportSortTypeDisplayName = 'Based on D/T' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ChangeDT', 'Based on D/T' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ChangeUser' AND ReportSortTypeDisplayName = 'StatTrac User' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ChangeUser', 'StatTrac User' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ChangeType' AND ReportSortTypeDisplayName = 'Change Type' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ChangeType', 'Change Type' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'LastName' AND ReportSortTypeDisplayName = 'Last Name' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('LastName', 'Last Name' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'FirstName' AND ReportSortTypeDisplayName = 'First Name' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('FirstName', 'First Name' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ID' AND ReportSortTypeDisplayName = 'ID' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ID', 'ID' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'OrganizationName' AND ReportSortTypeDisplayName = 'Organization Name' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('OrganizationName', 'Organization Name' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'OrganizationID' AND ReportSortTypeDisplayName = 'ID' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('OrganizationID', 'ID' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'ProcessorNumber' AND ReportSortTypeDisplayName = 'Processor #' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('ProcessorNumber', 'Processor #' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'AssignmentNotNeeded' AND ReportSortTypeDisplayName = 'Assignment Not Needed' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('AssignmentNotNeeded', 'Assignment Not Needed' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'PatientFirstName' AND ReportSortTypeDisplayName = 'Patient First Name' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('PatientFirstName', 'Patient First Name' ) 
END

if NOT EXISTS (select * from reportsorttype where ReportSortTypeName = 'CardiacDateTime' AND ReportSortTypeDisplayName = 'Based on D/T' ) 
BEGIN 
	INSERT  reportsorttype VALUES ('CardiacDateTime', 'Based on D/T' ) 
END