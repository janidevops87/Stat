IF NOT EXISTS (SELECT 1 FROM dbo.Report WHERE ReportID = 346)
	BEGIN
		SET IDENTITY_INSERT dbo.Report ON;
		INSERT Report (ReportID, ReportDisplayName, LastModified, ReportVirtualURL, ReportTypeID, SourceCodeTypeId)
		VALUES (346, 'Uploaded Referral Status', GETDATE(), '/CCRST307ReportingSiteRedesign/UploadedReferralStatus', 9, NULL);
		SET IDENTITY_INSERT dbo.Report OFF;
	END;

IF NOT EXISTS (SELECT 1 FROM dbo.ReportControl WHERE ReportControlName = 'customParamsUploadedReferralStatus')
	BEGIN
		INSERT dbo.ReportControl (ReportControlName, ReportParamSectionID)
		VALUES ('customParamsUploadedReferralStatus', 1);
	END;

IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportID = 346 AND ReportControlID = 2)
	BEGIN
		INSERT dbo.ReportParamConfiguration (ReportID, ReportControlID)
		VALUES (346, 2);
	END;
IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportID = 346 AND ReportControlID = 3)
	BEGIN
		INSERT dbo.ReportParamConfiguration (ReportID, ReportControlID)
		VALUES (346, 3);
	END;
IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportID = 346 AND ReportControlID = 6)
	BEGIN
		INSERT dbo.ReportParamConfiguration (ReportID, ReportControlID)
		VALUES (346, 6);
	END;
IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportID = 346 AND ReportControlID = 9)
	BEGIN
		INSERT dbo.ReportParamConfiguration (ReportID, ReportControlID)
		VALUES (346, 9);
	END;
IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportID = 346 AND ReportControlID = (Select ReportControlID From dbo.ReportControl Where ReportControlName = 'customParamsUploadedReferralStatus'))
	BEGIN
		INSERT dbo.ReportParamConfiguration (ReportID, ReportControlID)
		SELECT
			346,
			ReportControlID
		FROM dbo.ReportControl
		WHERE ReportControlName = 'customParamsUploadedReferralStatus';
	END;

IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE RoleName = 'Report Portal: Uploaded Referral Status')
	BEGIN
		INSERT dbo.Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified, Inactive)
		VALUES ('Report Portal: Uploaded Referral Status', 'Access to Uploaded Referral Status report.', 1564, 1, GETDATE(), 0)
	END;

IF NOT EXISTS (SELECT 1 FROM dbo.ReportRule WHERE ReportID = 346 AND RoleID = 3)
	BEGIN
		INSERT dbo.ReportRule (ReportID, RoleID, LastStatEmployeeID, AuditLogTypeID, LastModified)
		VALUES (346, 3, 1559, 1, GETDATE())
	END;
IF NOT EXISTS (SELECT 1 FROM dbo.ReportRule WHERE ReportID = 346 AND RoleID = (Select RoleID From dbo.Roles Where RoleName = 'Report Portal: Uploaded Referral Status'))
	BEGIN
		INSERT dbo.ReportRule (ReportID, RoleID, LastStatEmployeeID, AuditLogTypeID, LastModified)
		SELECT
			346,
			RoleID,
			1559,
			1,
			GETDATE()
		FROM dbo.Roles
		WHERE RoleName = 'Report Portal: Uploaded Referral Status'
	END;
