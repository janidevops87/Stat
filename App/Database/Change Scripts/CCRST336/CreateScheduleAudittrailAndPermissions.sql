/******************************************************************************
**		File: CreateNewReportRowsAndPermissions.sql
**		Name: Create new report rows for new portal site and 
				permissions based off of the permissions for the old reporting site
**		Desc: Create new report rows for new portal site and 
				permissions based off of the permissions for the old reporting site
**
**		Auth: Pam Scheichenost	
**		Date: 12/30/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/30/2020	Pam Scheichenost	initial
*******************************************************************************/

DECLARE
@ModifiedDate datetime = GetDate(),
@ReportFolder nvarchar(50) = '/CCRST307ReportingSiteRedesign'; --TODO: Will need to find out report folder for training/production

IF ((SELECT COUNT(*) FROM dbo.Report WHERE ReportId = 345) = 0)
BEGIN
SET IDENTITY_INSERT dbo.Report ON;

INSERT INTO dbo.Report 
(ReportId, ReportDisplayName, LastModified, ReportVirtualURL, ReportTypeID, SourceCodeTypeId) 
VALUES 
(345,'Schedule Audit Trail',@ModifiedDate, @ReportFolder + '/AuditTrailSchedule',7,NULL)
SET IDENTITY_INSERT dbo.Report OFF;
END


IF ((SELECT COUNT(*) FROM dbo.ReportDateTimeConfiguration WHERE ReportId = 345) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration ON;

	INSERT INTO dbo.ReportDateTimeConfiguration
	(ReportDateTimeConfigurationID, ReportID, ReportDateTimeID, IsArchived, IsDateOnly)
	VALUES
	(130, 345, 1, 0, 0)

	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration OFF;
END

IF ((SELECT COUNT(*) FROM dbo.ReportDateTypeConfiguration WHERE ReportId = 345) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration ON;

	INSERT INTO dbo.ReportDateTypeConfiguration
	(ReportDateTypeConfigurationID, ReportID, ReportDateTypeID, ReportDateTypeConfigurationIsDefault)
	VALUES
	(140, 345, 3, 1)
	

	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration OFF;
END



IF ((SELECT COUNT(*) FROM dbo.ReportParamConfiguration WHERE ReportId = 345) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportParamConfiguration ON;

	INSERT INTO dbo.ReportParamConfiguration
	(ReportParamConfiguration, ReportId, ReportControlId)
	VALUES
	(2261, 345, 48),
	(2262, 345,	1),
	(2263, 345,	2),
	(2264, 345,	3),
	(2265, 345,	122)

	SET IDENTITY_INSERT dbo.ReportParamConfiguration OFF;
END





--TODO figure out roleid, etc

IF ((SELECT COUNT(*) FROM dbo.Roles WHERE RoleId = 104) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.Roles ON;

	insert into dbo.Roles
	(RoleID, RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID,LastModified, Inactive)
	SELECT 
	104, 'Report Portal: ' + r.ReportDisplayName, 'Access to ' + r.ReportDisplayName + ' report.', 1564, 1 , GetDate(), 0
	FROM Report r
	WHERE r.ReportId = 345

	SET IDENTITY_INSERT dbo.Roles OFF;
END


IF ((SELECT COUNT(*) FROM dbo.ReportRule WHERE RoleId = 104) = 0)
BEGIN
	--create new records for new reports that match old reports
	INSERT INTO dbo.ReportRule
		(ReportID, RoleID, LastStatEmployeeID, LastModified)
	select r.ReportId, 104, 1564, GETDATE()
	FROM Report r
	WHERE r.ReportId = 345
END


----add certain reports to AdminUser role
IF ((SELECT COUNT(*) FROM ReportRule Where RoleId = 3 AND ReportId = 345) = 0)
BEGIN
	INSERT INTO dbo.ReportRule
		(ReportID, RoleID, LastStatEmployeeID, LastModified)
	values
	(345, 3, 1564, GetDate())
END

