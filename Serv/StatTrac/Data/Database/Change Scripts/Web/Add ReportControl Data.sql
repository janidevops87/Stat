/*
print 'Add ReportConrol Data'
set identity_insert ReportControl ON


IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlReportDateType')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (1, 'ddlReportDateType', 2)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'dateTimeChooserStart')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (2, 'dateTimeChooserStart', 2)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'dateTimeChooserEnd')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (3, 'dateTimeChooserEnd', 2)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlReportGroup')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (4, 'ddlReportGroup', 3)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlOrganization')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (5, 'ddlOrganization', 3)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlSourceCode')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (6, 'ddlSourceCode', 3)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlOrganizationCoordinator')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (7, 'ddlOrganizationCoordinator', 3)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'txtBoxLowerAge')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (8, 'txtBoxLowerAge', 4)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlGender')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (9, 'ddlGender', 4)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'txtBoxUpperAge')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (10, 'txtBoxUpperAge', 4)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlSortOption1')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (11, 'ddlSortOption1', 5)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlSortOption2')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (12, 'ddlSortOption2', 5)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'ddlSortOption3')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (13, 'ddlSortOption3', 5)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'chkBoxDisplayReferralName')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (14, 'chkBoxDisplayReferralName', 6)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'chkBoxDisplaySSN')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (15, 'chkBoxDisplaySSN', 6)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'chkBoxDisplayMedicalRecord')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (16, 'chkBoxDisplayMedicalRecord', 6)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'avayaCustomParams')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (17, 'avayaCustomParams', 1)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'fSConversionParams')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (18, 'fSConversionParams', 1)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'callParams')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (19, 'callParams', 1)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'approchPersonParams')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (20, 'approchPersonParams', 1)
END
IF NOT EXISTS(SELECT * FROM ReportControl WHERE ReportControlName = 'referralDetailParams')
BEGIN
	insert ReportControl (ReportControlID, ReportControlName, ReportParamSectionID) values (21, 'referralDetailParams', 1)
END


set identity_insert ReportControl OFF
*/