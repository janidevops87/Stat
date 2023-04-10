/******************************************************************************
**		File: CreateReportAndPermissions_PageResponseTimes.sql
**		Name: Create new report and permissions for the PageResponseTimes report
**		Desc: Create new report with configuration and permissions for the 
**				PageResponseTimes report 
**
**		Auth: Mike Berenson
**		Date: 05/12/2022
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      05/12/2022	Mike Berenson		initial
*******************************************************************************/

DECLARE
	@ModifiedDate DATETIME = GETDATE(),
	@ReportFolder NVARCHAR(50) = '/CCRST307ReportingSiteRedesign'; 

-- Create new Report record
IF NOT EXISTS (SELECT 1 FROM dbo.Report WHERE ReportId = 347)
BEGIN
	SET IDENTITY_INSERT dbo.Report ON;

	INSERT INTO dbo.Report 
	(ReportId, ReportDisplayName, LastModified, ReportVirtualURL, ReportTypeID, SourceCodeTypeId) 
	VALUES 
	(347,'Page Response Times',@ModifiedDate, @ReportFolder + '/PageResponseTimes',8,NULL)

	SET IDENTITY_INSERT dbo.Report OFF;
END

-- Create new ReportDateTimeConfiguration record
IF NOT EXISTS (SELECT 1 FROM dbo.ReportDateTimeConfiguration WHERE ReportId = 347)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration ON;

	INSERT INTO dbo.ReportDateTimeConfiguration
	(ReportDateTimeConfigurationID, ReportID, ReportDateTimeID, IsArchived, IsDateOnly)
	VALUES
	(131, 347, 1, 0, 0)

	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration OFF;
END

-- Create new ReportDateTypeConfiguration record
IF NOT EXISTS (SELECT 1 FROM dbo.ReportDateTypeConfiguration WHERE ReportId = 347)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration ON;

	INSERT INTO dbo.ReportDateTypeConfiguration
	(ReportDateTypeConfigurationID, ReportID, ReportDateTypeID, ReportDateTypeConfigurationIsDefault)
	VALUES
	(141, 347, 11, 1)	

	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration OFF;
END


-- Create new ReportParamConfiguration records
IF NOT EXISTS (SELECT 1 FROM dbo.ReportParamConfiguration WHERE ReportId = 347)
BEGIN
	SET IDENTITY_INSERT dbo.ReportParamConfiguration ON;

	INSERT INTO dbo.ReportParamConfiguration
	(ReportParamConfiguration, ReportId, ReportControlId)
	VALUES
	(2271, 347,	1),
	(2272, 347,	2),
	(2273, 347,	3),
	(2275, 347, 48),
	(2274, 347,	122)

	SET IDENTITY_INSERT dbo.ReportParamConfiguration OFF;
END






-- Create new Role records
IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE RoleId = 106)
BEGIN
	SET IDENTITY_INSERT dbo.Roles ON;

	insert into dbo.Roles
	(RoleID, RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID,LastModified, Inactive)
	SELECT 
	106, 'Report Portal: ' + r.ReportDisplayName, 'Access to ' + r.ReportDisplayName + ' report.', 2927, 1 , GetDate(), 0
	FROM Report r
	WHERE r.ReportId = 347

	SET IDENTITY_INSERT dbo.Roles OFF;
END

-- Create new ReportRule records for 2927
IF NOT EXISTS (SELECT 1 FROM dbo.ReportRule WHERE RoleId = 106)
BEGIN
	--create new records for new reports that match old reports
	INSERT INTO dbo.ReportRule
		(ReportID, RoleID, LastStatEmployeeID, LastModified)
	SELECT r.ReportId, 106, 2927, GETDATE()
	FROM Report r
	WHERE r.ReportId = 347
END

-- Create new ReportRule records for AdminUser role
IF NOT EXISTS (SELECT 1 FROM ReportRule Where RoleId = 3 AND ReportId = 347)
BEGIN
	INSERT INTO dbo.ReportRule
		(ReportID, RoleID, LastStatEmployeeID, LastModified)
	VALUES
	(347, 3, 2927, GetDate())
END

